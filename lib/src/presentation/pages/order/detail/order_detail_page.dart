// lib/src/presentation/pages/order/detail/order_detail_page.dart
import 'package:edufy_mobile/src/shared/configs/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edufy_mobile/src/data/models/order/order_item_model.dart';
import 'package:edufy_mobile/src/data/models/order/order_model.dart';
import 'package:edufy_mobile/src/data/models/payment/payment_model.dart';
import 'package:edufy_mobile/src/data/repositories/remote/order/i_order_repository.dart';
import 'order_detail_cubit.dart';
import 'order_detail_state.dart';

class OrderDetailPage extends StatelessWidget {
  final int orderId;

  const OrderDetailPage({
    super.key,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OrderDetailCubit(
        repository: context.read<IOrderRepository>(),
      )..load(orderId),
      child: BlocBuilder<OrderDetailCubit, OrderDetailState>(
        builder: (context, state) {
          final order = state.order;

          return Scaffold(
            appBar: AppBar(
              title: Text(
                order?.orderNumber != null
                    ? 'Đơn hàng ${order!.orderNumber}'
                    : 'Chi tiết đơn hàng',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              actions: [
                if (order != null &&
                    order.status != null &&
                    order.status == 'pending')
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: TextButton(
                      onPressed: state.isCancelling
                          ? null
                          : () {
                              context
                                  .read<OrderDetailCubit>()
                                  .cancel(order.id!);
                            },
                      child: state.isCancelling
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Huỷ đơn'),
                    ),
                  ),
              ],
            ),
            body: Builder(
              builder: (context) {
                if (state.isLoading && order == null) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.exception != null && order == null) {
                  return _ErrorView(
                    message: state.exception?.message ?? 'Đã có lỗi xảy ra',
                    onRetry: () =>
                        context.read<OrderDetailCubit>().load(orderId),
                  );
                }

                if (order == null) {
                  return const Center(child: Text('Không tìm thấy đơn hàng'));
                }

                return RefreshIndicator(
                  onRefresh: () =>
                      context.read<OrderDetailCubit>().refresh(orderId),
                  child: _OrderDetailBody(order: order),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        const SizedBox(height: 80),
        Icon(
          Icons.error_outline,
          size: 48,
          color: AppColors.error,
        ),
        const SizedBox(height: 16),
        Center(
          child: FilledButton(
            onPressed: onRetry,
            child: const Text('Thử lại'),
          ),
        ),
      ],
    );
  }
}

class _OrderDetailBody extends StatelessWidget {
  final OrderModel order;

  const _OrderDetailBody({
    required this.order,
  });

  String _formatMoney(num? value, {String currency = '₫'}) {
    if (value == null) return '';
    return '${value.toStringAsFixed(0)}$currency';
  }

  @override
  Widget build(BuildContext context) {
    final items = order.items ?? [];
    final payments = order.payments ?? [];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _OrderHeader(order: order, formatMoney: _formatMoney),
        const SizedBox(height: 16),
        _Section(
          title: 'Thông tin đơn hàng',
          child: _OrderMeta(order: order),
        ),
        if (items.isNotEmpty) ...[
          const SizedBox(height: 16),
          _Section(
            title: 'Khoá học',
            child: Column(
              children: items
                  .map(
                    (e) => _OrderItemTile(
                      item: e,
                      formatMoney: _formatMoney,
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
        if (payments.isNotEmpty) ...[
          const SizedBox(height: 16),
          _Section(
            title: 'Thanh toán',
            child: Column(
              children: payments
                  .map(
                    (p) => _PaymentTile(
                      payment: p,
                      formatMoney: _formatMoney,
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
        if (order.note != null && order.note!.trim().isNotEmpty) ...[
          const SizedBox(height: 16),
          _Section(
            title: 'Ghi chú',
            child: Text(
              order.note!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textPrimary,
                  ),
            ),
          ),
        ],
      ],
    );
  }
}

class _OrderHeader extends StatelessWidget {
  final OrderModel order;
  final String Function(num?, {String currency}) formatMoney;

  const _OrderHeader({
    required this.order,
    required this.formatMoney,
  });

  Color _statusColor(String? status) {
    switch (status) {
      case 'completed':
      case 'paid':
        return AppColors.success;
      case 'cancelled':
        return AppColors.error;
      case 'pending':
      default:
        return AppColors.info;
    }
  }

  String _statusLabel(String? status) {
    switch (status) {
      case 'completed':
        return 'Hoàn thành';
      case 'paid':
        return 'Đã thanh toán';
      case 'cancelled':
        return 'Đã huỷ';
      case 'pending':
        return 'Đang xử lý';
      default:
        return status ?? 'Không rõ';
    }
  }

  @override
  Widget build(BuildContext context) {
    final total = formatMoney(order.total ?? order.subtotal ?? 0);
    final statusColor = _statusColor(order.status);
    final statusLabel = _statusLabel(order.status);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.08),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              statusLabel,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                total,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              if (order.paymentStatus != null) ...[
                const SizedBox(height: 2),
                Text(
                  'Thanh toán: ${_statusLabel(order.paymentStatus)}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _OrderMeta extends StatelessWidget {
  final OrderModel order;

  const _OrderMeta({
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];

    if (order.orderNumber != null) {
      rows.add(
        _MetaRow(
          label: 'Mã đơn hàng',
          value: order.orderNumber!,
        ),
      );
    }

    if (order.currency != null) {
      rows.add(
        _MetaRow(
          label: 'Tiền tệ',
          value: order.currency!,
        ),
      );
    }

    if (order.paymentMethod != null) {
      rows.add(
        _MetaRow(
          label: 'Phương thức thanh toán',
          value: order.paymentMethod!,
        ),
      );
    }

    if (order.userId != null) {
      rows.add(
        _MetaRow(
          label: 'User ID',
          value: order.userId.toString(),
        ),
      );
    }

    return Column(
      children: rows,
    );
  }
}

class _MetaRow extends StatelessWidget {
  final String label;
  final String value;

  const _MetaRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textPrimary,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderItemTile extends StatelessWidget {
  final OrderItemModel item;
  final String Function(num?, {String currency}) formatMoney;

  const _OrderItemTile({
    required this.item,
    required this.formatMoney,
  });

  @override
  Widget build(BuildContext context) {
    final course = item.course;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.border,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.surfaceMuted,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              (item.quantity ?? 1).toString(),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course?.title ?? 'Khoá học #${item.courseId}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${formatMoney(item.unitPrice ?? 0)} x ${item.quantity ?? 1}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            formatMoney(item.lineTotal ?? 0),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}

class _PaymentTile extends StatelessWidget {
  final PaymentModel payment;
  final String Function(num?, {String currency}) formatMoney;

  const _PaymentTile({
    required this.payment,
    required this.formatMoney,
  });

  String _statusLabel(String? status) {
    switch (status) {
      case 'succeeded':
      case 'paid':
        return 'Thành công';
      case 'failed':
        return 'Thất bại';
      case 'pending':
        return 'Đang xử lý';
      default:
        return status ?? 'Không rõ';
    }
  }

  Color _statusColor(String? status) {
    switch (status) {
      case 'succeeded':
      case 'paid':
        return AppColors.success;
      case 'failed':
        return AppColors.error;
      case 'pending':
      default:
        return AppColors.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    final amount = formatMoney(payment.amount ?? 0);
    final statusLabel = _statusLabel(payment.status);
    final statusColor = _statusColor(payment.status);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.border,
          width: 0.5,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.payment_rounded,
            color: AppColors.textSecondary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  payment.provider ?? 'Thanh toán',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  statusLabel,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: statusColor,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            amount,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final Widget child;

  const _Section({
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}

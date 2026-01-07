// lib/src/presentation/pages/cart/cart_page.dart
import 'package:edufy_mobile/src/shared/configs/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edufy_mobile/src/data/models/cart/cart_item_model.dart';
import 'package:edufy_mobile/src/data/models/cart/cart_model.dart';
import 'package:edufy_mobile/src/data/repositories/remote/cart/i_cart_repository.dart';
import 'cart_cubit.dart';
import 'cart_state.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CartCubit(
        cartRepository: context.read<ICartRepository>(),
      )..load(),
      child: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          final cart = state.cart;
          final items = cart?.items ?? [];

          return Scaffold(
            appBar: AppBar(
              title: const Text('Giỏ hàng'),
            ),
            body: Builder(
              builder: (context) {
                if (state.isLoading && cart == null) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.exception != null && cart == null) {
                  return _ErrorView(
                    message: state.exception?.message ?? 'Đã có lỗi xảy ra',
                    onRetry: () =>
                        context.read<CartCubit>().load(),
                  );
                }

                if (items.isEmpty) {
                  return _EmptyCartView(
                    onBrowse: () {},
                  );
                }

                return RefreshIndicator(
                  onRefresh: () =>
                      context.read<CartCubit>().refresh(),
                  child: _CartBody(cart: cart!, items: items),
                );
              },
            ),
            bottomNavigationBar: cart != null && items.isNotEmpty
                ? _CartBottomBar(cart: cart)
                : null,
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

class _EmptyCartView extends StatelessWidget {
  final VoidCallback onBrowse;

  const _EmptyCartView({
    required this.onBrowse,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.shopping_bag_outlined,
              size: 72,
              color: AppColors.textMuted,
            ),
            const SizedBox(height: 16),
            Text(
              'Giỏ hàng của bạn đang trống',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Khám phá các khoá học và thêm vào giỏ để bắt đầu hành trình học tập.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: onBrowse,
              child: const Text('Khám phá khoá học'),
            ),
          ],
        ),
      ),
    );
  }
}

class _CartBody extends StatelessWidget {
  final CartModel cart;
  final List<CartItemModel> items;

  const _CartBody({
    required this.cart,
    required this.items,
  });

  String _formatMoney(num? value) {
    if (value == null) return '';
    return '${value.toStringAsFixed(0)}₫';
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
      children: [
        Column(
          children: items
              .map(
                (e) => _CartItemTile(
                  item: e,
                  formatMoney: _formatMoney,
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.border,
              width: 0.6,
            ),
          ),
          child: Column(
            children: [
              _RowAmount(
                label: 'Tạm tính',
                value: _formatMoney(cart.subtotal ?? 0),
              ),
              if (cart.discountTotal != null &&
                  (cart.discountTotal ?? 0) > 0) ...[
                const SizedBox(height: 8),
                _RowAmount(
                  label: 'Giảm giá',
                  value: '-${_formatMoney(cart.discountTotal ?? 0)}',
                  valueColor: AppColors.success,
                ),
              ],
              const SizedBox(height: 8),
              const Divider(height: 1),
              const SizedBox(height: 8),
              _RowAmount(
                label: 'Thành tiền',
                value: _formatMoney(cart.total ?? cart.subtotal ?? 0),
                isBold: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CartItemTile extends StatelessWidget {
  final CartItemModel item;
  final String Function(num?) formatMoney;

  const _CartItemTile({
    required this.item,
    required this.formatMoney,
  });

  @override
  Widget build(BuildContext context) {
    final course = item.course;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.border,
          width: 0.6,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.surfaceMuted,
              borderRadius: BorderRadius.circular(10),
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

class _RowAmount extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;
  final Color? valueColor;

  const _RowAmount({
    required this.label,
    required this.value,
    this.isBold = false,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    final baseTextStyle = Theme.of(context).textTheme.bodyMedium;

    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: baseTextStyle?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
        Text(
          value,
          style: baseTextStyle?.copyWith(
            color: valueColor ?? AppColors.textPrimary,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _CartBottomBar extends StatelessWidget {
  final CartModel cart;

  const _CartBottomBar({
    required this.cart,
  });

  String _formatMoney(num? value) {
    if (value == null) return '';
    return '${value.toStringAsFixed(0)}₫';
  }

  @override
  Widget build(BuildContext context) {
    final total = _formatMoney(cart.total ?? cart.subtotal ?? 0);

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16 + 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tổng thanh toán',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    total,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 150,
              child: FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Thanh toán',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

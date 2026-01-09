import 'package:edufy_mobile/src/core/dependencies/ioc.dart';
import 'package:edufy_mobile/src/core/services/payment/payment_gateway_service.dart';
import 'package:edufy_mobile/src/data/models/export.dart';
import 'package:edufy_mobile/src/data/repositories/remote/export.dart';
import 'package:edufy_mobile/src/presentation/pages/course/checkout/course_checkout_cubit.dart';
import 'package:edufy_mobile/src/presentation/pages/course/checkout/course_checkout_state.dart';
import 'package:edufy_mobile/src/shared/configs/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseCheckoutPage extends StatefulWidget {
  final CourseModel course;

  const CourseCheckoutPage({
    super.key,
    required this.course,
  });

  @override
  State<CourseCheckoutPage> createState() => _CourseCheckoutPageState();
}

class _CourseCheckoutPageState extends State<CourseCheckoutPage> {
  final _couponCtl = TextEditingController();

  @override
  void dispose() {
    _couponCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CourseCheckoutCubit>(
      create: (_) => CourseCheckoutCubit(
        orderRepository: locator<IOrderRepository>(),
        paymentRepository: locator<IPaymentRepository>(),
        paymentGatewayService: locator<PaymentGatewayService>(),
      )..initial(course: widget.course),
      child: BlocConsumer<CourseCheckoutCubit, CourseCheckoutState>(
        listener: (context, state) {
          final ex = state.exception;
          if (ex != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(ex.message)),
            );
          }

          if (state.checkoutSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Tạo đơn thành công!')),
            );

            // Nếu muốn trả về OrderModel luôn:
            Navigator.of(context).pop(state.createdOrder);
          }
        },
        builder: (context, state) {
          final cubit = context.read<CourseCheckoutCubit>();

          if (state.isLoading && state.course == null) {
            return Scaffold(
              backgroundColor: AppColors.background,
              body: const Center(child: CircularProgressIndicator()),
            );
          }

          final course = state.course ?? widget.course;

          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(
              title: const Text('Thanh toán khoá học'),
            ),
            body: RefreshIndicator(
              onRefresh: () => cubit.refresh(),
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                children: [
                  _CourseCard(course: course),
                  const SizedBox(height: 12),

                  _Section(
                    title: 'Mã giảm giá',
                    child: Column(
                      children: [
                        TextField(
                          controller: _couponCtl,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            hintText: 'Nhập mã (VD: EDUFY10)',
                            filled: true,
                            fillColor: AppColors.surface,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: AppColors.border.withOpacity(0.8),
                                width: 0.6,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: AppColors.border.withOpacity(0.8),
                                width: 0.6,
                              ),
                            ),
                            suffixIcon: TextButton(
                              onPressed: () {
                                final code = _couponCtl.text.trim();
                                cubit.applyCoupon(code.isEmpty ? null : code);
                              },
                              child: Text(
                                state.couponCode == null ? 'Áp dụng' : 'Cập nhật',
                                style: const TextStyle(color: AppColors.primary),
                              ),
                            ),
                          ),
                          onSubmitted: (v) => cubit.applyCoupon(v.trim().isEmpty ? null : v.trim()),
                        ),
                        if (state.couponCode != null) ...[
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Đang áp dụng: ${state.couponCode}',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: AppColors.textSecondary,
                                      ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  _couponCtl.clear();
                                  cubit.applyCoupon(null);
                                },
                                child: const Text('Gỡ'),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  _Section(
                    title: 'Phương thức thanh toán',
                    child: Column(
                      children: CoursePaymentMethod.values.map((m) {
                        final selected = state.paymentMethod == m;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(14),
                            onTap: () => cubit.selectPaymentMethod(m),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                              decoration: BoxDecoration(
                                color: AppColors.surface,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: AppColors.border.withOpacity(0.8),
                                  width: 0.6,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          m.label,
                                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                color: AppColors.textPrimary,
                                                fontWeight: FontWeight.w700,
                                              ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          m.desc,
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                color: AppColors.textSecondary,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    selected ? Icons.radio_button_checked : Icons.radio_button_off,
                                    color: selected ? AppColors.primary : AppColors.textMuted,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  const SizedBox(height: 12),

                  _Section(
                    title: 'Tóm tắt thanh toán',
                    child: _Summary(state: state),
                  ),

                  const SizedBox(height: 16),

                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: FilledButton(
                      onPressed: state.isSubmitting ? null : () => cubit.submit(),
                      child: state.isSubmitting
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text(
                              state.totalText.isEmpty ? 'Thanh toán' : 'Thanh toán • ${state.totalText}',
                            ),
                    ),
                  ),

                  const SizedBox(height: 10),
                  Text(
                    'Bằng việc nhấn “Thanh toán”, bạn đồng ý với điều khoản sử dụng và chính sách hoàn tiền (nếu có).',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// ===== UI widgets giữ nguyên như bạn đã viết =====

class _CourseCard extends StatelessWidget {
  final CourseModel course;

  const _CourseCard({required this.course});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.border.withOpacity(0.8),
          width: 0.6,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.surfaceMuted,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.menu_book_rounded, color: AppColors.textMuted),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course.title ?? 'Khoá học',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  course.trainingCenter?.name ?? '',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ],
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

  const _Section({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.border.withOpacity(0.8),
          width: 0.6,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}

class _Summary extends StatelessWidget {
  final CourseCheckoutState state;

  const _Summary({required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _RowText(label: 'Tạm tính', value: state.subtotalText),
        const SizedBox(height: 8),
        _RowText(
          label: 'Giảm giá',
          value: state.discountText.isEmpty ? '0đ' : state.discountText,
          valueColor: state.discountAmount > 0 ? AppColors.success : null,
        ),
        const SizedBox(height: 8),
        _RowText(label: 'Phí nền tảng', value: state.platformFeeText),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Divider(height: 1),
        ),
        _RowText(
          label: 'Tổng cộng',
          value: state.totalText,
          isEmphasis: true,
        ),
      ],
    );
  }
}

class _RowText extends StatelessWidget {
  final String label;
  final String value;
  final bool isEmphasis;
  final Color? valueColor;

  const _RowText({
    required this.label,
    required this.value,
    this.isEmphasis = false,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: AppColors.textSecondary,
          fontWeight: isEmphasis ? FontWeight.w800 : FontWeight.w500,
        );

    final valueStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: valueColor ?? (isEmphasis ? AppColors.textPrimary : AppColors.textSecondary),
          fontWeight: isEmphasis ? FontWeight.w900 : FontWeight.w600,
        );

    return Row(
      children: [
        Expanded(child: Text(label, style: labelStyle)),
        Text(value, style: valueStyle),
      ],
    );
  }
}

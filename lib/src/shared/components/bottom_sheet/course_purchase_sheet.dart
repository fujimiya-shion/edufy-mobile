import 'package:edufy_mobile/src/data/models/course/course_model.dart';
import 'package:edufy_mobile/src/shared/configs/export.dart';
import 'package:edufy_mobile/src/shared/utils/app_formatters.dart';
import 'package:flutter/material.dart';

Future<void> showCoursePurchaseSheet(
  BuildContext context,
  CourseModel course,
) {
  final priceText = formatCurrency(course.tuitionFee);

  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      return SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
              Text(
                course.title ?? 'Mua khoá học',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 8),
              if (course.trainingCenter?.name != null)
                Row(
                  children: [
                    const Icon(
                      Icons.school_rounded,
                      size: 16,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      course.trainingCenter!.name!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ],
                ),
              const SizedBox(height: 16),
              Row(
                children: [
                  if (priceText.isNotEmpty)
                    Text(
                      priceText,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Khi đăng ký khoá học, bạn sẽ nhận được:',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 8),
              _Bullet(text: 'Truy cập toàn bộ bài học và tài liệu'),
              _Bullet(text: 'Hỗ trợ giải đáp trong quá trình học'),
              _Bullet(text: 'Cập nhật nội dung mới miễn phí'),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: FilledButton(
                  onPressed: () {
                    // TODO: chuyển sang flow thanh toán / thêm vào giỏ
                    Navigator.of(context).pop();
                  },
                  child: const Text('Xác nhận mua khoá học'),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class _Bullet extends StatelessWidget {
  final String text;

  const _Bullet({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '• ',
            style: TextStyle(color: AppColors.textSecondary),
          ),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:edufy_mobile/src/shared/utils/app_formatters.dart';
import 'package:flutter/material.dart';
import 'package:edufy_mobile/src/data/models/course/course_model.dart';
import 'package:edufy_mobile/src/shared/configs/export.dart';

class CourseActionBar extends StatelessWidget {
  final CourseModel course;
  final VoidCallback? onBuy;
  final bool isFavorite;

  const CourseActionBar({
    super.key,
    required this.course,
    this.onBuy,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    final priceText = formatCurrency(course.tuitionFee);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -1),
            blurRadius: 8,
            color: Color(0x14000000),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Hiển thị giá bên trái (nếu muốn)
          if (priceText.isNotEmpty) ...[
            Text(
              priceText,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(width: 12),
          ],
    
          // Nút mua
          FilledButton(
            onPressed: onBuy ?? () {}, // hiện tại chưa gắn logic thật
            child: const Text('Mua khoá học'),
          ),
        ],
      ),
    );
  }
}

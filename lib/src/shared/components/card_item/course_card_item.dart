import 'package:edufy_mobile/src/data/models/export.dart';
import 'package:edufy_mobile/src/routes/app_router.dart';
import 'package:edufy_mobile/src/shared/configs/export.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CourseCardItem extends StatelessWidget {
  final CourseModel course;
  final VoidCallback? onTap;

  const CourseCardItem({
    super.key,
    required this.course,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final centerName = course.trainingCenter?.name ?? '';
    final tuition = course.tuitionFee;
    final tuitionText =
        tuition != null ? '${tuition.toStringAsFixed(0)} đ' : '';

    return InkWell(
      onTap: onTap ?? () => context.push(AppRouter.courseDetail, extra: course),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CourseCover(path: course.coverImagePath),
          const SizedBox(height: 8),
          Text(
            course.title ?? 'Khoá học',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          if (centerName.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              centerName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),
          ],
          if (tuitionText.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(
              tuitionText,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.accent,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _CourseCover extends StatelessWidget {
  final String? path;

  const _CourseCover({this.path});

  @override
  Widget build(BuildContext context) {
    final hasImage = path != null && path!.isNotEmpty;

    return AspectRatio(
      aspectRatio: 16 / 9,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: hasImage
            ? Image.network(
                path!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    Container(color: AppColors.surfaceMuted),
              )
            : Container(
                color: AppColors.surfaceMuted,
                child: const Icon(
                  Icons.menu_book_outlined,
                  size: 32,
                  color: AppColors.textSecondary,
                ),
              ),
      ),
    );
  }
}

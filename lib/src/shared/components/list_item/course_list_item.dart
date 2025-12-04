import 'package:edufy_mobile/src/data/models/course/course_model.dart';
import 'package:edufy_mobile/src/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../configs/export.dart';

class CourseListItem extends StatelessWidget {
  final CourseModel course;
  final VoidCallback? onTap;

  const CourseListItem({super.key, required this.course, this.onTap,});

  @override
  Widget build(BuildContext context) {
    final trainingCenterName = course.trainingCenter?.name;
    final tuition = course.tuitionFee;
    final level = course.level;
    final durationHours = course.durationHours;

    String? tuitionText;
    if (tuition != null) {
      final intValue = tuition.toInt();
      final str = intValue.toString();
      final buffer = StringBuffer();
      for (int i = 0; i < str.length; i++) {
        final positionFromEnd = str.length - i;
        buffer.write(str[i]);
        if (positionFromEnd > 1 && positionFromEnd % 3 == 1) {
          buffer.write('.');
        }
      }
      tuitionText = '${buffer.toString()} đ';
    }

    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap ?? () {
          context.push(AppRouter.courseDetail, extra: course);
        },
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: AppColors.surfaceMuted,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: course.coverImagePath != null &&
                        course.coverImagePath!.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Image.network(
                          course.coverImagePath!,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) {
                            return const Icon(
                              Icons.image_not_supported_outlined,
                              color: AppColors.textMuted,
                            );
                          },
                        ),
                      )
                    : const Icon(
                        Icons.play_lesson_rounded,
                        color: AppColors.primary,
                      ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (trainingCenterName != null &&
                        trainingCenterName.isNotEmpty)
                      Text(
                        trainingCenterName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    if (trainingCenterName != null &&
                        trainingCenterName.isNotEmpty)
                      const SizedBox(height: 4),
                    Text(
                      course.title ?? 'Khoá học không tên',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                    ),
                    if (course.shortDescription != null &&
                        course.shortDescription!.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        course.shortDescription!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style:
                            Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.textSecondary,
                                  height: 1.4,
                                ),
                      ),
                    ],
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        if (tuitionText != null) ...[
                          Text(
                            tuitionText,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.accent,
                                ),
                          ),
                          const SizedBox(width: 8),
                        ],
                        if (durationHours != null) ...[
                          const Icon(
                            Icons.schedule_rounded,
                            size: 14,
                            color: AppColors.textMuted,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            '$durationHours giờ',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                  color: AppColors.textMuted,
                                ),
                          ),
                          const SizedBox(width: 8),
                        ],
                        if (level != null)
                          Text(
                            level.name,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                  color: AppColors.textMuted,
                                ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

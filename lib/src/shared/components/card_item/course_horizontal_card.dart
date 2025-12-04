import 'package:edufy_mobile/src/data/models/export.dart';
import 'package:edufy_mobile/src/routes/app_router.dart';
import 'package:edufy_mobile/src/shared/configs/export.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CourseHorizontalCard extends StatelessWidget {
  final CourseModel course;
  final VoidCallback? onTap;

  const CourseHorizontalCard({
    super.key,
    required this.course,
    this.onTap,
  });

  /// Dùng cho ListView.height để không bị overflow
  static const double kHeight = 320;

  String _formatTuition(double? fee) {
    if (fee == null) return 'Liên hệ';

    final intValue = fee.toInt();
    final str = intValue.toString();
    final buffer = StringBuffer();

    for (int i = 0; i < str.length; i++) {
      final positionFromEnd = str.length - i;
      buffer.write(str[i]);
      if (positionFromEnd > 1 && positionFromEnd % 3 == 1) {
        buffer.write('.');
      }
    }

    return '${buffer.toString()} đ';
  }

  String? _formatStartDate(DateTime? date) {
    if (date == null) return null;
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month';
  }

  @override
  Widget build(BuildContext context) {
    final trainingCenterName = course.trainingCenter?.name;
    final startDateStr = _formatStartDate(course.startDate);
    final durationHours = course.durationHours;

    return SizedBox(
      width: 260,
      height: CourseHorizontalCard.kHeight,
      child: Material(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        elevation: 0,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap ?? () => context.push(AppRouter.courseDetail, extra: course),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cover image
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: course.coverImagePath != null &&
                          course.coverImagePath!.isNotEmpty
                      ? Image.network(
                          course.coverImagePath!,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) {
                            return Container(
                              color: AppColors.surfaceMuted,
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons.image_not_supported_outlined,
                                color: AppColors.textMuted,
                              ),
                            );
                          },
                        )
                      : Container(
                          color: AppColors.surfaceMuted,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color:
                                      AppColors.primary.withOpacity(0.08),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.play_lesson_rounded,
                                  size: 20,
                                  color: AppColors.primary,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  course.code ?? 'Khoá học Edufy',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(
                                        color: AppColors.textSecondary,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ),

              // Content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (trainingCenterName != null &&
                          trainingCenterName.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.06),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            trainingCenterName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                      if (trainingCenterName != null &&
                          trainingCenterName.isNotEmpty)
                        const SizedBox(height: 8),
                      Text(
                        course.title ?? 'Khoá học không tên',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                      ),
                      const SizedBox(height: 6),
                      if (course.shortDescription != null &&
                          course.shortDescription!.isNotEmpty)
                        Text(
                          course.shortDescription!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                color: AppColors.textSecondary,
                                height: 1.4,
                              ),
                        ),
                      const Spacer(),
                      Row(
                        children: [
                          Text(
                            _formatTuition(course.tuitionFee),
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.accent,
                                ),
                          ),
                          const Spacer(),
                          if (startDateStr != null)
                            Row(
                              children: [
                                const Icon(
                                  Icons.event_rounded,
                                  size: 16,
                                  color: AppColors.textMuted,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Khai giảng $startDateStr',
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
                      if (durationHours != null) ...[
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.schedule_rounded,
                              size: 16,
                              color: AppColors.textMuted,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '$durationHours giờ học',
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

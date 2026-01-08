import 'package:edufy_mobile/src/core/dependencies/ioc.dart';
import 'package:edufy_mobile/src/data/models/export.dart';
import 'package:edufy_mobile/src/presentation/pages/course/widgets/course_action_bar.dart';
import 'package:edufy_mobile/src/routes/app_router.dart';
import 'package:edufy_mobile/src/shared/components/bottom_sheet/course_purchase_sheet.dart';
import 'package:edufy_mobile/src/shared/components/card/training_center_card.dart';
import 'package:edufy_mobile/src/shared/configs/export.dart';
import 'package:edufy_mobile/src/shared/utils/app_formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'course_detail_cubit.dart';
import 'course_detail_state.dart';

class CourseDetailPage extends StatefulWidget {
  final CourseModel? initialCourse;
  final int? courseId;

  const CourseDetailPage({
    super.key,
    this.initialCourse,
    this.courseId,
  }) : assert(
          initialCourse != null || courseId != null,
        );

  @override
  State<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = CourseDetailCubit(
          courseRepository: locator.get(),
        );

        if (widget.initialCourse != null) {
          cubit.setInitialCourse(widget.initialCourse!);
        }

        final id = widget.courseId ?? widget.initialCourse?.id;
        if (id != null && id > 0) {
          cubit.load(id);
        }

        return cubit;
      },
      child: BlocBuilder<CourseDetailCubit, CourseDetailState>(
        builder: (context, state) {
          final course = state.course ?? widget.initialCourse;

          return Scaffold(
            appBar: AppBar(
              surfaceTintColor: Colors.white,
              title: Text(
                course?.title ?? 'Chi tiết khoá học',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            bottomNavigationBar: course != null
                ? CourseActionBar(
                    course: course,
                    onBuy: () {
                      showCoursePurchaseSheet(context, course);
                    },
                    isFavorite: false,
                  )
                : null,
            body: Builder(
              builder: (context) {
                if (state.isLoading && course == null) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.exception != null && course == null) {
                  return _ErrorView(
                    message: state.exception?.message ?? 'Đã có lỗi xảy ra',
                    onRetry: () {
                      final id =
                          widget.courseId ?? widget.initialCourse?.id ?? 0;
                      if (id > 0) {
                        context.read<CourseDetailCubit>().load(id);
                      }
                    },
                  );
                }

                if (course == null) {
                  return const Center(
                    child: Text('Không tìm thấy khoá học'),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    final id =
                        widget.courseId ?? widget.initialCourse?.id ?? 0;
                    if (id > 0) {
                      await context.read<CourseDetailCubit>().refresh(id);
                    }
                  },
                  child: _CourseDetailBody(course: course),
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

  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        const SizedBox(height: 80),
        const Icon(Icons.error_outline, size: 48, color: AppColors.error),
        const SizedBox(height: 16),
        Text(
          'Có lỗi xảy ra',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          message,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
        const SizedBox(height: 24),
        Center(
          child: FilledButton(onPressed: onRetry, child: const Text('Thử lại')),
        ),
      ],
    );
  }
}

class _CourseDetailBody extends StatelessWidget {
  final CourseModel course;

  const _CourseDetailBody({required this.course});

  bool get _isPurchased {
    final value = course.meta?['is_purchased'];
    if (value is bool) return value;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        _CourseHeader(course: course),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _CourseMetaSection(
                course: course,
                onToggleFavorite: () {},
                isFavorite: false,
              ),
              const SizedBox(height: 16),

              // Đơn vị đào tạo
              if (course.trainingCenter != null) ...[
                _Section(
                  title: 'Đơn vị đào tạo',
                  child: TrainingCenterCard(
                    center: course.trainingCenter!,
                    onTap: () {
                      context.push(AppRouter.trainingCenterDetail, extra: course.trainingCenter!);
                    },
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // Giới thiệu khoá học
              if (course.description != null &&
                  course.description!.trim().isNotEmpty)
                _Section(
                  title: 'Giới thiệu khoá học',
                  child: Text(
                    course.description!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                          height: 1.5,
                        ),
                  ),
                )
              else if (course.shortDescription != null &&
                  course.shortDescription!.trim().isNotEmpty)
                _Section(
                  title: 'Giới thiệu khoá học',
                  child: Text(
                    course.shortDescription!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                          height: 1.5,
                        ),
                  ),
                ),

              // Giảng viên
              if (course.teachers != null && course.teachers!.isNotEmpty) ...[
                const SizedBox(height: 16),
                _Section(
                  title: 'Giảng viên',
                  child: Column(
                    children: course.teachers!
                        .map(
                          (t) => ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: CircleAvatar(
                              backgroundColor: AppColors.surfaceMuted,
                              backgroundImage: t.avatarPath != null
                                  ? NetworkImage(t.avatarPath!)
                                  : null,
                              child: t.avatarPath == null
                                  ? Text(
                                      (t.fullName ?? 'GV')
                                          .substring(0, 1)
                                          .toUpperCase(),
                                    )
                                  : null,
                            ),
                            title: Text(
                              t.fullName ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: AppColors.textPrimary,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            subtitle: t.title != null
                                ? Text(
                                    t.title!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color: AppColors.textSecondary,
                                        ),
                                  )
                                : null,
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],

              // Nội dung khoá học
              if (course.lessons != null &&
                  course.lessons!.isNotEmpty) ...[
                const SizedBox(height: 16),
                _CourseLessonsSection(
                  lessons: course.lessons!,
                  isPurchased: _isPurchased,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _CourseLessonsSection extends StatefulWidget {
  final List<LessonModel> lessons;
  final bool isPurchased;

  const _CourseLessonsSection({
    required this.lessons,
    required this.isPurchased,
  });

  @override
  State<_CourseLessonsSection> createState() => _CourseLessonsSectionState();
}

class _CourseLessonsSectionState extends State<_CourseLessonsSection> {
  bool _expanded = true;

  @override
  Widget build(BuildContext context) {
    final totalLessons = widget.lessons.length;

    return _Section(
      title: 'Nội dung khoá học',
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          children: [
            // Header accordion
            InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    // Badge "x bài học"
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        '$totalLessons bài học',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                    const SizedBox(width: 8),

                    // Nếu chưa mua: icon lock + text
                    if (!widget.isPurchased)
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(
                              Icons.lock_outline,
                              size: 16,
                              color: AppColors.textSecondary,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                'Mua khoá học để mở khoá nội dung.',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      const Spacer(),

                    const SizedBox(width: 4),

                    Icon(
                      _expanded
                          ? Icons.keyboard_arrow_up_rounded
                          : Icons.keyboard_arrow_down_rounded,
                      color: AppColors.textSecondary,
                    ),
                  ],
                ),
              ),
            ),

            // Divider giữa header và content
            if (_expanded) const Divider(height: 1),

            // Content (lessons)
            AnimatedCrossFade(
              firstChild: const SizedBox.shrink(),
              secondChild: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  children: widget.lessons
                      .map(
                        (l) => _LessonTile(
                          lesson: l,
                          isLocked: !widget.isPurchased,
                          onTap: () {
                            if (!widget.isPurchased) return;
                            // TODO: mở màn hình học bài
                          },
                        ),
                      )
                      .toList(),
                ),
              ),
              crossFadeState: _expanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 200),
            ),
          ],
        ),
      ),
    );
  }
}

class _LessonTile extends StatelessWidget {
  final LessonModel lesson;
  final bool isLocked;
  final VoidCallback? onTap;

  const _LessonTile({
    required this.lesson,
    required this.isLocked,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final order = lesson.sortOrder ?? 0;
    final title = lesson.title ?? '';
    final summary = lesson.summary;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: isLocked ? null : onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Circle order
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: isLocked
                    ? AppColors.surfaceMuted
                    : AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              alignment: Alignment.center,
              child: Text(
                '$order',
                style: TextStyle(
                  fontSize: 13,
                  color:
                      isLocked ? AppColors.textSecondary : AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Texts
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: isLocked
                              ? AppColors.textSecondary
                              : AppColors.textPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  if (summary != null && summary.trim().isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      summary,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(width: 8),

            // Icon play / lock
            Icon(
              isLocked ? Icons.lock_outline : Icons.play_circle_fill,
              size: 22,
              color: isLocked ? AppColors.textMuted : AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}

class _CourseHeader extends StatelessWidget {
  final CourseModel course;

  const _CourseHeader({required this.course});

  @override
  Widget build(BuildContext context) {
    final image = course.coverImagePath;
    final centerName = course.trainingCenter?.name ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: image != null && image.isNotEmpty
              ? Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(image, fit: BoxFit.cover),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.6),
                            Colors.black.withOpacity(0.1),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 16,
                      right: 16,
                      bottom: 16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (centerName.isNotEmpty)
                            Text(
                              centerName,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(color: Colors.white70),
                            ),
                          const SizedBox(height: 4),
                          Text(
                            course.title ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Container(
                  padding: const EdgeInsets.all(16),
                  color: AppColors.surfaceMuted,
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (centerName.isNotEmpty)
                        Text(
                          centerName,
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(color: AppColors.textSecondary),
                        ),
                      const SizedBox(height: 4),
                      Text(
                        course.title ?? '',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w700,
                            ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
        ),
      ],
    );
  }
}

class _CourseMetaSection extends StatelessWidget {
  final CourseModel course;
  final VoidCallback? onToggleFavorite;
  final bool isFavorite;

  const _CourseMetaSection({
    required this.course,
    this.onToggleFavorite,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    final start = formatDate(course.startDate);
    final end = formatDate(course.endDate);
    final hasDate = start.isNotEmpty || end.isNotEmpty;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Content bên trái chiếm hết phần còn lại
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (course.tuitionFee != null)
                Row(
                  children: [
                    Text(
                      formatCurrency(course.tuitionFee),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(width: 8),
                    if (course.durationHours != null)
                      Text(
                        '${course.durationHours} giờ học',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: AppColors.textSecondary),
                      ),
                  ],
                ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  if (course.level != null)
                    _Chip(
                      icon: Icons.bar_chart_rounded,
                      label: course.level!.name,
                    ),
                  if (course.capacity != null)
                    _Chip(
                      icon: Icons.group_rounded,
                      label: '${course.capacity} học viên',
                    ),
                  if (hasDate)
                    _Chip(
                      icon: Icons.event_rounded,
                      label: start.isNotEmpty && end.isNotEmpty
                          ? '$start - $end'
                          : (start.isNotEmpty ? start : end),
                    ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(width: 12),

        // Nút favorite cố định kích thước
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.surfaceMuted,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: onToggleFavorite ?? () {},
            iconSize: 20,
            padding: EdgeInsets.zero,
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _Chip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surfaceMuted,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.textSecondary),
          const SizedBox(width: 6),
          Text(
            label,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: AppColors.textSecondary),
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

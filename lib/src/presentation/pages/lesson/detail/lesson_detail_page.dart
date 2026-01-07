import 'package:edufy_mobile/src/shared/configs/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edufy_mobile/src/data/models/lesson/lesson_model.dart';
import 'package:edufy_mobile/src/data/models/lesson/lesson_media_model.dart';
import 'package:edufy_mobile/src/data/models/course/course_media_model.dart';
import 'package:edufy_mobile/src/data/repositories/remote/lesson/i_lesson_repository.dart';
import 'lesson_detail_cubit.dart';
import 'lesson_detail_state.dart';

class LessonDetailPage extends StatelessWidget {
  final int lessonId;

  const LessonDetailPage({
    super.key,
    required this.lessonId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LessonDetailCubit(
        repository: context.read<ILessonRepository>(),
      )..load(lessonId),
      child: BlocBuilder<LessonDetailCubit, LessonDetailState>(
        builder: (context, state) {
          final lesson = state.lesson;

          return Scaffold(
            appBar: AppBar(
              title: Text(
                lesson?.title ?? 'Bài học',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            body: Builder(
              builder: (context) {
                if (state.isLoading && lesson == null) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.exception != null && lesson == null) {
                  return _ErrorView(
                    message: state.exception?.message ?? 'Đã có lỗi xảy ra',
                    onRetry: () =>
                        context.read<LessonDetailCubit>().load(lessonId),
                  );
                }

                if (lesson == null) {
                  return const Center(child: Text('Không tìm thấy bài học'));
                }

                return RefreshIndicator(
                  onRefresh: () =>
                      context.read<LessonDetailCubit>().refresh(lessonId),
                  child: _LessonDetailBody(lesson: lesson),
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

class _LessonDetailBody extends StatelessWidget {
  final LessonModel lesson;

  const _LessonDetailBody({required this.lesson});

  @override
  Widget build(BuildContext context) {
    final media = lesson.media ?? [];
    final course = lesson.course;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          lesson.title ?? '',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
        ),
        if (lesson.summary != null && lesson.summary!.trim().isNotEmpty) ...[
          const SizedBox(height: 12),
          Text(
            lesson.summary!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
          ),
        ],
        const SizedBox(height: 20),
        if (course != null)
          _Section(
            title: 'Thuộc khoá học',
            child: Text(
              course.title ?? '',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        if (media.isNotEmpty) ...[
          const SizedBox(height: 20),
          _Section(
            title: 'Học liệu',
            child: Column(
              children: media
                  .map((m) => _LessonMediaItem(media: m))
                  .toList(),
            ),
          ),
        ],
      ],
    );
  }
}

class _LessonMediaItem extends StatelessWidget {
  final LessonMediaModel media;

  const _LessonMediaItem({required this.media});

  CourseMediaModel? get courseMedia => media.courseMedia;

  @override
  Widget build(BuildContext context) {
    final cm = courseMedia;

    final type = (cm?.type ?? '').toLowerCase();
    final title = media.title ?? cm?.title ?? 'Tài liệu';
    final url = cm?.url;

    final subtitle = url ?? '';

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            _buildLeading(type),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  if (subtitle.isNotEmpty)
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14,
              color: AppColors.textMuted,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeading(String type) {
    IconData icon = Icons.insert_drive_file_rounded;

    if (type == 'video') {
      icon = Icons.play_circle_fill_rounded;
    } else if (type == 'image') {
      icon = Icons.image_rounded;
    } else if (type == 'pdf') {
      icon = Icons.picture_as_pdf_rounded;
    } else if (type == 'link' || type == 'url') {
      icon = Icons.link_rounded;
    }

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.surfaceMuted,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        icon,
        size: 26,
        color: AppColors.textSecondary,
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

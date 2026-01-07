import 'package:edufy_mobile/src/shared/configs/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edufy_mobile/src/data/models/teacher/teacher_model.dart';
import 'package:edufy_mobile/src/data/repositories/remote/teacher/i_teacher_repository.dart';
import 'teacher_detail_cubit.dart';
import 'teacher_detail_state.dart';

class TeacherDetailPage extends StatelessWidget {
  final int teacherId;

  const TeacherDetailPage({
    super.key,
    required this.teacherId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TeacherDetailCubit(
        teacherRepository: context.read<ITeacherRepository>(),
      )..load(teacherId),
      child: BlocBuilder<TeacherDetailCubit, TeacherDetailState>(
        builder: (context, state) {
          final teacher = state.teacher;

          return Scaffold(
            appBar: AppBar(
              title: Text(
                teacher?.fullName ?? 'Giảng viên',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            body: Builder(
              builder: (context) {
                if (state.isLoading && teacher == null) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.exception != null && teacher == null) {
                  return _ErrorView(
                    message: state.exception?.message ?? 'Đã có lỗi xảy ra',
                    onRetry: () => context
                        .read<TeacherDetailCubit>()
                        .load(teacherId),
                  );
                }

                if (teacher == null) {
                  return const Center(child: Text('Không tìm thấy giảng viên'));
                }

                return RefreshIndicator(
                  onRefresh: () =>
                      context.read<TeacherDetailCubit>().refresh(teacherId),
                  child: _TeacherDetailBody(teacher: teacher),
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
          child: FilledButton(
            onPressed: onRetry,
            child: const Text('Thử lại'),
          ),
        ),
      ],
    );
  }
}

class _TeacherDetailBody extends StatelessWidget {
  final TeacherModel teacher;

  const _TeacherDetailBody({
    required this.teacher,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Center(
          child: CircleAvatar(
            radius: 48,
            backgroundColor: AppColors.surfaceMuted,
            backgroundImage:
                teacher.avatarPath != null ? NetworkImage(teacher.avatarPath!) : null,
            child: teacher.avatarPath == null
                ? Text(
                    (teacher.fullName ?? 'GV').substring(0, 1).toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: AppColors.textPrimary),
                  )
                : null,
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: Text(
            teacher.fullName ?? '',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
            textAlign: TextAlign.center,
          ),
        ),
        if (teacher.title != null) ...[
          const SizedBox(height: 6),
          Center(
            child: Text(
              teacher.title!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          )
        ],
        const SizedBox(height: 24),
        if (teacher.bio != null && teacher.bio!.trim().isNotEmpty)
          _Section(
            title: 'Giới thiệu',
            child: Text(
              teacher.bio!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textPrimary,
                    height: 1.5,
                  ),
            ),
          ),
        if (teacher.skills != null && teacher.skills!.isNotEmpty) ...[
          const SizedBox(height: 20),
          _Section(
            title: 'Kỹ năng',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: teacher.skills!
                  .map(
                    (s) => Container(
                      padding:
                          const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceMuted,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        s,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          )
        ],
        if (teacher.trainingCenter != null) ...[
          const SizedBox(height: 20),
          _Section(
            title: 'Trung tâm',
            child: Text(
              teacher.trainingCenter!.name ?? '',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textPrimary,
                  ),
            ),
          )
        ],
      ],
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

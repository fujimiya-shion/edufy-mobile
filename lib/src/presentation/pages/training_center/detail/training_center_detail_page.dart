// lib/src/presentation/pages/training_center/detail/training_center_detail_page.dart
import 'package:edufy_mobile/src/core/dependencies/ioc.dart';
import 'package:edufy_mobile/src/data/models/course/course_model.dart';
import 'package:edufy_mobile/src/data/models/training_center/training_center_model.dart';
import 'package:edufy_mobile/src/shared/configs/export.dart';
import 'package:edufy_mobile/src/shared/utils/app_formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'training_center_detail_cubit.dart';
import 'training_center_detail_state.dart';

class TrainingCenterDetailPage extends StatelessWidget {
  final int? centerId;
  final TrainingCenterModel? initialCenter;

  const TrainingCenterDetailPage({
    super.key,
    this.centerId,
    this.initialCenter,
  }) : assert(centerId != null || initialCenter != null);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = TrainingCenterDetailCubit(
          repository: locator.get()
        );

        // Có data sẵn thì show ngay
        if (initialCenter != null) {
          cubit.setInitialCenter(initialCenter!);
        }

        final id = centerId ?? initialCenter?.id;
        if (id != null && id > 0) {
          cubit.load(id);
        }

        return cubit;
      },
      child: BlocBuilder<TrainingCenterDetailCubit, TrainingCenterDetailState>(
        builder: (context, state) {
          final center = state.center ?? initialCenter;

          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(
              surfaceTintColor: Colors.white,
              title: Text(
                center?.name ?? 'Trung tâm đào tạo',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            body: Builder(
              builder: (context) {
                if (state.isLoading && center == null) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.exception != null && center == null) {
                  return _ErrorView(
                    message: state.exception?.message ?? 'Đã có lỗi xảy ra',
                    onRetry: () {
                      final id = centerId ?? initialCenter?.id ?? 0;
                      if (id > 0) {
                        context
                            .read<TrainingCenterDetailCubit>()
                            .load(id);
                      }
                    },
                  );
                }

                if (center == null) {
                  return const Center(
                    child: Text('Không tìm thấy trung tâm'),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    final id = centerId ?? initialCenter?.id ?? 0;
                    if (id > 0) {
                      await context
                          .read<TrainingCenterDetailCubit>()
                          .refresh(id);
                    }
                  },
                  child: _TrainingCenterDetailBody(center: center),
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
        const Icon(
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

class _TrainingCenterDetailBody extends StatelessWidget {
  final TrainingCenterModel center;

  const _TrainingCenterDetailBody({
    required this.center,
  });

  String _buildAddress() {
    final parts = <String>[
      center.addressLine1 ?? '',
      center.addressLine2 ?? '',
      center.city ?? '',
      center.state ?? '',
      center.postalCode ?? '',
      center.country ?? '',
    ].where((e) => e.trim().isNotEmpty).toList();

    return parts.join(', ');
  }

  @override
  Widget build(BuildContext context) {
    final address = _buildAddress();
    final courses = center.courses;

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        _TrainingCenterHeader(center: center),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Chips info
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  if (center.city != null && center.city!.trim().isNotEmpty)
                    _Chip(
                      icon: Icons.location_city_rounded,
                      label: center.city!,
                    ),
                  if (center.country != null &&
                      center.country!.trim().isNotEmpty)
                    _Chip(
                      icon: Icons.public_rounded,
                      label: center.country!,
                    ),
                  if (center.timezone != null &&
                      center.timezone!.trim().isNotEmpty)
                    _Chip(
                      icon: Icons.schedule_rounded,
                      label: center.timezone!,
                    ),
                ],
              ),

              // Giới thiệu trung tâm
              if (center.description != null &&
                  center.description!.trim().isNotEmpty) ...[
                const SizedBox(height: 24),
                _Section(
                  title: 'Giới thiệu trung tâm',
                  child: Text(
                    center.description!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                          height: 1.5,
                        ),
                  ),
                ),
              ],

              // Địa chỉ
              if (address.isNotEmpty) ...[
                const SizedBox(height: 24),
                _Section(
                  title: 'Địa chỉ',
                  child: Text(
                    address,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textPrimary,
                          height: 1.5,
                        ),
                  ),
                ),
              ],

              // Liên hệ
              if ((center.email != null && center.email!.trim().isNotEmpty) ||
                  (center.phone != null && center.phone!.trim().isNotEmpty) ||
                  (center.website != null &&
                      center.website!.trim().isNotEmpty)) ...[
                const SizedBox(height: 24),
                _Section(
                  title: 'Liên hệ',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (center.email != null &&
                          center.email!.trim().isNotEmpty)
                        _ContactRow(
                          icon: Icons.email_outlined,
                          text: center.email!,
                        ),
                      if (center.phone != null &&
                          center.phone!.trim().isNotEmpty)
                        _ContactRow(
                          icon: Icons.phone_outlined,
                          text: center.phone!,
                        ),
                      if (center.website != null &&
                          center.website!.trim().isNotEmpty)
                        _ContactRow(
                          icon: Icons.language_rounded,
                          text: center.website!,
                          isLink: true,
                        ),
                    ],
                  ),
                ),
              ],

              // Khoá học của trung tâm
              if (courses.isNotEmpty) ...[
                const SizedBox(height: 24),
                _Section(
                  title: 'Khoá học tại trung tâm',
                  child: Column(
                    children: courses
                        .map(
                          (c) => _CourseListTile(course: c),
                        )
                        .toList(),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _TrainingCenterHeader extends StatelessWidget {
  final TrainingCenterModel center;

  const _TrainingCenterHeader({required this.center});

  @override
  Widget build(BuildContext context) {
    final cover = center.coverImagePath;
    final name = center.name ?? '';
    final rating = center.rating;
    final reviewCount = center.reviewCount ?? 0;

    final initial =
        (name.isNotEmpty ? name.trim()[0].toUpperCase() : '?');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Cover hero
        AspectRatio(
          aspectRatio: 16 / 9,
          child: cover != null && cover.isNotEmpty
              ? Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      cover,
                      fit: BoxFit.cover,
                    ),
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
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Avatar
                          CircleAvatar(
                            radius: 26,
                            backgroundColor: Colors.white.withOpacity(0.9),
                            backgroundImage: center.avatar != null &&
                                    center.avatar!.trim().isNotEmpty
                                ? NetworkImage(center.avatar!)
                                : null,
                            child: (center.avatar == null ||
                                    center.avatar!.trim().isEmpty)
                                ? Text(
                                    initial,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                      color: AppColors.primary,
                                    ),
                                  )
                                : null,
                          ),
                          const SizedBox(width: 12),
                          // Name + rating
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                                if (rating != null) ...[
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star_rounded,
                                        size: 16,
                                        color: Colors.amber,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        rating.toStringAsFixed(1),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        '($reviewCount đánh giá)',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              color: Colors.white70,
                                            ),
                                      ),
                                    ],
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Container(
                  color: AppColors.surface,
                  padding:
                      const EdgeInsets.fromLTRB(16, 20, 16, 16),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 26,
                        backgroundColor: AppColors.surfaceMuted,
                        backgroundImage: center.avatar != null &&
                                center.avatar!.trim().isNotEmpty
                            ? NetworkImage(center.avatar!)
                            : null,
                        child: (center.avatar == null ||
                                center.avatar!.trim().isEmpty)
                            ? Text(
                                initial,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  color: AppColors.primary,
                                ),
                              )
                            : null,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: AppColors.textPrimary,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                            if (rating != null) ...[
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star_rounded,
                                    size: 16,
                                    color: Colors.amber,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    rating.toStringAsFixed(1),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color: AppColors.textPrimary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '($reviewCount đánh giá)',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color: AppColors.textSecondary,
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ],
    );
  }
}

class _ContactRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isLink;

  const _ContactRow({
    required this.icon,
    required this.text,
    this.isLink = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: AppColors.textSecondary,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: isLink ? AppColors.primary : AppColors.textPrimary,
                    decoration:
                        isLink ? TextDecoration.underline : TextDecoration.none,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CourseListTile extends StatelessWidget {
  final CourseModel course;

  const _CourseListTile({required this.course});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail (tạm thời là hình vuông nhỏ, sau này có thể dùng NetworkImage)
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: AppColors.surfaceMuted,
                borderRadius: BorderRadius.circular(8),
                image: (course.coverImagePath != null &&
                        course.coverImagePath!.trim().isNotEmpty)
                    ? DecorationImage(
                        image: NetworkImage(course.coverImagePath!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.title ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  if (course.shortDescription != null &&
                      course.shortDescription!.trim().isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      course.shortDescription!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ],
                  const SizedBox(height: 4),
                  if (course.tuitionFee != null)
                    Text(
                      formatCurrency(course.tuitionFee),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _Chip({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceMuted,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: AppColors.textSecondary,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
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

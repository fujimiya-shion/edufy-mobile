import 'package:edufy_mobile/src/core/dependencies/ioc.dart';
import 'package:edufy_mobile/src/data/repositories/export.dart';
import 'package:edufy_mobile/src/presentation/pages/root/tabs/course/course_cubit.dart';
import 'package:edufy_mobile/src/presentation/pages/root/tabs/course/course_state.dart';
import 'package:edufy_mobile/src/shared/components/common/scroll_pagination.dart';
import 'package:edufy_mobile/src/shared/components/list_item/course_list_item.dart';
import 'package:edufy_mobile/src/shared/configs/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseTab extends StatefulWidget {
  const CourseTab({super.key});

  @override
  State<CourseTab> createState() => _CourseTabState();
}

class _CourseTabState extends State<CourseTab> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showSortSheet(BuildContext context) {
    final cubit = context.read<CourseCubit>();
    final currentSort = context.read<CourseCubit>().state.filterRequest.sort;

    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      showDragHandle: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Sắp xếp theo giá',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
              ),
              const SizedBox(height: 12),
              _RadioTile(
                title: 'Giá tăng dần',
                value: 'fee_asc',
                groupValue: currentSort,
                onChanged: (v) async {
                  Navigator.of(context).pop();
                  await cubit.setSort(v);
                },
              ),
              _RadioTile(
                title: 'Giá giảm dần',
                value: 'fee_desc',
                groupValue: currentSort,
                onChanged: (v) async {
                  Navigator.of(context).pop();
                  await cubit.setSort(v);
                },
              ),
              _RadioTile(
                title: 'Mới nhất',
                value: 'newest',
                groupValue: currentSort,
                onChanged: (v) async {
                  Navigator.of(context).pop();
                  await cubit.setSort(v);
                },
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                    await cubit.setSort(null);
                  },
                  child: const Text('Bỏ sắp xếp'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showFilterSheet(BuildContext context) {
    final cubit = context.read<CourseCubit>();
    final current = cubit.state.filterRequest;

    final minCtl = TextEditingController(text: current.minFee?.toString() ?? '');
    final maxCtl = TextEditingController(text: current.maxFee?.toString() ?? '');

    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (_) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            16,
            8,
            16,
            18 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Bộ lọc',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: minCtl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Min fee',
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: maxCtl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Max fee',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () async {
                        Navigator.of(context).pop();
                        await cubit.resetFilters();
                      },
                      child: const Text('Reset'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final minFee = double.tryParse(minCtl.text.trim());
                        final maxFee = double.tryParse(maxCtl.text.trim());
                        Navigator.of(context).pop();
                        await cubit.setFeeRange(minFee: minFee, maxFee: maxFee);
                      },
                      child: const Text('Áp dụng'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    ).whenComplete(() {
      minCtl.dispose();
      maxCtl.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CourseCubit>(
      create: (_) => CourseCubit(
        courseRepository: getIt<ICourseRepository>(),
      )..initial(),
      child: BlocConsumer<CourseCubit, CourseState>(
        listener: (context, state) {
          final exception = state.exception;
          if (exception != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(exception.message),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.isLoading && state.courses.isEmpty) {
            return Scaffold(
              backgroundColor: AppColors.background,
              body: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(
              title: const Text('Khoá học'),
            ),
            body: RefreshIndicator(
              onRefresh: () async {
                await context.read<CourseCubit>().refresh();
              },
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: _SearchField(
                      controller: _searchController,
                      initialValue: state.keyword,
                      onSubmitted: (value) {
                        context.read<CourseCubit>().search(value.trim());
                      },
                      onClear: () {
                        _searchController.clear();
                        context.read<CourseCubit>().search('');
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _ActionPill(
                          label: 'Bộ lọc',
                          icon: Icons.tune_rounded,
                          onTap: () => _showFilterSheet(context),
                        ),
                        _ActionPill(
                          label: 'Giá',
                          icon: Icons.swap_vert_rounded,
                          onTap: () => _showSortSheet(context),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: _CourseList(state: state),
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

class _RadioTile extends StatelessWidget {
  final String title;
  final String value;
  final String? groupValue;
  final ValueChanged<String> onChanged;

  const _RadioTile({
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final selected = value == groupValue;
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => onChanged(value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.border.withOpacity(0.8),
            width: 0.6,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            Icon(
              selected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: selected ? AppColors.primary : AppColors.textMuted,
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionPill extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _ActionPill({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: AppColors.border.withOpacity(0.8),
              width: 0.6,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 20, color: AppColors.textPrimary),
              const SizedBox(width: 8),
              Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(width: 6),
              const Icon(
                Icons.expand_more_rounded,
                size: 20,
                color: AppColors.textMuted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  final TextEditingController controller;
  final String initialValue;
  final ValueChanged<String> onSubmitted;
  final VoidCallback onClear;

  const _SearchField({
    required this.controller,
    required this.initialValue,
    required this.onSubmitted,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    if (controller.text != initialValue) {
      controller.text = initialValue;
      controller.selection = TextSelection.fromPosition(
        TextPosition(offset: controller.text.length),
      );
    }

    return TextField(
      controller: controller,
      textInputAction: TextInputAction.search,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
        hintText: 'Tìm kiếm khoá học...',
        prefixIcon: const Icon(Icons.search_rounded),
        suffixIcon: controller.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.close_rounded),
                onPressed: onClear,
              )
            : null,
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
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
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          borderSide: BorderSide(
            color: AppColors.primary,
            width: 1.2,
          ),
        ),
      ),
    );
  }
}

class _CourseList extends StatelessWidget {
  final CourseState state;

  const _CourseList({required this.state});

  @override
  Widget build(BuildContext context) {
    if (state.courses.isEmpty && !state.isLoading) {
      return ListView(
        padding: const EdgeInsets.fromLTRB(16, 80, 16, 24),
        children: [
          const Icon(
            Icons.menu_book_outlined,
            size: 64,
            color: AppColors.textMuted,
          ),
          const SizedBox(height: 12),
          Text(
            'Chưa có khoá học nào',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Text(
            'Vui lòng thử lại sau hoặc thay đổi từ khoá tìm kiếm.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      );
    }

    return ScrollPagination(
      length: state.courses.length,
      currentPage: state.page,
      pageCount: state.pageCount,
      onScrollToEnd: () {
        context.read<CourseCubit>().loadMore();
      },
      itemBuilder: (context, index) {
        final course = state.courses[index];
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
          child: CourseListItem(course: course),
        );
      },
    );
  }
}

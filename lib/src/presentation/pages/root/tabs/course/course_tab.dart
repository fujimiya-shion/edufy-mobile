// lib/src/presentation/pages/root/tabs/course/course_tab.dart
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

  String _formatMoney(double v) {
    final n = v.round();
    final s = n.toString();
    final buf = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      final idxFromEnd = s.length - i;
      buf.write(s[i]);
      if (idxFromEnd > 1 && idxFromEnd % 3 == 1) buf.write('.');
    }
    return '${buf.toString()}₫';
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
                'Sắp xếp',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
              ),
              const SizedBox(height: 12),
              _OptionTile(
                title: 'Giá tăng dần',
                subtitle: 'Khoá học rẻ trước',
                selected: currentSort == 'fee_asc',
                icon: Icons.trending_up_rounded,
                onTap: () async {
                  Navigator.of(context).pop();
                  await cubit.setSort('fee_asc');
                },
              ),
              const SizedBox(height: 10),
              _OptionTile(
                title: 'Giá giảm dần',
                subtitle: 'Khoá học đắt trước',
                selected: currentSort == 'fee_desc',
                icon: Icons.trending_down_rounded,
                onTap: () async {
                  Navigator.of(context).pop();
                  await cubit.setSort('fee_desc');
                },
              ),
              const SizedBox(height: 10),
              _OptionTile(
                title: 'Mới nhất',
                subtitle: 'Cập nhật gần đây',
                selected: currentSort == 'newest',
                icon: Icons.fiber_new_rounded,
                onTap: () async {
                  Navigator.of(context).pop();
                  await cubit.setSort('newest');
                },
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: BorderSide(color: AppColors.primary.withOpacity(0.6)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
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

    String? tempLevel = current.level;

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
        return StatefulBuilder(
          builder: (ctx, setModalState) {
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
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                  ),
                  const SizedBox(height: 14),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Trình độ',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _ChoiceChip(
                        label: 'Cơ bản',
                        selected: tempLevel == 'beginner',
                        onTap: () => setModalState(() => tempLevel = tempLevel == 'beginner' ? null : 'beginner'),
                      ),
                      _ChoiceChip(
                        label: 'Trung cấp',
                        selected: tempLevel == 'intermediate',
                        onTap: () => setModalState(() => tempLevel = tempLevel == 'intermediate' ? null : 'intermediate'),
                      ),
                      _ChoiceChip(
                        label: 'Nâng cao',
                        selected: tempLevel == 'advanced',
                        onTap: () => setModalState(() => tempLevel = tempLevel == 'advanced' ? null : 'advanced'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Học phí',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: _MoneyField(
                          controller: minCtl,
                          hintText: 'Tối thiểu',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _MoneyField(
                          controller: maxCtl,
                          hintText: 'Tối đa',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        _QuickChip(
                          label: 'Dưới 500k',
                          onTap: () {
                            minCtl.text = '';
                            maxCtl.text = '500000';
                            FocusScope.of(context).unfocus();
                          },
                        ),
                        _QuickChip(
                          label: '500k – 1tr',
                          onTap: () {
                            minCtl.text = '500000';
                            maxCtl.text = '1000000';
                            FocusScope.of(context).unfocus();
                          },
                        ),
                        _QuickChip(
                          label: '1tr – 2tr',
                          onTap: () {
                            minCtl.text = '1000000';
                            maxCtl.text = '2000000';
                            FocusScope.of(context).unfocus();
                          },
                        ),
                        _QuickChip(
                          label: 'Trên 2tr',
                          onTap: () {
                            minCtl.text = '2000000';
                            maxCtl.text = '';
                            FocusScope.of(context).unfocus();
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.textPrimary,
                            side: BorderSide(color: AppColors.border.withOpacity(0.9)),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                          onPressed: () async {
                            Navigator.of(context).pop();
                            await cubit.resetFilterOnly();
                          },
                          child: const Text('Reset bộ lọc'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                          onPressed: () async {
                            final minFee = double.tryParse(minCtl.text.trim());
                            final maxFee = double.tryParse(maxCtl.text.trim());

                            Navigator.of(context).pop();

                            await cubit.setLevel(tempLevel);
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
              SnackBar(content: Text(exception.message)),
            );
          }
        },
        builder: (context, state) {
          if (state.isLoading && state.courses.isEmpty) {
            return Scaffold(
              backgroundColor: AppColors.background,
              body: const Center(child: CircularProgressIndicator()),
            );
          }

          final req = state.filterRequest;

          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(
              title: const Text('Khoá học'),
            ),
            body: RefreshIndicator(
              onRefresh: () async => context.read<CourseCubit>().refresh(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
                    child: _SearchField(
                      controller: _searchController,
                      initialValue: state.keyword,
                      onSubmitted: (value) => context.read<CourseCubit>().search(value.trim()),
                      onClear: () {
                        _searchController.clear();
                        context.read<CourseCubit>().search('');
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: _ActionPill(
                            label: 'Bộ lọc',
                            icon: Icons.tune_rounded,
                            highlight: (req.level != null) || (req.minFee != null) || (req.maxFee != null),
                            onTap: () => _showFilterSheet(context),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _ActionPill(
                            label: 'Sắp xếp',
                            icon: Icons.swap_vert_rounded,
                            highlight: req.sort != null,
                            onTap: () => _showSortSheet(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (state.hasActiveFilters)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            if (req.level != null)
                              _ActiveChip(
                                label: req.level == 'beginner'
                                    ? 'Cơ bản'
                                    : req.level == 'intermediate'
                                        ? 'Trung cấp'
                                        : req.level == 'advanced'
                                            ? 'Nâng cao'
                                            : req.level!,
                                onRemove: () => context.read<CourseCubit>().setLevel(null),
                              ),
                            if (req.minFee != null || req.maxFee != null)
                              _ActiveChip(
                                label: '${req.minFee != null ? _formatMoney(req.minFee!) : '0₫'} – ${req.maxFee != null ? _formatMoney(req.maxFee!) : '∞'}',
                                onRemove: () => context.read<CourseCubit>().setFeeRange(minFee: null, maxFee: null),
                              ),
                            if (req.sort != null)
                              _ActiveChip(
                                label: req.sort == 'fee_asc'
                                    ? 'Giá ↑'
                                    : req.sort == 'fee_desc'
                                        ? 'Giá ↓'
                                        : req.sort == 'newest'
                                            ? 'Mới nhất'
                                            : req.sort!,
                                onRemove: () => context.read<CourseCubit>().setSort(null),
                              ),
                            const SizedBox(width: 10),
                            TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: AppColors.primary,
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              onPressed: () => context.read<CourseCubit>().resetAllFilters(),
                              child: const Text('Xoá tất cả'),
                            ),
                          ],
                        ),
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

class _CourseList extends StatelessWidget {
  final CourseState state;

  const _CourseList({required this.state});

  @override
  Widget build(BuildContext context) {
    if (state.courses.isEmpty && !state.isLoading) {
      return ListView(
        padding: const EdgeInsets.fromLTRB(16, 80, 16, 24),
        children: [
          const Icon(Icons.menu_book_outlined, size: 64, color: AppColors.textMuted),
          const SizedBox(height: 12),
          Text(
            'Chưa có khoá học nào',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Text(
            'Vui lòng thử lại sau hoặc thay đổi bộ lọc/từ khoá.',
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
      onScrollToEnd: () => context.read<CourseCubit>().loadMore(),
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

class _SearchField extends StatefulWidget {
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
  State<_SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<_SearchField> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onChanged);
    super.dispose();
  }

  void _onChanged() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (widget.controller.text != widget.initialValue) {
      widget.controller.text = widget.initialValue;
      widget.controller.selection = TextSelection.fromPosition(
        TextPosition(offset: widget.controller.text.length),
      );
    }

    return TextField(
      controller: widget.controller,
      textInputAction: TextInputAction.search,
      onSubmitted: widget.onSubmitted,
      decoration: InputDecoration(
        hintText: 'Tìm kiếm khoá học...',
        prefixIcon: Icon(Icons.search_rounded, color: AppColors.textMuted.withOpacity(0.9)),
        suffixIcon: widget.controller.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.close_rounded),
                onPressed: widget.onClear,
              )
            : null,
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.border.withOpacity(0.9), width: 0.7),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.border.withOpacity(0.9), width: 0.7),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.2),
        ),
      ),
    );
  }
}

class _ActionPill extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool highlight;
  final VoidCallback onTap;

  const _ActionPill({
    required this.label,
    required this.icon,
    required this.onTap,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = highlight ? AppColors.primary.withOpacity(0.55) : AppColors.border.withOpacity(0.85);
    final bgColor = highlight ? AppColors.primaryLight.withOpacity(0.55) : AppColors.surface;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          height: 42,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: borderColor, width: 0.8),
          ),
          child: Row(
            children: [
              Icon(icon, size: 20, color: AppColors.textPrimary),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              const Icon(Icons.expand_more_rounded, size: 20, color: AppColors.textMuted),
            ],
          ),
        ),
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool selected;
  final IconData icon;
  final VoidCallback onTap;

  const _OptionTile({
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final border = selected ? AppColors.primary.withOpacity(0.45) : AppColors.border.withOpacity(0.85);
    final bg = selected ? AppColors.primaryLight.withOpacity(0.55) : AppColors.surface;

    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: border, width: 0.9),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border.withOpacity(0.9), width: 0.8),
              ),
              child: Icon(icon, color: selected ? AppColors.primary : AppColors.textPrimary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
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

class _ChoiceChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _ChoiceChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bg = selected ? AppColors.primary : AppColors.surface;
    final fg = selected ? Colors.white : AppColors.textPrimary;
    final border = selected ? AppColors.primary.withOpacity(0.7) : AppColors.border.withOpacity(0.9);

    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: border, width: 0.9),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: fg,
                fontWeight: FontWeight.w700,
              ),
        ),
      ),
    );
  }
}

class _QuickChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _QuickChip({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
        decoration: BoxDecoration(
          color: AppColors.surfaceMuted,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: AppColors.border.withOpacity(0.85), width: 0.8),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
    );
  }
}

class _MoneyField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const _MoneyField({
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: AppColors.border.withOpacity(0.9), width: 0.7),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: AppColors.border.withOpacity(0.9), width: 0.7),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.2),
        ),
      ),
    );
  }
}

class _ActiveChip extends StatelessWidget {
  final String label;
  final VoidCallback onRemove;

  const _ActiveChip({
    required this.label,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        decoration: BoxDecoration(
          color: AppColors.primaryLight.withOpacity(0.6),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: AppColors.primary.withOpacity(0.35), width: 0.9),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(width: 6),
            InkWell(
              borderRadius: BorderRadius.circular(999),
              onTap: onRemove,
              child: const Padding(
                padding: EdgeInsets.all(2),
                child: Icon(Icons.close_rounded, size: 18, color: AppColors.textPrimary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

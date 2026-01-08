import 'package:edufy_mobile/src/data/repositories/remote/export.dart';
import 'package:edufy_mobile/src/shared/configs/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:edufy_mobile/src/core/dependencies/ioc.dart';
import 'package:edufy_mobile/src/presentation/pages/teacher/listing/teacher_listing_cubit.dart';
import 'package:edufy_mobile/src/presentation/pages/teacher/listing/teacher_listing_state.dart';
import 'package:edufy_mobile/src/routes/app_router.dart';
import 'package:edufy_mobile/src/shared/components/common/scroll_pagination.dart';
import 'package:edufy_mobile/src/shared/components/list_item/teacher_list_item.dart';

class TeacherListingPage extends StatefulWidget {
  const TeacherListingPage({super.key});

  @override
  State<TeacherListingPage> createState() => _TeacherListingPageState();
}

class _TeacherListingPageState extends State<TeacherListingPage> {
  late final TeacherListingCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = TeacherListingCubit(
      teacherRepository: locator.get<ITeacherRepository>(),
    )..initial();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _cubit,
      child: BlocConsumer<TeacherListingCubit, TeacherListingState>(
        listener: (context, state) {
          final ex = state.exception;
          if (ex != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(ex.message)),
            );
          }
        },
        builder: (context, state) {
          if (state.isLoading && state.items.isEmpty) {
            return const Scaffold(
              appBar: _TeacherListingAppBar(),
              body: Center(child: CircularProgressIndicator.adaptive()),
            );
          }

          return Scaffold(
            appBar: const _TeacherListingAppBar(),
            body: RefreshIndicator(
              onRefresh: () async => _cubit.initial(),
              child: state.items.isEmpty
                  ? ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: const [
                        SizedBox(height: 80),
                        Center(child: Text('Chưa có giảng viên nào')),
                      ],
                    )
                  : ScrollPagination(
                      length: state.items.length,
                      currentPage: state.page,
                      pageCount: state.pageCount,
                      onScrollToEnd: _cubit.nextPage,
                      itemBuilder: (context, index) {
                        final item = state.items[index];
                        return Column(
                          children: [
                            TeacherListItem(
                              teacher: item,
                              onTap: () => context.push(
                                AppRouter.teacherDetail,
                                extra: item.id ?? 0,
                              ),
                            ),
                            const Divider(height: 1, color: AppColors.border),
                          ],
                        );
                      },
                    ),
            ),
          );
        },
      ),
    );
  }
}

class _TeacherListingAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const _TeacherListingAppBar();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Giảng viên'),
    );
  }
}

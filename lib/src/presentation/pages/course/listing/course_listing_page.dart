import 'package:edufy_mobile/src/data/repositories/remote/export.dart';
import 'package:edufy_mobile/src/shared/configs/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:edufy_mobile/src/core/dependencies/ioc.dart';
import 'package:edufy_mobile/src/presentation/pages/course/listing/course_listing_cubit.dart';
import 'package:edufy_mobile/src/presentation/pages/course/listing/course_listing_state.dart';
import 'package:edufy_mobile/src/routes/app_router.dart';
import 'package:edufy_mobile/src/shared/components/common/scroll_pagination.dart';
import 'package:edufy_mobile/src/shared/components/list_item/course_list_item.dart';

class CourseListingPage extends StatefulWidget {
  const CourseListingPage({super.key});

  @override
  State<CourseListingPage> createState() => _CourseListingPageState();
}

class _CourseListingPageState extends State<CourseListingPage> {
  late final CourseListingCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = CourseListingCubit(
      courseRepository: locator.get<ICourseRepository>(),
    )..initial();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CourseListingCubit>(
      create: (_) => _cubit,
      child: BlocConsumer<CourseListingCubit, CourseListingState>(
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
              appBar: _CourseListingAppBar(),
              body: Center(child: CircularProgressIndicator.adaptive()),
            );
          }

          return Scaffold(
            appBar: const _CourseListingAppBar(),
            body: RefreshIndicator(
              onRefresh: () async => _cubit.initial(),
              child: state.items.isEmpty
                  ? ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: const [
                        SizedBox(height: 80),
                        Center(child: Text('Chưa có khoá học nào')),
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
                            CourseListItem(
                              course: item,
                              onTap: () => context.push(
                                AppRouter.courseDetail,
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

class _CourseListingAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const _CourseListingAppBar();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Khoá học'),
      centerTitle: false,
    );
  }
}

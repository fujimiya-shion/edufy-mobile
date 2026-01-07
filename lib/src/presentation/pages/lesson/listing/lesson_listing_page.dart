import 'package:edufy_mobile/src/data/repositories/remote/export.dart';
import 'package:edufy_mobile/src/shared/configs/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:edufy_mobile/src/core/dependencies/ioc.dart';
import 'package:edufy_mobile/src/presentation/pages/lesson/listing/lesson_listing_cubit.dart';
import 'package:edufy_mobile/src/presentation/pages/lesson/listing/lesson_listing_state.dart';
import 'package:edufy_mobile/src/routes/app_router.dart';
import 'package:edufy_mobile/src/shared/components/common/scroll_pagination.dart';
import 'package:edufy_mobile/src/shared/components/list_item/lesson_list_item.dart';

class LessonListingPage extends StatefulWidget {
  final int courseId;

  const LessonListingPage({
    super.key,
    required this.courseId,
  });

  @override
  State<LessonListingPage> createState() => _LessonListingPageState();
}

class _LessonListingPageState extends State<LessonListingPage> {
  late final LessonListingCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = LessonListingCubit(
      lessonRepository: getIt.get<ILessonRepository>(),
      courseId: widget.courseId,
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
      child:
          BlocConsumer<LessonListingCubit, LessonListingState>(
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
            return Scaffold(
              appBar: AppBar(
                title: Text('Bài học (Khoá #${widget.courseId})'),
              ),
              body: const Center(child: CircularProgressIndicator.adaptive()),
            );
          }

          return Scaffold(
            appBar: AppBar(
              title: Text('Bài học (Khoá #${widget.courseId})'),
            ),
            body: RefreshIndicator(
              onRefresh: () async => _cubit.initial(),
              child: state.items.isEmpty
                  ? ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: const [
                        SizedBox(height: 80),
                        Center(child: Text('Chưa có bài học nào')),
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
                            LessonListItem(
                              lesson: item,
                              onTap: () => context.push(
                                AppRouter.lessonDetail,
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

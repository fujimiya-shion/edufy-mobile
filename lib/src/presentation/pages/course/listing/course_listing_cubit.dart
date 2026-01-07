import 'dart:async';

import 'package:edufy_mobile/src/data/models/export.dart';
import 'package:edufy_mobile/src/data/repositories/remote/export.dart';
import 'package:edufy_mobile/src/presentation/pages/course/listing/course_listing_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseListingCubit extends Cubit<CourseListingState> {
  final ICourseRepository courseRepository;
  Timer? _debounce;

  CourseListingCubit({required this.courseRepository})
      : super(const CourseListingState());

  Future<void> initial() async {
    emit(state.copyWith(isLoading: true, exception: null));
    await fetchCourses(page: 1, isAppend: false);
    emit(state.copyWith(isLoading: false));
  }

  Future<void> fetchCourses({
    int page = 1,
    bool isAppend = true,
  }) async {
    final apiResult = await courseRepository.index(
      page: page,
      keyword: state.keyword.isEmpty ? null : state.keyword,
    );

    apiResult.when(
      success: (response) {
        final data = response.data ?? <CourseModel>[];
        emit(
          state.copyWith(
            page: page,
            pageCount: response.pageCount,
            items: isAppend ? [...state.items, ...data] : data,
            exception: null,
          ),
        );
      },
      failure: (error) {
        emit(state.copyWith(exception: error));
      },
    );
  }

  Future<void> search(String keyword) async {
    _debounce?.cancel();
    emit(state.copyWith(keyword: keyword));

    _debounce = Timer(const Duration(milliseconds: 300), () async {
      await fetchCourses(page: 1, isAppend: false);
    });
  }

  Future<void> nextPage() async {
    if (state.page >= state.pageCount) return;
    final next = state.page + 1;
    await fetchCourses(page: next);
  }
}

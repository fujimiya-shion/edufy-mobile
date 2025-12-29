// lib/src/presentation/pages/root/tabs/course/course_cubit.dart
import 'package:edufy_mobile/src/data/dtos/course/course_dto.dart';
import 'package:edufy_mobile/src/data/models/export.dart';
import 'package:edufy_mobile/src/data/repositories/export.dart';
import 'package:edufy_mobile/src/presentation/pages/root/tabs/course/course_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseCubit extends Cubit<CourseState> {
  final ICourseRepository courseRepository;

  CourseCubit({required this.courseRepository}) : super(const CourseState());

  Future<void> initial() async {
    if (state.isLoading) return;

    final req = state.filterRequest.copyWith(page: 1);

    emit(
      state.copyWith(
        isLoading: true,
        exception: null,
        page: 1,
        pageCount: 1,
        filterRequest: req,
      ),
    );

    final result = await courseRepository.filter(request: req);

    final exception = result.exception;
    final response = result.response;

    if (exception != null) {
      emit(
        state.copyWith(
          isLoading: false,
          exception: exception,
          courses: const <CourseModel>[],
          page: 1,
          pageCount: 1,
        ),
      );
      return;
    }

    final courses = response?.data ?? const <CourseModel>[];
    final page = response?.page ?? 1;
    final pageCount = response?.pageCount ?? 1;

    emit(
      state.copyWith(
        isLoading: false,
        courses: courses,
        page: page,
        pageCount: pageCount,
        exception: null,
        filterRequest: req.copyWith(page: page),
      ),
    );
  }

  Future<void> refresh() async {
    await initial();
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || state.page >= state.pageCount) return;

    final nextPage = state.page + 1;

    emit(
      state.copyWith(
        isLoadingMore: true,
        exception: null,
      ),
    );

    final req = state.filterRequest.copyWith(page: nextPage);

    final result = await courseRepository.filter(request: req);

    final exception = result.exception;
    final response = result.response;

    if (exception != null) {
      emit(
        state.copyWith(
          isLoadingMore: false,
          exception: exception,
        ),
      );
      return;
    }

    final newCourses = response?.data ?? const <CourseModel>[];
    final page = response?.page ?? nextPage;
    final pageCount = response?.pageCount ?? state.pageCount;

    emit(
      state.copyWith(
        isLoadingMore: false,
        courses: [...state.courses, ...newCourses],
        page: page,
        pageCount: pageCount,
        exception: null,
        filterRequest: req.copyWith(page: page),
      ),
    );
  }

  Future<void> search(String keyword) async {
    final kw = keyword.trim();
    if (kw == state.filterRequest.keyword.trim()) return;

    emit(
      state.copyWith(
        filterRequest: state.filterRequest.copyWith(keyword: kw).resetPage(),
        exception: null,
      ),
    );

    await initial();
  }

  Future<void> setSort(String? sort) async {
    final s = sort?.trim();
    emit(
      state.copyWith(
        filterRequest: state.filterRequest.copyWith(sort: (s == null || s.isEmpty) ? null : s).resetPage(),
        exception: null,
      ),
    );
    await initial();
  }

  Future<void> setLevel(String? level) async {
    final lv = level?.trim();
    emit(
      state.copyWith(
        filterRequest: state.filterRequest.copyWith(level: (lv == null || lv.isEmpty) ? null : lv).resetPage(),
        exception: null,
      ),
    );
    await initial();
  }

  Future<void> setFeeRange({double? minFee, double? maxFee}) async {
    emit(
      state.copyWith(
        filterRequest: state.filterRequest.copyWith(minFee: minFee, maxFee: maxFee).resetPage(),
        exception: null,
      ),
    );
    await initial();
  }

  Future<void> clearKeyword() async {
    emit(
      state.copyWith(
        filterRequest: state.filterRequest.copyWith(keyword: '').resetPage(),
        exception: null,
      ),
    );
    await initial();
  }

  Future<void> resetAllFilters() async {
    final req = CourseFilterRequest(
      page: 1,
      perPage: state.filterRequest.perPage,
    );

    emit(
      state.copyWith(
        filterRequest: req,
        exception: null,
      ),
    );

    await initial();
  }

  Future<void> resetFilterOnly() async {
    final req = CourseFilterRequest(
      page: 1,
      perPage: state.filterRequest.perPage,
      keyword: state.filterRequest.keyword,
    );

    emit(
      state.copyWith(
        filterRequest: req,
        exception: null,
      ),
    );

    await initial();
  }
}

import 'dart:async';

import 'package:edufy_mobile/src/core/network/exception/api_exception.dart';
import 'package:edufy_mobile/src/data/dtos/common/export.dart';
import 'package:edufy_mobile/src/data/models/export.dart';
import 'package:edufy_mobile/src/data/repositories/remote/export.dart';
import 'package:edufy_mobile/src/presentation/pages/teacher/listing/teacher_listing_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeacherListingCubit extends Cubit<TeacherListingState> {
  final ITeacherRepository teacherRepository;
  Timer? _debounce;

  TeacherListingCubit({required this.teacherRepository})
      : super(const TeacherListingState());

  Future<void> initial() async {
    emit(state.copyWith(isLoading: true, exception: null));
    await fetchTeachers(page: 1, isAppend: false);
    emit(state.copyWith(isLoading: false));
  }

  Future<void> fetchTeachers({
    int page = 1,
    bool isAppend = true,
  }) async {
    final apiResult =
        await teacherRepository.index(page: page, keyword: state.keyword);

    apiResult.when(
      success: (PaginationResponse<TeacherModel> res) {
        final data = res.data ?? <TeacherModel>[];
        emit(
          state.copyWith(
            page: page,
            pageCount: res.pageCount,
            items: isAppend ? [...state.items, ...data] : data,
            exception: null,
          ),
        );
      },
      failure: (ApiException error) =>
          emit(state.copyWith(exception: error)),
    );
  }

  Future<void> search(String keyword) async {
    _debounce?.cancel();
    emit(state.copyWith(keyword: keyword));

    _debounce = Timer(const Duration(milliseconds: 300), () async {
      await fetchTeachers(page: 1, isAppend: false);
    });
  }

  Future<void> nextPage() async {
    if (state.page >= state.pageCount) return;
    final next = state.page + 1;
    await fetchTeachers(page: next);
  }
}

import 'package:edufy_mobile/src/core/network/exception/api_exception.dart';
import 'package:edufy_mobile/src/data/dtos/common/export.dart';
import 'package:edufy_mobile/src/data/models/export.dart';
import 'package:edufy_mobile/src/data/repositories/remote/export.dart';
import 'package:edufy_mobile/src/presentation/pages/lesson/listing/lesson_listing_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LessonListingCubit extends Cubit<LessonListingState> {
  final ILessonRepository lessonRepository;
  final int courseId;

  LessonListingCubit({
    required this.lessonRepository,
    required this.courseId,
  }) : super(const LessonListingState());

  Future<void> initial() async {
    emit(state.copyWith(isLoading: true, exception: null));
    await fetchLessons(page: 1, isAppend: false);
    emit(state.copyWith(isLoading: false));
  }

  Future<void> fetchLessons({
    int page = 1,
    bool isAppend = true,
  }) async {
    final apiResult = await lessonRepository.index(
      page: page,
      courseId: courseId,
    );

    apiResult.when(
      success: (PaginationResponse<LessonModel> res) {
        final data = res.data ?? <LessonModel>[];
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

  Future<void> nextPage() async {
    if (state.page >= state.pageCount) return;
    await fetchLessons(page: state.page + 1);
  }
}

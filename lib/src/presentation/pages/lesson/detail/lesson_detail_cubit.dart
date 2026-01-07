// lib/src/presentation/pages/lesson/detail/lesson_detail_cubit.dart
import 'package:edufy_mobile/src/data/repositories/remote/lesson/i_lesson_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'lesson_detail_state.dart';

class LessonDetailCubit extends Cubit<LessonDetailState> {
  final ILessonRepository repository;

  LessonDetailCubit({required this.repository})
      : super(const LessonDetailState());

  Future<void> load(int id) async {
    emit(state.copyWith(isLoading: true, exception: null));

    final apiResult = await repository.getDetail(id);

    apiResult.when(
      success: (response) {
        emit(
          state.copyWith(
            isLoading: false,
            lesson: response.data,
            exception: null,
          ),
        );
      },
      failure: (error) {
        emit(
          state.copyWith(
            isLoading: false,
            exception: error,
          ),
        );
      },
    );
  }

  Future<void> refresh(int id) async {
    await load(id);
  }
}

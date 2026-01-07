import 'package:edufy_mobile/src/data/repositories/remote/teacher/i_teacher_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'teacher_detail_state.dart';

class TeacherDetailCubit extends Cubit<TeacherDetailState> {
  final ITeacherRepository teacherRepository;

  TeacherDetailCubit({required this.teacherRepository})
      : super(const TeacherDetailState());

  Future<void> load(int id) async {
    emit(state.copyWith(isLoading: true, exception: null));

    final apiResult = await teacherRepository.getDetail(id);

    apiResult.when(
      success: (response) {
        emit(
          state.copyWith(
            isLoading: false,
            teacher: response.data,
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

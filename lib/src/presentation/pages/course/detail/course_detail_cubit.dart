import 'package:edufy_mobile/src/data/models/course/course_model.dart';
import 'package:edufy_mobile/src/data/repositories/remote/course/i_course_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'course_detail_state.dart';

class CourseDetailCubit extends Cubit<CourseDetailState> {
  final ICourseRepository courseRepository;

  CourseDetailCubit({required this.courseRepository})
      : super(const CourseDetailState());

  void setInitialCourse(CourseModel course) {
    emit(
      state.copyWith(
        course: course,
        isLoading: false,
        exception: null,
      ),
    );
  }

  Future<void> load(int courseId) async {
    emit(state.copyWith(isLoading: true, exception: null));

    final apiResult = await courseRepository.getDetail(courseId);

    apiResult.when(
      success: (response) {
        emit(
          state.copyWith(
            isLoading: false,
            course: response.data,
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

  Future<void> refresh(int courseId) async {
    await load(courseId);
  }
}

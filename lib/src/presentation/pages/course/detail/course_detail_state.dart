import 'package:edufy_mobile/src/core/network/exception/api_exception.dart';
import 'package:edufy_mobile/src/data/models/course/course_model.dart';

class CourseDetailState {
  final CourseModel? course;
  final bool isLoading;
  final ApiException? exception;

  const CourseDetailState({
    this.course,
    this.isLoading = false,
    this.exception,
  });

  CourseDetailState copyWith({
    CourseModel? course,
    bool? isLoading,
    ApiException? exception,
  }) {
    return CourseDetailState(
      course: course ?? this.course,
      isLoading: isLoading ?? this.isLoading,
      exception: exception,
    );
  }
}

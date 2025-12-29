// lib/src/presentation/pages/root/tabs/course/course_state.dart
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:edufy_mobile/src/core/network/exception/api_exception.dart';
import 'package:edufy_mobile/src/data/dtos/course/course_dto.dart';
import 'package:edufy_mobile/src/data/models/export.dart';
import 'package:equatable/equatable.dart';

part 'course_state.g.dart';

@CopyWith()
class CourseState extends Equatable {
  final bool isLoading;
  final bool isLoadingMore;
  final List<CourseModel> courses;
  final int page;
  final int pageCount;
  final CourseFilterRequest filterRequest;
  final ApiException? exception;

  const CourseState({
    this.isLoading = false,
    this.isLoadingMore = false,
    this.courses = const [],
    this.page = 1,
    this.pageCount = 1,
    this.filterRequest = const CourseFilterRequest(page: 1, perPage: 15),
    this.exception,
  });

  String get keyword => filterRequest.keyword;

  bool get hasActiveFilters {
    final req = filterRequest;
    final kw = req.keyword.trim();
    final lv = req.level?.trim();
    final s = req.sort?.trim();
    return (kw.isNotEmpty) || (lv != null && lv.isNotEmpty) || req.minFee != null || req.maxFee != null || (s != null && s.isNotEmpty);
  }

  @override
  List<Object?> get props => [
        isLoading,
        isLoadingMore,
        courses,
        page,
        pageCount,
        filterRequest,
        exception,
      ];
}

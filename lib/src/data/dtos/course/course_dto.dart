// lib/src/data/dtos/course_filter_dto.dart
import 'package:copy_with_extension/copy_with_extension.dart';

part 'course_dto.g.dart';

@CopyWith()
class CourseFilterRequest {
  final String keyword;
  final String? level;
  final double? minFee;
  final double? maxFee;
  final String? sort; // e.g. 'fee_asc', 'fee_desc', 'newest'
  final int page;
  final int perPage;

  const CourseFilterRequest({
    this.keyword = '',
    this.level,
    this.minFee,
    this.maxFee,
    this.sort,
    this.page = 1,
    this.perPage = 10,
  });

  CourseFilterRequest resetPage() => copyWith(page: 1);

  Map<String, dynamic> toQuery() {
    final Map<String, dynamic> q = {
      'page': page,
      'perpage': perPage,
    };

    final kw = keyword.trim();
    if (kw.isNotEmpty) q['keyword'] = kw;
    if (level != null && level!.trim().isNotEmpty) q['level'] = level!.trim();
    if (minFee != null) q['min_fee'] = minFee;
    if (maxFee != null) q['max_fee'] = maxFee;
    if (sort != null && sort!.trim().isNotEmpty) q['sort'] = sort!.trim();

    return q;
  }
}

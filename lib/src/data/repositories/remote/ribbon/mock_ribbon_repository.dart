import 'package:edufy_mobile/src/core/network/exception/api_exception.dart';
import 'package:edufy_mobile/src/data/dtos/common/export.dart';
import 'package:edufy_mobile/src/data/models/export.dart';
import 'package:edufy_mobile/src/shared/types/api_result.dart';

import 'i_ribbon_repository.dart';

class MockRibbonRepository implements IRibbonRepository {
  const MockRibbonRepository();

  @override
  Future<ApiResult<PaginationResponse<RibbonModel>, ApiException>> getHomeRibbons() async {
    await Future.delayed(const Duration(milliseconds: 250));

    const center = TrainingCenterModel(
      id: 1,
      name: 'The Digital Lab',
      slug: 'the-digital-lab',
    );

    final course1 = CourseModel(
      id: 1,
      title: 'Digital Marketing Foundation',
      shortDescription: 'Khoá nền tảng cho người mới bắt đầu.',
      tuitionFee: 3500000,
      trainingCenter: center,
    );

    final course2 = CourseModel(
      id: 2,
      title: 'Performance Marketing Pro',
      shortDescription: 'Tối ưu quảng cáo đa kênh.',
      tuitionFee: 5200000,
      trainingCenter: center,
    );

    final ribbon1 = RibbonModel(
      id: 1,
      title: 'Khoá đề xuất cho bạn',
      slug: 'recommended',
      status: 1,
      order: 1,
      items: [
        RibbonItemModel(id: 11, ribbonId: 1, courseId: 1, order: 1, course: course1),
        RibbonItemModel(id: 12, ribbonId: 1, courseId: 2, order: 2, course: course2),
      ],
    );

    final ribbon2 = RibbonModel(
      id: 2,
      title: 'Sắp khai giảng',
      slug: 'coming-soon',
      status: 1,
      order: 2,
      items: [
        RibbonItemModel(id: 21, ribbonId: 2, courseId: 1, order: 1, course: course1),
      ],
    );

    return ApiResult(response: PaginationResponse(total: 2, pageCount: 1, page: 1, perPage: 15, data: [ribbon1, ribbon2]));
  }
}

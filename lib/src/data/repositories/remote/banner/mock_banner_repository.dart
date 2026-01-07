import 'package:edufy_mobile/src/core/network/exception/api_exception.dart';
import 'package:edufy_mobile/src/data/dtos/common/pagination_response.dart';
import 'package:edufy_mobile/src/data/models/banner/banner_model.dart';
import 'package:edufy_mobile/src/data/repositories/remote/banner/i_banner_repository.dart';
import 'package:edufy_mobile/src/shared/types/api_result.dart';

class MockBannerRepository implements IBannerRepository {
  const MockBannerRepository();

  @override
  Future<ApiResult<PaginationResponse<BannerModel>, ApiException>> getBanners() async {
    await Future.delayed(const Duration(milliseconds: 250));

    final banner1 = BannerModel(
      id: 1,
      title: 'Ưu đãi mùa khai giảng',
      subtitle: 'Giảm đến 40% cho tất cả khoá học',
      imagePath: 'https://picsum.photos/800/300?random=1',
      linkUrl: '/promotion/sale-40',
      position: 'homepage_top',
      sortOrder: 1,
      status: 'active',
      meta: {
        'background_color': '#F5F9FF',
        'text_color': '#1E3A8A',
      },
    );

    final banner2 = BannerModel(
      id: 2,
      title: 'Khoá mới ra mắt',
      subtitle: 'Performance Marketing Pro',
      imagePath: 'https://picsum.photos/800/300?random=2',
      linkUrl: '/course/performance-marketing-pro',
      position: 'homepage_top',
      sortOrder: 2,
      status: 'active',
      meta: {
        'badge': 'New',
      },
    );

    final response = PaginationResponse(
      total: 2,
      pageCount: 1,
      page: 1,
      perPage: 15,
      data: [banner1, banner2],
    );

    return ApiResult(response: response);
  }
}

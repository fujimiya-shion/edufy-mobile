import 'package:edufy_mobile/src/data/dtos/common/export.dart';
import 'package:edufy_mobile/src/data/dtos/course/course_dto.dart';
import 'package:edufy_mobile/src/data/models/export.dart';
import 'package:edufy_mobile/src/shared/enums/enums.dart';
import 'package:edufy_mobile/src/shared/types/api_result.dart';
import 'package:edufy_mobile/src/core/network/exception/api_exception.dart';

import 'i_course_repository.dart';

class MockCourseRepository implements ICourseRepository {
  // Mock Training Centers
  static final TrainingCenterModel _centerTdl = TrainingCenterModel(
    id: 1,
    name: 'The Digital Lab Training Center',
    slug: 'the-digital-lab',
    code: 'TDL',
    email: 'contact@thedigitallab.edu.vn',
    phone: '0909 999 999',
    website: 'https://thedigitallab.edu.vn',
    addressLine1: '283 Điện Biên Phủ',
    city: 'Bình Thạnh, TP. Hồ Chí Minh',
    country: 'Việt Nam',
    meta: const {
      'type': 'offline',
      'map_url': 'https://maps.google.com/',
    },
  );

  static final TrainingCenterModel _centerEdufy = TrainingCenterModel(
    id: 2,
    name: 'Edufy Academy',
    slug: 'edufy-academy',
    code: 'EDUFY',
    email: 'hello@edufy.vn',
    phone: '0987 654 321',
    website: 'https://edufy.vn',
    addressLine1: '01 Võ Văn Ngân',
    city: 'Thủ Đức, TP. Hồ Chí Minh',
    country: 'Việt Nam',
    meta: const {
      'type': 'online',
    },
  );

  // ===== MOCK LESSONS =====

  static final List<LessonModel> _flutterLessons = [
    const LessonModel(
      id: 1,
      courseId: 1,
      title: 'Giới thiệu Flutter & Setup môi trường',
      slug: 'gioi-thieu-flutter-setup',
      summary: 'Cài đặt Flutter SDK, Android Studio, VSCode và run app đầu tiên.',
      sortOrder: 1,
      status: LessonStatus.published,
      media: [],
    ),
    const LessonModel(
      id: 2,
      courseId: 1,
      title: 'Widgets cơ bản & Layout',
      slug: 'widgets-co-ban-layout',
      summary: 'Tìm hiểu Column, Row, Stack, ListView và cách build UI responsive.',
      sortOrder: 2,
      status: LessonStatus.published,
      media: [],
    ),
    const LessonModel(
      id: 3,
      courseId: 1,
      title: 'State management với Cubit',
      slug: 'state-management-cubit',
      summary: 'Quản lý state với Cubit, lắng nghe state bằng BlocBuilder.',
      sortOrder: 3,
      status: LessonStatus.published,
      media: [],
    ),
    const LessonModel(
      id: 4,
      courseId: 1,
      title: 'Kết nối REST API & Pagination',
      slug: 'rest-api-pagination',
      summary: 'Gọi API, parse JSON, handle loading/error, pagination cơ bản.',
      sortOrder: 4,
      status: LessonStatus.published,
      media: [],
    ),
  ];

  static final List<LessonModel> _laravelLessons = [
    const LessonModel(
      id: 5,
      courseId: 2,
      title: 'Kiến trúc Laravel & Routing',
      slug: 'kien-truc-laravel-routing',
      summary: 'Tổng quan Laravel, MVC, định nghĩa route & controller.',
      sortOrder: 1,
      status: LessonStatus.published,
      media: [],
    ),
    const LessonModel(
      id: 6,
      courseId: 2,
      title: 'Eloquent & Repository Pattern',
      slug: 'eloquent-repository',
      summary: 'Thiết kế Repository, tách logic truy vấn khỏi controller.',
      sortOrder: 2,
      status: LessonStatus.published,
      media: [],
    ),
    const LessonModel(
      id: 7,
      courseId: 2,
      title: 'Xây dựng REST API chuẩn',
      slug: 'build-rest-api',
      summary: 'Resource, pagination, filter, sort, validation & error format.',
      sortOrder: 3,
      status: LessonStatus.published,
      media: [],
    ),
    const LessonModel(
      id: 8,
      courseId: 2,
      title: 'Auth, Permission & Rate limiting',
      slug: 'auth-permission-rate-limit',
      summary: 'JWT / Sanctum, phân quyền, throttling & bảo mật API.',
      sortOrder: 4,
      status: LessonStatus.published,
      media: [],
    ),
  ];

  // ===== MOCK COURSES =====

  static final List<CourseModel> _mockCourses = [
    CourseModel(
      id: 1,
      trainingCenterId: 1,
      trainingCenter: _centerTdl,
      title: 'Flutter Mobile Development',
      slug: 'flutter-mobile-development',
      code: 'FLUTTER-101',
      shortDescription: 'Học Flutter từ cơ bản đến nâng cao, build app thực tế.',
      description:
          'Khoá học Flutter chi tiết dành cho mobile dev:\n\n'
          '- Làm chủ widget cơ bản & nâng cao\n'
          '- State management với Bloc / Cubit\n'
          '- Kết nối REST API, auth, pagination\n'
          '- Triển khai app lên App Store / Play Store',
      level: CourseLevel.beginner,
      durationHours: 36,
      capacity: 25,
      tuitionFee: 1_990_000,
      startDate: DateTime(2025, 1, 10),
      endDate: DateTime(2025, 3, 10),
      coverImagePath: 'https://picsum.photos/seed/flutter/800/450',
      meta: const {
        'tagline': 'Từ Zero tới Publish App',
        'language': 'vi',
        'is_purchased': true, // giả lập đã mua
      },
      teachers: const [],
      lessons: _flutterLessons,
      schedules: const [],
      media: const [],
    ),
    CourseModel(
      id: 2,
      trainingCenterId: 2,
      trainingCenter: _centerEdufy,
      title: 'Laravel API Mastery',
      slug: 'laravel-api-mastery',
      code: 'LARAVEL-201',
      shortDescription: 'Xây dựng RESTful API với Laravel chuẩn thực chiến.',
      description:
          'Khoá học Laravel API Mastery giúp bạn:\n\n'
          '- Thiết kế kiến trúc API sạch, dễ maintain\n'
          '- Áp dụng Repository, Service, DTO\n'
          '- Xử lý auth, permission, rate limiting\n'
          '- Tối ưu performance với cache (Redis)',
      level: CourseLevel.intermediate,
      durationHours: 30,
      capacity: 20,
      tuitionFee: 2_490_000,
      startDate: DateTime(2025, 2, 1),
      endDate: DateTime(2025, 4, 1),
      coverImagePath: 'https://picsum.photos/seed/laravel/800/450',
      meta: const {
        'tagline': 'Build API như team backend chuyên nghiệp',
        'language': 'vi',
        'is_purchased': false, // khoá này chưa mua
      },
      teachers: const [],
      lessons: _laravelLessons,
      schedules: const [],
      media: const [],
    ),
  ];


  @override
  Future<ApiResult<PaginationResponse<CourseModel>, ApiException>> index({
    int page = 1,
    String? keyword,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));

    // Lọc theo keyword (nếu có)
    final lowerKeyword = keyword?.trim().toLowerCase();
    final filtered = (lowerKeyword == null || lowerKeyword.isEmpty)
        ? _mockCourses
        : _mockCourses
            .where(
              (c) =>
                  (c.title?.toLowerCase() ?? '').contains(lowerKeyword) ||
                  (c.shortDescription ?? '')
                      .toLowerCase()
                      .contains(lowerKeyword),
            )
            .toList();

    // Fake pagination
    const pageSize = 10;
    final start = (page - 1) * pageSize;
    final end = (start + pageSize).clamp(0, filtered.length);
    final items =
        start >= filtered.length ? <CourseModel>[] : filtered.sublist(start, end);

    final pagination = PaginationResponse<CourseModel>(
      data: items,
      pageCount: (filtered.length / pageSize).ceil(),
      total: filtered.length,
      page: page,
      perPage: pageSize,
    );

    return ApiResult<PaginationResponse<CourseModel>, ApiException>(
      response: pagination,
    );
  }

  @override
  Future<ApiResult<ObjectResponse<CourseModel>, ApiException>> getDetail(
      int id) async {
    await Future.delayed(const Duration(milliseconds: 250));

    // Tìm trong mock list, nếu không có thì tạo 1 bản fallback nhưng vẫn đầy đủ field cơ bản
    final base = _mockCourses.firstWhere(
      (c) => c.id == id,
      orElse: () => CourseModel(
        id: id,
        trainingCenterId: _centerTdl.id,
        trainingCenter: _centerTdl,
        title: 'Flutter Mobile Development',
        slug: 'flutter-mobile-development',
        code: 'FLUTTER-101',
        shortDescription: 'Khoá học Flutter chi tiết dành cho mobile dev.',
        description:
            'Khoá học Flutter chi tiết dành cho mobile dev, giúp bạn nắm vững Flutter từ cơ bản đến triển khai sản phẩm.',
        level: CourseLevel.beginner,
        durationHours: 36,
        capacity: 25,
        tuitionFee: 1_990_000,
        startDate: DateTime(2025, 1, 10),
        endDate: DateTime(2025, 3, 10),
        coverImagePath: 'https://picsum.photos/seed/flutter-fallback/800/450',
        meta: const {
          'tagline': 'Mock fallback course',
        },
        teachers: const [],
        lessons: const [],
        schedules: const [],
        media: const [],
      ),
    );

    // Nếu sau này cần enrich thêm cho detail, có thể copyWith ở đây
    final model = CourseModel(
      id: base.id,
      trainingCenterId: base.trainingCenterId,
      trainingCenter: base.trainingCenter,
      title: base.title,
      slug: base.slug,
      code: base.code,
      shortDescription: base.shortDescription,
      description: base.description,
      level: base.level,
      status: base.status,
      durationHours: base.durationHours,
      capacity: base.capacity,
      tuitionFee: base.tuitionFee,
      startDate: base.startDate,
      endDate: base.endDate,
      coverImagePath: base.coverImagePath,
      meta: base.meta,
      teachers: base.teachers,
      schedules: base.schedules,
      media: base.media,
      lessons: base.lessons,
    );

    final objectResponse = ObjectResponse<CourseModel>(
      data: model,
    );

    return ApiResult<ObjectResponse<CourseModel>, ApiException>(
      response: objectResponse,
    );
  }

  @override
  Future<ApiResult<PaginationResponse<CourseModel>, ApiException>> filter({CourseFilterRequest request = const CourseFilterRequest(page: 1, perPage: 15)}) {
    // TODO: implement filter
    throw UnimplementedError();
  }
}

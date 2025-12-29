// lib/src/core/dependencies/ioc.dart
import 'package:dio/dio.dart';
import 'package:edufy_mobile/src/core/network/api_client.dart';
import 'package:edufy_mobile/src/data/repositories/banner/export.dart';
import 'package:edufy_mobile/src/data/repositories/export.dart';
import 'package:edufy_mobile/src/presentation/cubits/export.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

enum InstanceNames { mock, persistent }

class Ioc {
  static Future<void> initialize() async {
    // ========== COMMON ==========
    // SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    getIt.registerLazySingleton<SharedPreferences>(() => prefs);

    // Dio + Logger
    final dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );

    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );

    getIt.registerLazySingleton<Dio>(() => dio);
    getIt.registerLazySingleton<ApiClient>(() => ApiClient(getIt.get()));

    // ========== REPOSITORIES ==========

    // --- Course ---
    // persistent (API)
    getIt.registerLazySingleton<ICourseRepository>(
      () => CourseRepository(dio: getIt.get()),
      instanceName: InstanceNames.persistent.name,
    );
    // mock (dump data)
    getIt.registerLazySingleton<ICourseRepository>(
      () => MockCourseRepository(),
      instanceName: InstanceNames.mock.name,
    );
    // default hiện tại: dùng mock
    getIt.registerLazySingleton<ICourseRepository>(
      () => CourseRepository(dio: getIt.get()),
    );

    // --- Cart ---
    getIt.registerLazySingleton<ICartRepository>(
      () => CartRepository(apiClient: getIt.get()),
      instanceName: InstanceNames.persistent.name,
    );
    getIt.registerLazySingleton<ICartRepository>(
      () => MockCartRepository(),
      instanceName: InstanceNames.mock.name,
    );
    getIt.registerLazySingleton<ICartRepository>(
      () => MockCartRepository(),
    );

    // --- Order ---
    getIt.registerLazySingleton<IOrderRepository>(
      () => OrderRepository(apiClient: getIt.get()),
      instanceName: InstanceNames.persistent.name,
    );
    getIt.registerLazySingleton<IOrderRepository>(
      () => MockOrderRepository(),
      instanceName: InstanceNames.mock.name,
    );
    getIt.registerLazySingleton<IOrderRepository>(
      () => MockOrderRepository(),
    );

    // --- Payment ---
    getIt.registerLazySingleton<IPaymentRepository>(
      () => PaymentRepository(apiClient: getIt.get()),
      instanceName: InstanceNames.persistent.name,
    );
    getIt.registerLazySingleton<IPaymentRepository>(
      () => MockPaymentRepository(),
      instanceName: InstanceNames.mock.name,
    );
    getIt.registerLazySingleton<IPaymentRepository>(
      () => MockPaymentRepository(),
    );

        // --- Teacher ---
    getIt.registerLazySingleton<ITeacherRepository>(
      () => TeacherRepository(apiClient: getIt.get()),
      instanceName: InstanceNames.persistent.name,
    );
    getIt.registerLazySingleton<ITeacherRepository>(
      () => const MockTeacherRepository(),
      instanceName: InstanceNames.mock.name,
    );
    getIt.registerLazySingleton<ITeacherRepository>(
      () => const MockTeacherRepository(),
    );

    // --- Training Center ---
    getIt.registerLazySingleton<ITrainingCenterRepository>(
      () => TrainingCenterRepository(apiClient: getIt.get()),
      instanceName: InstanceNames.persistent.name,
    );
    getIt.registerLazySingleton<ITrainingCenterRepository>(
      () => const MockTrainingCenterRepository(),
      instanceName: InstanceNames.mock.name,
    );
    getIt.registerLazySingleton<ITrainingCenterRepository>(
      () => const MockTrainingCenterRepository(),
    );

    // --- Lesson ---
    getIt.registerLazySingleton<ILessonRepository>(
      () => LessonRepository(apiClient: getIt.get()),
      instanceName: InstanceNames.persistent.name,
    );
    getIt.registerLazySingleton<ILessonRepository>(
      () => const MockLessonRepository(),
      instanceName: InstanceNames.mock.name,
    );
    getIt.registerLazySingleton<ILessonRepository>(
      () => const MockLessonRepository(),
    );

    // --- Ribbon ---
    getIt.registerLazySingleton<IRibbonRepository>(
      () => RibbonRepository(apiClient: getIt.get()),
      instanceName: InstanceNames.persistent.name,
    );
    getIt.registerLazySingleton<IRibbonRepository>(
      () => const MockRibbonRepository(),
      instanceName: InstanceNames.mock.name,
    );
    getIt.registerLazySingleton<IRibbonRepository>(
      () => const MockRibbonRepository(),
    );

    // --- FCM Token ---
    getIt.registerLazySingleton<IFcmTokenRepository>(
      () => FcmTokenRepository(apiClient: getIt.get()),
      instanceName: InstanceNames.persistent.name,
    );
    getIt.registerLazySingleton<IFcmTokenRepository>(
      () => MockFcmTokenRepository(),
      instanceName: InstanceNames.mock.name,
    );
    getIt.registerLazySingleton<IFcmTokenRepository>(
      () => MockFcmTokenRepository(),
    );

    // --- Payment Log ---
    getIt.registerLazySingleton<IPaymentLogRepository>(
      () => PaymentLogRepository(apiClient: getIt.get()),
      instanceName: InstanceNames.persistent.name,
    );
    getIt.registerLazySingleton<IPaymentLogRepository>(
      () => const MockPaymentLogRepository(),
      instanceName: InstanceNames.mock.name,
    );
    getIt.registerLazySingleton<IPaymentLogRepository>(
      () => const MockPaymentLogRepository(),
    );

    getIt.registerLazySingleton<IAuthRepository>(
      () => AuthRepository(dio: getIt.get()),
      instanceName: InstanceNames.persistent.name,
    );
    getIt.registerLazySingleton<IAuthRepository>(
      () => const MockAuthRepository(),
      instanceName: InstanceNames.mock.name,
    );
    getIt.registerLazySingleton<IAuthRepository>(
      () => const MockAuthRepository(),
    );

    // --- Banner ---
    getIt.registerLazySingleton<IBannerRepository>(
      () => BannerRepository(dio: getIt.get()),
      instanceName: InstanceNames.persistent.name,
    );
    getIt.registerLazySingleton<IBannerRepository>(
      () => MockBannerRepository(),
      instanceName: InstanceNames.mock.name,
    );
    getIt.registerLazySingleton<IBannerRepository>(
      () => MockBannerRepository(),
    );

    // Cubits
    getIt.registerLazySingleton<AuthCubit>(
      () => AuthCubit(authRepository: getIt<IAuthRepository>()),
    );

  }
}

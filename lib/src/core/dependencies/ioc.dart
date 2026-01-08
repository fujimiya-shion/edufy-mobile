// lib/src/core/dependencies/ioc.dart
import 'package:dio/dio.dart';
import 'package:edufy_mobile/src/core/network/api_client.dart';
import 'package:edufy_mobile/src/data/repositories/local/pref_repository.dart';
import 'package:edufy_mobile/src/data/repositories/remote/banner/export.dart';
import 'package:edufy_mobile/src/data/repositories/remote/export.dart';
import 'package:edufy_mobile/src/presentation/cubits/export.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

enum InstanceNames { mock, persistent }

class Ioc {
  static Future<void> initialize() async {
    // ========== COMMON ==========
    // SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final PrefRepository prefRepository = PrefRepository(preferences: prefs);
    locator.registerLazySingleton<PrefRepository>(() => prefRepository);

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

    locator.registerLazySingleton<Dio>(() => dio);
    locator.registerLazySingleton<ApiClient>(() => ApiClient(locator.get()));

    // ========== REPOSITORIES ==========

    // --- Course ---
    // persistent (API)
    locator.registerLazySingleton<ICourseRepository>(
      () => CourseRepository(dio: locator.get()),
      instanceName: InstanceNames.persistent.name,
    );
    // mock (dump data)
    locator.registerLazySingleton<ICourseRepository>(
      () => MockCourseRepository(),
      instanceName: InstanceNames.mock.name,
    );
    // default hiện tại: dùng mock
    locator.registerLazySingleton<ICourseRepository>(
      () => CourseRepository(dio: locator.get()),
    );

    // --- Cart ---
    locator.registerLazySingleton<ICartRepository>(
      () => CartRepository(apiClient: locator.get()),
      instanceName: InstanceNames.persistent.name,
    );
    locator.registerLazySingleton<ICartRepository>(
      () => MockCartRepository(),
      instanceName: InstanceNames.mock.name,
    );
    locator.registerLazySingleton<ICartRepository>(
      () => MockCartRepository(),
    );

    // --- Order ---
    locator.registerLazySingleton<IOrderRepository>(
      () => OrderRepository(apiClient: locator.get()),
      instanceName: InstanceNames.persistent.name,
    );
    locator.registerLazySingleton<IOrderRepository>(
      () => MockOrderRepository(),
      instanceName: InstanceNames.mock.name,
    );
    locator.registerLazySingleton<IOrderRepository>(
      () => MockOrderRepository(),
    );

    // --- Payment ---
    locator.registerLazySingleton<IPaymentRepository>(
      () => PaymentRepository(apiClient: locator.get()),
      instanceName: InstanceNames.persistent.name,
    );
    locator.registerLazySingleton<IPaymentRepository>(
      () => MockPaymentRepository(),
      instanceName: InstanceNames.mock.name,
    );
    locator.registerLazySingleton<IPaymentRepository>(
      () => MockPaymentRepository(),
    );

        // --- Teacher ---
    locator.registerLazySingleton<ITeacherRepository>(
      () => TeacherRepository(apiClient: locator.get()),
      instanceName: InstanceNames.persistent.name,
    );
    locator.registerLazySingleton<ITeacherRepository>(
      () => const MockTeacherRepository(),
      instanceName: InstanceNames.mock.name,
    );
    locator.registerLazySingleton<ITeacherRepository>(
      () => const MockTeacherRepository(),
    );

    // --- Training Center ---
    locator.registerLazySingleton<ITrainingCenterRepository>(
      () => TrainingCenterRepository(apiClient: locator.get()),
      instanceName: InstanceNames.persistent.name,
    );
    locator.registerLazySingleton<ITrainingCenterRepository>(
      () => const MockTrainingCenterRepository(),
      instanceName: InstanceNames.mock.name,
    );
    locator.registerLazySingleton<ITrainingCenterRepository>(
      () => const MockTrainingCenterRepository(),
    );

    // --- Lesson ---
    locator.registerLazySingleton<ILessonRepository>(
      () => LessonRepository(apiClient: locator.get()),
      instanceName: InstanceNames.persistent.name,
    );
    locator.registerLazySingleton<ILessonRepository>(
      () => const MockLessonRepository(),
      instanceName: InstanceNames.mock.name,
    );
    locator.registerLazySingleton<ILessonRepository>(
      () => const MockLessonRepository(),
    );

    // --- Ribbon ---
    locator.registerLazySingleton<IRibbonRepository>(
      () => RibbonRepository(apiClient: locator.get()),
      instanceName: InstanceNames.persistent.name,
    );
    locator.registerLazySingleton<IRibbonRepository>(
      () => const MockRibbonRepository(),
      instanceName: InstanceNames.mock.name,
    );
    locator.registerLazySingleton<IRibbonRepository>(
      () => const MockRibbonRepository(),
    );

    // --- FCM Token ---
    locator.registerLazySingleton<IFcmTokenRepository>(
      () => FcmTokenRepository(apiClient: locator.get()),
      instanceName: InstanceNames.persistent.name,
    );
    locator.registerLazySingleton<IFcmTokenRepository>(
      () => MockFcmTokenRepository(),
      instanceName: InstanceNames.mock.name,
    );
    locator.registerLazySingleton<IFcmTokenRepository>(
      () => MockFcmTokenRepository(),
    );

    // --- Payment Log ---
    locator.registerLazySingleton<IPaymentLogRepository>(
      () => PaymentLogRepository(apiClient: locator.get()),
      instanceName: InstanceNames.persistent.name,
    );
    locator.registerLazySingleton<IPaymentLogRepository>(
      () => const MockPaymentLogRepository(),
      instanceName: InstanceNames.mock.name,
    );
    locator.registerLazySingleton<IPaymentLogRepository>(
      () => const MockPaymentLogRepository(),
    );

    locator.registerLazySingleton<IAuthRepository>(
      () => AuthRepository(dio: locator.get()),
      instanceName: InstanceNames.persistent.name,
    );
    locator.registerLazySingleton<IAuthRepository>(
      () => const MockAuthRepository(),
      instanceName: InstanceNames.mock.name,
    );
    locator.registerLazySingleton<IAuthRepository>(
      () => AuthRepository(dio: locator.get()),
    );

    // --- Banner ---
    locator.registerLazySingleton<IBannerRepository>(
      () => BannerRepository(dio: locator.get()),
      instanceName: InstanceNames.persistent.name,
    );
    locator.registerLazySingleton<IBannerRepository>(
      () => MockBannerRepository(),
      instanceName: InstanceNames.mock.name,
    );
    locator.registerLazySingleton<IBannerRepository>(
      () => MockBannerRepository(),
    );

    // Cubits
    locator.registerLazySingleton<AuthCubit>(
      () => AuthCubit(authRepository: locator<IAuthRepository>()),
    );

  }
}

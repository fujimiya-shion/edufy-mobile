import 'package:edufy_mobile/src/presentation/pages/cart/cart_page.dart';
// Checkout
import 'package:edufy_mobile/src/presentation/pages/checkout/success/checkout_success_page.dart';
import 'package:edufy_mobile/src/presentation/pages/course/detail/course_detail_page.dart';
// Course
import 'package:edufy_mobile/src/presentation/pages/course/listing/course_listing_page.dart';
import 'package:edufy_mobile/src/presentation/pages/lesson/detail/lesson_detail_page.dart';
// Lesson
import 'package:edufy_mobile/src/presentation/pages/lesson/listing/lesson_listing_page.dart';
import 'package:edufy_mobile/src/presentation/pages/notfound/notfound_page.dart';
import 'package:edufy_mobile/src/presentation/pages/onboarding/onboarding_page.dart';
import 'package:edufy_mobile/src/presentation/pages/order/detail/order_detail_page.dart';
// Order
import 'package:edufy_mobile/src/presentation/pages/order/listing/order_listing_page.dart';
import 'package:edufy_mobile/src/presentation/pages/root/root_page.dart';
// Special pages
import 'package:edufy_mobile/src/presentation/pages/splash/splash_page.dart';
import 'package:edufy_mobile/src/presentation/pages/teacher/detail/teacher_detail_page.dart';
// Teacher
import 'package:edufy_mobile/src/presentation/pages/teacher/listing/teacher_listing_page.dart';
import 'package:edufy_mobile/src/presentation/pages/training_center/detail/training_center_detail_page.dart';
// Training Center
import 'package:edufy_mobile/src/presentation/pages/training_center/listing/training_center_listing_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  // ====== SPECIAL ======
  static const String splash = '/splash';
  static const String root = '/root';
  static const String login = '/login';
  static const String onboarding = '/onboarding';

  // ====== COURSE ======
  static const String courseListing = '/courses';
  static const String courseDetail = '/courses/detail';

  // ====== TEACHER ======
  static const String teacherListing = '/teachers';
  static const String teacherDetail = '/teachers/detail';

  // ====== TRAINING CENTER ======
  static const String trainingCenterListing = '/training-centers';
  static const String trainingCenterDetail = '/training-centers/detail';

  // ====== LESSON ======
  static const String lessonListing = '/lessons';
  static const String lessonDetail = '/lessons/detail';

  // ====== ORDER ======
  static const String orderListing = '/orders';
  static const String orderDetail = '/orders/detail';

  // ====== CART & CHECKOUT ======
  static const String cartDetail = '/cart';
  static const String checkoutSuccess = '/checkout-success';

  static GoRouter build() => GoRouter(
        initialLocation: AppRouter.splash,
        routes: [
          // ====== SPECIAL ======
          GoRoute(
            path: AppRouter.splash,
            builder: (context, state) => const SplashPage(),
          ),
          GoRoute(
            path: AppRouter.root,
            builder: (context, state) => const RootPage(),
          ),

          // ====== COURSE ======
          GoRoute(
            path: AppRouter.courseListing,
            builder: (context, state) => const CourseListingPage(),
          ),
          GoRoute(
            path: AppRouter.courseDetail,
            builder: (context, state) {
              // Ưu tiên lấy từ extra (int), fallback ?id=...
              int id = 0;
              final extra = state.extra;
              if (extra is int) {
                id = extra;
              } else {
                id =
                    int.tryParse(state.uri.queryParameters['id'] ?? '') ?? 0;
              }
              return CourseDetailPage(courseId: id);
            },
          ),

          // ====== TEACHER ======
          GoRoute(
            path: AppRouter.teacherListing,
            builder: (context, state) => const TeacherListingPage(),
          ),
          GoRoute(
            path: AppRouter.teacherDetail,
            builder: (context, state) {
              int id = 0;
              final extra = state.extra;
              if (extra is int) {
                id = extra;
              } else {
                id =
                    int.tryParse(state.uri.queryParameters['id'] ?? '') ?? 0;
              }
              return TeacherDetailPage(teacherId: id);
            },
          ),

          // ====== TRAINING CENTER ======
          GoRoute(
            path: AppRouter.trainingCenterListing,
            builder: (context, state) => const TrainingCenterListingPage(),
          ),
          GoRoute(
            path: AppRouter.trainingCenterDetail,
            builder: (context, state) {
              int id = 0;
              final extra = state.extra;
              if (extra is int) {
                id = extra;
              } else {
                id =
                    int.tryParse(state.uri.queryParameters['id'] ?? '') ?? 0;
              }
              return TrainingCenterDetailPage(centerId: id);
            },
          ),

          // ====== LESSON ======
          GoRoute(
            path: AppRouter.lessonListing,
            builder: (context, state) {
              // Có thể filter theo courseId nếu muốn: ?course_id=...
              final courseId =
                  int.tryParse(state.uri.queryParameters['course_id'] ?? '') ??
                      0;
              return LessonListingPage(courseId: courseId);
            },
          ),
          GoRoute(
            path: AppRouter.lessonDetail,
            builder: (context, state) {
              int id = 0;
              final extra = state.extra;
              if (extra is int) {
                id = extra;
              } else {
                id =
                    int.tryParse(state.uri.queryParameters['id'] ?? '') ?? 0;
              }
              return LessonDetailPage(lessonId: id);
            },
          ),

          // ====== ORDER ======
          GoRoute(
            path: AppRouter.orderListing,
            builder: (context, state) => const OrderListingPage(),
          ),
          GoRoute(
            path: AppRouter.orderDetail,
            builder: (context, state) {
              int id = 0;
              final extra = state.extra;
              if (extra is int) {
                id = extra;
              } else {
                id =
                    int.tryParse(state.uri.queryParameters['id'] ?? '') ?? 0;
              }
              return OrderDetailPage(orderId: id);
            },
          ),

          // ====== CART & CHECKOUT ======
          GoRoute(
            path: AppRouter.cartDetail,
            builder: (context, state) => const CartPage(),
          ),
          GoRoute(
            path: AppRouter.checkoutSuccess,
            builder: (context, state) => const CheckoutSuccessPage(),
          ),

          GoRoute(
            path: AppRouter.onboarding,
            builder: (context, state) => const OnboardingPage(),
          ),
        ],
        errorBuilder: (context, state) => const NotfoundPage(),
      );
}

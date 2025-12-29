class AppEndpoints {
  static const String apiPrefix = '/api/v1';

  // ===== COURSE =====
  static const String courses = '$apiPrefix/courses';
  static String courseDetail(int id) => '$courses/$id';
  static const String coursesFilter = '$courses/filter';

  // ===== TEACHER =====
  static const String teachers = '$apiPrefix/teachers';
  static const String teachersSearch = '$apiPrefix/teachers/search';

  // ===== TRAINING CENTER =====
  static const String trainingCenters = '$apiPrefix/training-centers';
  static const String trainingCentersSearch =
      '$apiPrefix/training-centers/search';

  // ===== LESSON / MEDIA / SCHEDULE / COURSE MEDIA =====
  static const String lessons = '$apiPrefix/lessons';
  static const String lessonMedia = '$apiPrefix/lesson-media';
  static const String courseSchedules = '$apiPrefix/course-schedules';
  static const String courseMedia = '$apiPrefix/course-media';

  // ===== CART =====
  static const String carts = '$apiPrefix/carts';
  static const String cartItems = '$apiPrefix/cart-items';
  static const String cartAddItem = '$apiPrefix/cart/add-item';
  static String cartRemoveItem(int id) => '$apiPrefix/cart/remove-item/$id';
  static const String cartClear = '$apiPrefix/cart/clear';

  // ===== ORDER =====
  static const String orders = '$apiPrefix/orders';
  static const String orderItems = '$apiPrefix/order-items';
  static const String ordersCheckout = '$apiPrefix/orders/checkout';
  static const String ordersMy = '$apiPrefix/orders/my';
  static String orderCancel(int id) => '$apiPrefix/orders/$id/cancel';

  // ===== PAYMENT =====
  static const String payments = '$apiPrefix/payments';
  static const String paymentsCreateIntent = '$apiPrefix/payments/create-intent';
  static const String paymentsConfirm = '$apiPrefix/payments/confirm';
  static const String paymentsWebhook = '$apiPrefix/payments/webhook';
  static const String paymentLogs = '$apiPrefix/payment-logs';

  // ===== RIBBON (homepage sections) =====
  static const String ribbons = '$apiPrefix/ribbons';

  // ===== FCM TOKEN (device registration) =====
  static const String fcmTokens = '$apiPrefix/fcm-tokens';

  // ===== BANNER =====
  static const String banners = '$apiPrefix/banners';

  // User Auth
  static const auth = '$apiPrefix/auth';
  static const userAuth = '$auth/user';
  static const register = '$userAuth/register';
  static const login = '$userAuth/login';
  static const forgotPassword = '$userAuth/forgot-password';
  static const resetPassword = '$userAuth/reset-password';
  static const me = '$userAuth/me';
  static const checkEmailExist = '$userAuth/email-exist';
  static const checkPhoneExist = '$userAuth/phone-exist';
  static const role = '$userAuth/role';
  static String loginSocial(String provider) => '$userAuth/$provider';
  static const deleteAccount = '$apiPrefix/users/me/delete-account';
}

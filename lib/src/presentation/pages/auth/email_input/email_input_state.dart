import 'package:edufy_mobile/src/core/network/exception/api_exception.dart';

class EmailInputState {
  final String email;
  final bool isLoading;
  final bool isGoogleLoading;
  final bool isSuccess;
  final ApiException? exception;

  const EmailInputState({
    this.email = '',
    this.isLoading = false,
    this.isGoogleLoading = false,
    this.isSuccess = false,
    this.exception,
  });

  bool get isEmailValid {
    final value = email.trim();
    if (value.isEmpty) return false;
    // simple email regex
    final regex = RegExp(r'^[\w\.\-]+@([\w\-]+\.)+[\w\-]{2,}$');
    return regex.hasMatch(value);
  }

  EmailInputState copyWith({
    String? email,
    bool? isLoading,
    bool? isGoogleLoading,
    bool? isSuccess,
    ApiException? exception,
    bool clearException = false,
  }) {
    return EmailInputState(
      email: email ?? this.email,
      isLoading: isLoading ?? this.isLoading,
      isGoogleLoading: isGoogleLoading ?? this.isGoogleLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      exception: clearException ? null : exception ?? this.exception,
    );
  }
}

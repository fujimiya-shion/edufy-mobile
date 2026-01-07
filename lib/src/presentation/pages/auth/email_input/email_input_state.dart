import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:edufy_mobile/src/core/network/exception/api_exception.dart';
import 'package:equatable/equatable.dart';

part 'email_input_state.g.dart';

@CopyWith()
class EmailInputState extends Equatable {
  final String email;
  final bool isLoading;
  final bool isGoogleLoading;
  final bool isSuccess;
  final bool isGoogleSuccess;
  final bool? isEmailExist;
  final ApiException? exception;

  const EmailInputState({
    this.email = '',
    this.isLoading = false,
    this.isGoogleLoading = false,
    this.isSuccess = false,
    this.isGoogleSuccess = false,
    this.isEmailExist,
    this.exception,
  });

  bool get isEmailValid {
    final value = email.trim();
    if (value.isEmpty) return false;
    // simple email regex
    final regex = RegExp(r'^[\w\.\-]+@([\w\-]+\.)+[\w\-]{2,}$');
    return regex.hasMatch(value);
  }
  
  @override
  List<Object?> get props => [
    email,
    isLoading,
    isGoogleLoading,
    isSuccess,
    isGoogleSuccess,
    isEmailExist,
    exception
  ];
}

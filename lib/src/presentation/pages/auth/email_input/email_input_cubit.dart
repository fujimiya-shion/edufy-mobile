import 'package:edufy_mobile/src/core/network/exception/api_exception.dart';
import 'package:edufy_mobile/src/data/repositories/auth/i_auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'email_input_state.dart';

class EmailInputCubit extends Cubit<EmailInputState> {
  final IAuthRepository authRepository;

  EmailInputCubit({required this.authRepository})
      : super(const EmailInputState());

  void setEmail(String value) {
    emit(
      state.copyWith(
        email: value,
        isSuccess: false,
        clearException: true,
      ),
    );
  }

  void clearError() {
    emit(state.copyWith(clearException: true));
  }

  Future<void> submitEmail() async {
    if (state.isLoading || state.isGoogleLoading) return;

    final email = state.email.trim();
    if (email.isEmpty || !state.isEmailValid) {
      emit(
        state.copyWith(
          exception: ApiException(message: 'Email không hợp lệ'),
          isSuccess: false,
        ),
      );
      return;
    }

    // emit(state.copyWith(isLoading: true, isSuccess: false, clearException: true));

    // TODO: đổi đúng method theo IAuthRepository của em
  }

  Future<void> signInWithGoogle() async {
    if (state.isLoading || state.isGoogleLoading) return;

    // emit(state.copyWith(isGoogleLoading: true, isSuccess: false, clearException: true));

    // TODO: đổi đúng method theo IAuthRepository của em
  }
}

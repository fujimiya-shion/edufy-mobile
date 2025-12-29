import 'package:edufy_mobile/src/core/network/exception/api_exception.dart';
import 'package:edufy_mobile/src/core/services/google/google_auth_service.dart';
import 'package:edufy_mobile/src/data/repositories/auth/i_auth_repository.dart';
import 'package:edufy_mobile/src/shared/enums/enums.dart';
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
        exception: null
      ),
    );
  }

  void clearError() {
    emit(state.copyWith(exception: null));
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

    emit(state.copyWith(isLoading: true, isSuccess: false, exception: null));

    final apiResult = await authRepository.checkEmailExist(email: email);

    apiResult.when(
      success: (response) {
        emit(
          state.copyWith(
            isLoading: false,
            isSuccess: true,
            isEmailExist: response.data?.exists,
          ),
        );
      },
      failure: (error) {
        emit(
          state.copyWith(
            isLoading: false,
            isSuccess: false,
            exception: error,
            isEmailExist: false,
          ),
        );
      }
    );
  }

  Future<void> signInWithGoogle() async {
    if (state.isLoading || state.isGoogleLoading) return;
    final idToken = await GoogleAuthService.signInAndGetServerAuthCode();
    if(idToken == null) return;
    final apiResult = await authRepository.userSocialLogin(provider: SocialProvider.google.name, idToken: idToken);

    apiResult.when(
      success: (response) {
        emit(
          state.copyWith(
            isGoogleLoading: false,
            isSuccess: true,
            isEmailExist: true,
          ),
        );
      },
      failure: (error) {
        emit(
          state.copyWith(
            isGoogleLoading: false,
            isSuccess: false,
            exception: error,
          ),
        );
      }
    );
  }
}

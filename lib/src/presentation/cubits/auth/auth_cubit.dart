import 'package:edufy_mobile/src/core/dependencies/ioc.dart';
import 'package:edufy_mobile/src/data/models/user/user_model.dart';
import 'package:edufy_mobile/src/data/repositories/local/pref_repository.dart';
import 'package:edufy_mobile/src/data/repositories/remote/auth/i_auth_repository.dart';
import 'package:edufy_mobile/src/presentation/cubits/auth/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final IAuthRepository authRepository;

  AuthCubit({required this.authRepository}) : super(const AuthState());

  Future<void> loadMe() async {
    emit(state.copyWith(isLoading: true, exception: null));

    final apiResult = await authRepository.me();

    apiResult.when(
      success: (response) {
        final user = response.data;
        emit(
          state.copyWith(
            isLoading: false,
            loggedInUser: user,
            isAuthenticated: user != null,
            exception: null,
          ),
        );
      },
      failure: (error) {
        emit(
          state.copyWith(
            isLoading: false,
            loggedInUser: null,
            isAuthenticated: false,
            exception: error,
          ),
        );
      },
    );
  }

  Future<void> refresh() async {
    await loadMe();
  }

  void setUser(UserModel? user) {
    emit(
      state.copyWith(
        loggedInUser: user,
        isAuthenticated: user != null,
        exception: null,
      ),
    );
  }

  void logout() {
    final PrefRepository prefRepository = locator.get<PrefRepository>();
    prefRepository.setUserToken(null);
    emit(
      state.copyWith(
        loggedInUser: null,
        isAuthenticated: false,
        exception: null,
      ),
    );
  }
}

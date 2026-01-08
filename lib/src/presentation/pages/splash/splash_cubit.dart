import 'package:edufy_mobile/src/core/dependencies/ioc.dart';
import 'package:edufy_mobile/src/data/repositories/local/pref_repository.dart';
import 'package:edufy_mobile/src/data/repositories/remote/export.dart';
import 'package:edufy_mobile/src/presentation/cubits/export.dart';
import 'package:edufy_mobile/src/presentation/pages/splash/splash_state.dart';
import 'package:edufy_mobile/src/shared/enums/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashCubit extends Cubit<SplashState> {
  final IAuthRepository authRepository;
  final PrefRepository prefRepository;

  SplashCubit({
    required this.authRepository,
    required this.prefRepository,
  }) : super(SplashState());

  Future<void> checkAuthenticated() async {
    emit(state.copyWith(status: AppStatus.loading, exception: null));

    final token = prefRepository.userToken;

    if(token.isEmpty) {
      emit(state.copyWith(status: AppStatus.error));
    }

    final apiResult = await authRepository.me();
    apiResult.when(
      success: (response) async {
        final authCubit = locator.get<AuthCubit>();
        authCubit.setUser(response.data);
        emit(state.copyWith(status: AppStatus.success));
      },
      failure: (_) => emit(state.copyWith(status: AppStatus.error)),
    );
  }
}
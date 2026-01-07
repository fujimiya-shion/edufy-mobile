import 'package:edufy_mobile/src/data/models/banner/banner_model.dart';
import 'package:edufy_mobile/src/data/models/export.dart';
import 'package:edufy_mobile/src/data/repositories/remote/banner/i_banner_repository.dart';
import 'package:edufy_mobile/src/data/repositories/remote/export.dart';
import 'package:edufy_mobile/src/presentation/pages/root/tabs/home/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  final IRibbonRepository ribbonRepository;
  final IBannerRepository bannerRepository;

  HomeCubit({
    required this.ribbonRepository,
    required this.bannerRepository,
  }) : super(const HomeState());

  Future<void> initial() async {
    if (state.isLoading) return;

    emit(
      state.copyWith(
        isLoading: true,
        exception: null,
      ),
    );

    final ribbonsResult = await ribbonRepository.getHomeRibbons();
    final bannersResult = await bannerRepository.getBanners();

    final ribbons = ribbonsResult.response?.data ?? const <RibbonModel>[];
    final banners = bannersResult.response?.data ?? const <BannerModel>[];

    final exception = ribbonsResult.exception ?? bannersResult.exception;

    emit(
      state.copyWith(
        isLoading: false,
        ribbons: ribbons,
        banners: banners,
        exception: exception,
      ),
    );
  }
}

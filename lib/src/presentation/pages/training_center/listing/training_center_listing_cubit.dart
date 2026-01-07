import 'package:edufy_mobile/src/core/network/exception/api_exception.dart';
import 'package:edufy_mobile/src/data/dtos/common/export.dart';
import 'package:edufy_mobile/src/data/models/export.dart';
import 'package:edufy_mobile/src/data/repositories/remote/export.dart';
import 'package:edufy_mobile/src/presentation/pages/training_center/listing/training_center_listing_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrainingCenterListingCubit extends Cubit<TrainingCenterListingState> {
  final ITrainingCenterRepository repository;

  TrainingCenterListingCubit({required this.repository})
      : super(const TrainingCenterListingState());

  Future<void> initial() async {
    emit(state.copyWith(isLoading: true, exception: null));
    await fetchCenters(page: 1, isAppend: false);
    emit(state.copyWith(isLoading: false));
  }

  Future<void> fetchCenters({
    int page = 1,
    bool isAppend = true,
  }) async {
    final apiResult = await repository.index(page: page);

    apiResult.when(
      success: (PaginationResponse<TrainingCenterModel> res) {
        final data = res.data ?? <TrainingCenterModel>[];
        emit(
          state.copyWith(
            page: page,
            pageCount: res.pageCount,
            items: isAppend ? [...state.items, ...data] : data,
            exception: null,
          ),
        );
      },
      failure: (ApiException error) =>
          emit(state.copyWith(exception: error)),
    );
  }

  Future<void> nextPage() async {
    if (state.page >= state.pageCount) return;
    await fetchCenters(page: state.page + 1);
  }
}

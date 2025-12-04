// lib/src/presentation/pages/training_center/detail/training_center_detail_cubit.dart
import 'package:edufy_mobile/src/data/models/training_center/training_center_model.dart';
import 'package:edufy_mobile/src/data/repositories/training_center/i_training_center_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'training_center_detail_state.dart';

class TrainingCenterDetailCubit extends Cubit<TrainingCenterDetailState> {
  final ITrainingCenterRepository repository;

  TrainingCenterDetailCubit({required this.repository})
      : super(const TrainingCenterDetailState());

  /// Dùng khi màn detail được push kèm sẵn TrainingCenterModel (từ CourseDetail)
  /// để avoid flash trắng & có UI ngay lập tức.
  void setInitialCenter(TrainingCenterModel center) {
    emit(
      state.copyWith(
        center: center,
        isLoading: false, // có data rồi thì đừng show loading full screen
        exception: null,
      ),
    );
  }

  Future<void> load(int id) async {
    // nếu id trùng với current center.id thì vẫn cho reload để sync server
    emit(state.copyWith(isLoading: true, exception: null));

    final apiResult = await repository.getDetail(id);

    apiResult.when(
      success: (response) {
        emit(
          state.copyWith(
            isLoading: false,
            center: response.data,
            exception: null,
          ),
        );
      },
      failure: (error) {
        emit(
          state.copyWith(
            isLoading: false,
            exception: error,
          ),
        );
      },
    );
  }

  Future<void> refresh(int id) async {
    await load(id);
  }
}

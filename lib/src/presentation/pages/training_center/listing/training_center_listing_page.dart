import 'package:edufy_mobile/src/data/repositories/remote/export.dart';
import 'package:edufy_mobile/src/shared/configs/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:edufy_mobile/src/core/dependencies/ioc.dart';
import 'package:edufy_mobile/src/presentation/pages/training_center/listing/training_center_listing_cubit.dart';
import 'package:edufy_mobile/src/presentation/pages/training_center/listing/training_center_listing_state.dart';
import 'package:edufy_mobile/src/routes/app_router.dart';
import 'package:edufy_mobile/src/shared/components/common/scroll_pagination.dart';
import 'package:edufy_mobile/src/shared/components/list_item/training_center_list_item.dart';

class TrainingCenterListingPage extends StatefulWidget {
  const TrainingCenterListingPage({super.key});

  @override
  State<TrainingCenterListingPage> createState() =>
      _TrainingCenterListingPageState();
}

class _TrainingCenterListingPageState
    extends State<TrainingCenterListingPage> {
  late final TrainingCenterListingCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = TrainingCenterListingCubit(
      repository: getIt.get<ITrainingCenterRepository>(),
    )..initial();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _cubit,
      child: BlocConsumer<TrainingCenterListingCubit,
          TrainingCenterListingState>(
        listener: (context, state) {
          final ex = state.exception;
          if (ex != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(ex.message)),
            );
          }
        },
        builder: (context, state) {
          if (state.isLoading && state.items.isEmpty) {
            return const Scaffold(
              appBar: _TrainingCenterAppBar(),
              body: Center(child: CircularProgressIndicator.adaptive()),
            );
          }

          return Scaffold(
            appBar: const _TrainingCenterAppBar(),
            body: RefreshIndicator(
              onRefresh: () async => _cubit.initial(),
              child: state.items.isEmpty
                  ? ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: const [
                        SizedBox(height: 80),
                        Center(child: Text('Chưa có trung tâm nào')),
                      ],
                    )
                  : ScrollPagination(
                      length: state.items.length,
                      currentPage: state.page,
                      pageCount: state.pageCount,
                      onScrollToEnd: _cubit.nextPage,
                      itemBuilder: (context, index) {
                        final item = state.items[index];
                        return Column(
                          children: [
                            TrainingCenterListItem(
                              center: item,
                              onTap: () => context.push(
                                AppRouter.trainingCenterDetail,
                                extra: item.id ?? 0,
                              ),
                            ),
                            const Divider(height: 1, color: AppColors.border),
                          ],
                        );
                      },
                    ),
            ),
          );
        },
      ),
    );
  }
}

class _TrainingCenterAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const _TrainingCenterAppBar();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Trung tâm đào tạo'),
    );
  }
}

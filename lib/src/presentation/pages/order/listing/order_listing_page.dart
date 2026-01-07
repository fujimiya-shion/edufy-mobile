import 'package:edufy_mobile/src/data/repositories/remote/export.dart';
import 'package:edufy_mobile/src/shared/configs/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:edufy_mobile/src/core/dependencies/ioc.dart';
import 'package:edufy_mobile/src/presentation/pages/order/listing/order_listing_cubit.dart';
import 'package:edufy_mobile/src/presentation/pages/order/listing/order_listing_state.dart';
import 'package:edufy_mobile/src/routes/app_router.dart';
import 'package:edufy_mobile/src/shared/components/common/scroll_pagination.dart';
import 'package:edufy_mobile/src/shared/components/list_item/order_list_item.dart';

class OrderListingPage extends StatefulWidget {
  const OrderListingPage({super.key});

  @override
  State<OrderListingPage> createState() => _OrderListingPageState();
}

class _OrderListingPageState extends State<OrderListingPage> {
  late final OrderListingCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = OrderListingCubit(
      orderRepository: getIt.get<IOrderRepository>(),
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
      child: BlocConsumer<OrderListingCubit, OrderListingState>(
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
              appBar: _OrderListingAppBar(),
              body: Center(child: CircularProgressIndicator.adaptive()),
            );
          }

          return Scaffold(
            appBar: const _OrderListingAppBar(),
            body: RefreshIndicator(
              onRefresh: () async => _cubit.initial(),
              child: state.items.isEmpty
                  ? ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: const [
                        SizedBox(height: 80),
                        Center(child: Text('Bạn chưa có đơn hàng nào')),
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
                            OrderListItem(
                              order: item,
                              onTap: () => context.push(
                                AppRouter.orderDetail,
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

class _OrderListingAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const _OrderListingAppBar();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Đơn hàng của tôi'),
    );
  }
}

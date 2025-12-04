import 'package:edufy_mobile/src/core/dependencies/ioc.dart';
import 'package:edufy_mobile/src/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'presentation/cubits/export.dart';

class EdufyApp extends StatefulWidget {
  const EdufyApp({super.key});

  @override
  State<EdufyApp> createState() => _EdufyAppState();
}

class _EdufyAppState extends State<EdufyApp> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = AppRouter.build();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (_) => getIt<AuthCubit>()..loadMe(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Edufy',
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.blue,
          fontFamily: 'Inter',
          scaffoldBackgroundColor: Colors.white,
        ),

        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
            child: child ?? const SizedBox.shrink(),
          );
        },

        routerConfig: _router,
      ),
    );
  }
}

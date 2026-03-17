import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/di/injection_container.dart';
import '../features/auth/presentation/bloc/auth_bloc.dart';
import '../features/splash/presentation/bloc/splash_bloc.dart';
import 'router/app_router.dart';

class MaliApp extends StatelessWidget {
  
  const MaliApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        BlocProvider<SplashBloc>(
          create: (_) => sl<SplashBloc>(),
        ),

        BlocProvider<AuthBloc>(
          create: (_) => sl<AuthBloc>(),
        ),

      ],
      child: MaterialApp.router(
        title: "Apna Mali Parivar",
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
      ),
    );
  }
}
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:get_it/get_it.dart';

import '../../../features/splash/presentation/pages/splash_page.dart';
import '../../features/auth/presentation/pages/phone_login_page.dart';
import '../../features/auth/presentation/pages/otp_page.dart';
import '../../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../../features/dashboard/presentation/bloc/dashboard_bloc.dart';
import '../../../features/dashboard/presentation/pages/dashboard_wrapper.dart';
// import 'package:mali_parivar_app/features/jobs/presentation/pages/jobs_page.dart';
// import 'package:mali_parivar_app/features/services/presentation/pages/services_page.dart';
// import 'package:mali_parivar_app/features/profile/presentation/pages/profile_page.dart';
// import 'package:mali_parivar_app/features//presentation/pages/more_page.dart';
import 'package:mali_parivar_app/features/matrimony/presentation/pages/matrimony_page.dart';
final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    // Splash
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashPage(),
    ),

    // Login
    GoRoute(
      path: '/login',
      builder: (context, state) => const PhoneLoginPage(),
    ),

    // OTP
    GoRoute(
      path: '/otp',
      builder: (context, state) {
        final phone = state.extra as String? ?? '';
        return OtpPage(phone: phone);
      },
    ),

    // 🔥 MAIN DASHBOARD SYSTEM
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return DashboardWrapper(
          navigationShell: navigationShell,
        );
      },
      branches: [
        // HOME
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/dashboard',
              builder: (context, state) => BlocProvider(
                create: (_) => GetIt.instance<DashboardBloc>(),
                child: const DashboardPage(),
              ),
            ),
          ],
        ),

        // JOBS
        // StatefulShellBranch(
        //   routes: [
        //     GoRoute(
        //       path: '/jobs',
        //       builder: (context, state) => const JobsPage(),
        //     ),
        //   ],
        // ),

        // SERVICES
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/matrimony',
              builder: (context, state) => const MatrimonyPage(),
            ),
          ],
        ),

        // PROFILE
        // StatefulShellBranch(
        //   routes: [
        //     GoRoute(
        //       path: '/profile',
        //       builder: (context, state) => const ProfilePage(),
        //     ),
        //   ],
        // ),

        // MORE
        // StatefulShellBranch(
        //   routes: [
        //     GoRoute(
        //       path: '/more',
        //       builder: (context, state) => const MorePage(),
        //     ),
        //   ],
        // ),
      ],
    ),
  ],
);
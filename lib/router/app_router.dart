import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_mobile_vision_example/core/api_manager/command.dart';
import 'package:qr_mobile_vision_example/core/util/shared_preferences.dart';

import '../core/injection/injection_container.dart';
import '../features/auth/bloc/home1_cubit/home1_cubit.dart';
import '../features/auth/bloc/login_cubit/login_cubit.dart';
import '../features/auth/bloc/policy_cubit/policy_cubit.dart';
import '../features/auth/ui/pages/auth_page.dart';
import '../features/auth/ui/pages/login_page.dart';
import '../features/auth/ui/pages/policy_page.dart';
import '../features/buses/bloc/all_buses_cubit/all_buses_cubit.dart';
import '../features/buses/bloc/check_active_trip_cubit/check_active_trip_cubit.dart';
import '../features/main/ui/pages/main_page.dart';
import '../features/qr/bloc/scan_cubit/scan_cubit.dart';
import '../features/qr/bloc/send_report_cubit/send_report_cubit.dart';
import '../features/qr/ui/pages/qr_page.dart';
import '../features/splash_page/splash_page.dart';
import '../features/super_user/bloc/all_super_users_cubit/all_super_users_cubit.dart';

class AppRoutes {
  static Route<dynamic> routes(RouteSettings settings) {
    var screenName = settings.name;

    if (!AppSharedPreference.isLogin) {
      final providers = [
        BlocProvider(create: (_) => sl<LoginCubit>()),
      ];
      return MaterialPageRoute(builder: (context) {
        return MultiBlocProvider(
          providers: providers,
          child: const LoginPage(),
        );
      });
    }

    switch (screenName) {
      //region splash



      case RouteNames.main:
        final providers = [
          BlocProvider(create: (_) => sl<CheckTripCubit>()),
          BlocProvider(
            create: (_) =>
                sl<AllBusesCubit>()..getBuses(_, command: Command.noPagination()),
          ),
        ];
        return MaterialPageRoute(builder: (context) {
          return MultiBlocProvider(
            providers: providers,
            child: const MainPage(),
          );
        });

      //endregion

      case RouteNames.loginScreen:
        final providers = [
          BlocProvider(create: (_) => sl<LoginCubit>()),
        ];
        return MaterialPageRoute(builder: (context) {
          return MultiBlocProvider(
            providers: providers,
            child: const LoginPage(),
          );
        });
    }

    return MaterialPageRoute(builder: (context) => const Scaffold());
  }
}

class RouteNames {
  static const scanPage = '/3';
  static const loginScreen = '/2';
  static const main = '/';
}

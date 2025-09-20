import 'package:database/db_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:utilities/app_colors.dart';
import 'package:utilities/base_widgets/common_widgets.dart';
import 'package:utilities/network_utility/app_connectivity.dart';
import 'package:utilities/server_time/es_date_time_utils.dart';
import 'package:utilities/utils.dart';

import 'config/locators.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Utils.setDefaultOrientation();
  AppConnectivity().init();
  await DbUtils.init();
  setupLocators(); // Singleton repositories, Initializing
  ESDateTimeUtils().onAppLaunch(); // for Sever time calculation
  runApp(MultiBlocProvider(providers: [

  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});



  final _router = GoRouter(
    initialLocation: '/',
    navigatorKey: UI.navigatorKey,
    routes: [],
  );

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    Utils.init(context);

    return MaterialApp.router(
      scaffoldMessengerKey: UI.scaffoldMessengerKey,
      locale: const Locale('en', 'US'),
      title: 'RCS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        canvasColor: AppColors.white,
        cardColor: AppColors.white,
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple, surfaceTint: AppColors.white),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
    // },
    // );
  }
}
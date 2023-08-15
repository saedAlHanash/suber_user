
import 'package:flutter/material.dart';
import 'package:qr_mobile_vision_example/temp.dart';
import 'package:qr_mobile_vision_example/core/app/app_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/app/app_widget.dart';

import 'core/app/bloc/loading_cubit.dart';
import 'core/app_theme.dart';
import 'core/injection/injection_container.dart' as di;
import 'core/util/shared_preferences.dart';

import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_mobile_vision_example/core/strings/app_color_manager.dart';

import '../../core/injection/injection_container.dart' as di;
import '../../features/qr/ui/pages/qr_page.dart';
import '../../router/app_router.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();
  // await ScreenUtil.ensureScreenSize();
  await SharedPreferences.getInstance().then((value) {
    AppSharedPreference.init(value);
  });

  runApp( MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<LoadingCubit>()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(412, 870),
        minTextAdapt: true,
        builder: (context, child) {
          DrawableText.initial(
            initialColor: AppColorManager.mainColor,
            initialSize: 16.0.sp,
            headerSizeText: 18.0.sp,
            titleSizeText: 16.0.sp,
            initialHeightText: 1.5.spMin,
          );
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: appTheam,
            navigatorKey: di.sl<GlobalKey<NavigatorState>>(),
            onGenerateRoute: AppRoutes.routes,
            // home: Scaffold(appBar: AppBar()),
          );
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DraggableScrollableSheet'),
      ),
      body: Stack(
        children: [
          Container(
            height: 300.0,
            color: AppColorManager.red,
          ),
          SizedBox.expand(
            child: DraggableScrollableSheet(
              maxChildSize: 0.5,
              builder: (BuildContext context, ScrollController scrollController) {
                return Container(
                  color: Colors.blue[100],
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: 3,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(title: Text('Item $index'));
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

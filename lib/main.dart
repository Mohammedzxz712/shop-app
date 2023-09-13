import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_1/layout/shop_layout/cubit/cubit.dart';
import 'package:shop_app_1/layout/shop_layout/shop_layout_screen.dart';
import 'package:shop_app_1/moduls/shop_app/login/shop_login_screen.dart';
import 'package:shop_app_1/shared/bloc_observer.dart';
import 'package:shop_app_1/shared/components/constants.dart';
import 'package:shop_app_1/shared/cubit/cubit.dart';
import 'package:shop_app_1/shared/cubit/state.dart';
import 'package:shop_app_1/shared/network/local/cash_helper.dart';
import 'package:shop_app_1/shared/network/remote/dio_helper.dart';
import 'package:shop_app_1/shared/styles/themes.dart';

import 'moduls/shop_app/on_boarding/on_boarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getBool(key: 'isDark');
  bool? onBoarding = CacheHelper.getBool(key: 'onBoarding');
  token = CacheHelper.getBool(key: 'token');
  print(token);
  late Widget widget;
  if (onBoarding == null || false) {
    widget = OnBoardingScreen();
  } else {
    if (token == null) {
      widget = ShopLoginScreen();
    } else {
      widget = ShopLayout();
    }
  }

  runApp(MyApp(
    isDark: isDark,
    onBoarding: onBoarding,
    widget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final bool? onBoarding;
  final Widget? widget;

  MyApp({super.key, this.isDark, this.onBoarding, required this.widget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCupit()..changeDark(formShared: isDark),
        ),
        BlocProvider(
          create: (context) => ShopCubit()
            ..getHomeData()
            ..getCategoriesData()
            ..getFavData()
            ..getUserData(),
        ),
      ],
      child: BlocConsumer<AppCupit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightMode,
            darkTheme: darkMode,
            themeMode:
                // AppCupit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
                AppCupit.get(context).isDark
                    ? ThemeMode.light
                    : ThemeMode.light,
            //onBoarding != null ? ShopLoginScreen() : OnBoardingScreen(),
            home: widget!,
          );
        },
      ),
    );
  }
}

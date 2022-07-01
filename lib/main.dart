import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_social_app/compontents/constantse.dart';
import 'package:new_social_app/layout/cubit/cubit.dart';
import 'package:new_social_app/layout/social_layout/social_layout.dart';
import 'package:new_social_app/modules/login/login_screen.dart';
import 'package:new_social_app/modules/on_boarding/on_boarding.dart';
import 'package:new_social_app/shared/network/local/cache_helper.dart';
import 'package:new_social_app/shared/styles/cubit/cubit.dart';
import 'package:new_social_app/shared/styles/cubit/observer.dart';
import 'package:new_social_app/shared/styles/cubit/states.dart';
import 'package:new_social_app/shared/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getData(key: 'isDark');
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  uId = CacheHelper.getData(key: 'uId');
  Widget widget;

  if(onBoarding!= null)
  {
    if(uId != null)
    {
      widget = const SocialLayout();
    }else{
      widget = const SocialLoginScreen();
    }
  }else{
    widget = const OnBoardingScreen();
  }


  BlocOverrides.runZoned(
    () {
      runApp(
        MyApp(
          isDark: isDark,
          startWidget: widget,
        ),
      );
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget? startWidget;

  const MyApp({this.isDark,this.startWidget, Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:
      [
        BlocProvider(create: (context) =>
        ThemeCubit()
          ..changeMode(
            fromShared: isDark,
          ),
        ),
        BlocProvider(create: (context) => SocialCubit()..getUserData()..getPosts(),
        ),
      ],
        child: BlocConsumer<ThemeCubit, ThemeStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightMode,
              darkTheme: darkMode,
              themeMode: ThemeCubit.get(context).isDark? ThemeMode.dark : ThemeMode.light,
              home: startWidget,
            );
          },
        ),
      );
  }
}

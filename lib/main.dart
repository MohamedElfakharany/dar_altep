import 'package:dar_altep/cubit/cubit.dart';
import 'package:dar_altep/screens/auth/onboarding/onboarding_screen.dart';
import 'package:dar_altep/screens/home/home_screen.dart';
import 'package:dar_altep/shared/bloc_observer.dart';
import 'package:dar_altep/shared/network/local/cache_helper.dart';
import 'package:dar_altep/shared/network/local/const_shared.dart';
import 'package:dar_altep/shared/network/remote/dio_helper.dart';
import 'package:dar_altep/translations/codegen_loader.g.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await CacheHelper.init();
  DioHelper.init();

  token = CacheHelper.getData(key: 'token');
  // name = CacheHelper.getData(key: 'name');
  // mobile = CacheHelper.getData(key: 'mobile');
  // email = CacheHelper.getData(key: 'email');
  // image = CacheHelper.getData(key: 'image');
  // birthrate = CacheHelper.getData(key: 'birthrate');
  // nationality = CacheHelper.getData(key: 'nationality');
  // gender = CacheHelper.getData(key: 'gender');

  Widget widget;
  // token = token;
  if (kDebugMode) {
    print('from main the token is $token');
    print('from main the token is $name');
  }

  if (token != null) {
    widget = const HomeScreen();
  } else {
    widget = const OnboardingScreen();
  }

  BlocOverrides.runZoned(
    () {
      runApp(
        EasyLocalization(
          path: 'assets/translations',
          supportedLocales: const [
            Locale('en'),
            Locale('ar'),
          ],
          fallbackLocale: const Locale('en'),
          assetLoader: const CodegenLoader(),
          child: MyApp(
            startWidget: widget,
          ),
        ),
      );
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  const MyApp({
    Key? key,
    required this.startWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.white,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
    ));
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return BlocProvider(
      create: (BuildContext context) => AppCubit()
        ..getOffersData()
        ..getTestsData()
        ..getProfileData()
        ..getReservationsData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: context.locale,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        home: startWidget,
      ),
    );
  }
}

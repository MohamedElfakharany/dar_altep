import 'dart:io';

import 'package:dar_altep/cubit/cubit.dart';
import 'package:dar_altep/screens/auth/onboarding/onboarding_screen.dart';
import 'package:dar_altep/screens/home/home_screen.dart';
import 'package:dar_altep/shared/bloc_observer.dart';
import 'package:dar_altep/shared/components/general_components.dart';
import 'package:dar_altep/shared/network/local/cache_helper.dart';
import 'package:dar_altep/shared/network/local/const_shared.dart';
import 'package:dar_altep/shared/network/remote/dio_helper.dart';
import 'package:dar_altep/translations/codegen_loader.g.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
// import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  await FirebaseMessaging.instance.setAutoInitEnabled(true);

  deviceToken = await FirebaseMessaging.instance.getToken();

  if (kDebugMode) {
    print('deviceToken : $deviceToken ');
  }
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (kDebugMode) {
      print('onMessage message.data.toString() ${message.data.toString()}');
    }
    // showToast(msg: 'on Message', state: ToastState.success);
    // RemoteNotification? _notification = message.notification;
    // AndroidNotification? _android = message.notification?.android;
  });

  void permission() async {
    NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional) {
      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true, // headsup notification in IOS
        badge: true,
        sound: true,
      );
    } else {
      //close the app
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    }
  }

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    if (kDebugMode) {
      print(
          'onMessageOpenedApp event.data.toString() ${event.data.toString()}');
    }
    // showToast(msg: 'on Message Opened App', state: ToastState.success);
  });

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await CacheHelper.init();
  DioHelper.init();

  token = CacheHelper.getData(key: 'token');

  Widget widget;
  if (kDebugMode) {
    printWrapped('from main the token is $token');
  }

  if (token != null) {
    widget = const HomeScreen();
  } else {
    widget = const OnboardingScreen();
  }

  BlocOverrides.runZoned(
    () {
      if (Platform.isIOS) {
        //IOS check permission
        permission();
      }
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

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  if (kDebugMode) {
    print('on background message');
    print(message.data.toString());
  }
  showToast(msg: 'on background message', state: ToastState.success);
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
        ..getReservationsData()
        ..getTestNameData()
        ..getAppointmentsData()
        ..getHomeOffersData()
        ..getLabOffersData()
        ..getNotifications(),
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

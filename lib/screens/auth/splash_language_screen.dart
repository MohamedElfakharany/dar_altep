import 'dart:async';

import 'package:dar_altep/cubit/cubit.dart';
import 'package:dar_altep/cubit/states.dart';
import 'package:dar_altep/screens/auth/login_screen.dart';
import 'package:dar_altep/shared/components/general_components.dart';
import 'package:dar_altep/shared/constants/generalConstants.dart';
import 'package:dar_altep/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashLanguageScreen extends StatefulWidget {
  const SplashLanguageScreen({Key? key}) : super(key: key);

  @override
  State<SplashLanguageScreen> createState() => _SplashLanguageScreenState();
}

class _SplashLanguageScreenState extends State<SplashLanguageScreen> {
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage("assets/images/splashBackGround.png"),
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.25), BlendMode.dstATop),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Image(
                  image: AssetImage(
                    'assets/images/logo.png',
                  ),
                  fit: BoxFit.contain,
                  height: 270,
                  width: 270,
                ),
                verticalLargeSpace,
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GeneralButton(
                      width: 100,
                      title: 'English',
                      onPress: () async {
                        if (AppCubit.get(context).local == 'en'){
                          await context
                              .setLocale(Locale(AppCubit.get(context).local)).then((value) {
                            Navigator.push(context, FadeRoute(page: LoginScreen()));
                          });
                          if (kDebugMode) {
                            print(LocaleKeys.languageA.tr());
                          }
                        }else {
                          AppCubit.get(context).changeLanguage();
                          await context
                              .setLocale(Locale(AppCubit.get(context).local)).then((value) {
                            Navigator.push(context, FadeRoute(page: LoginScreen()));
                          });
                          if (kDebugMode) {
                            print(LocaleKeys.languageA.tr());
                          }
                        }
                      },
                    ),
                    verticalLargeSpace,
                    GeneralButton(
                      width: 100,
                      title: 'عربي',
                      onPress: () async {
                        if (AppCubit.get(context).local == 'en'){
                          AppCubit.get(context).changeLanguage();
                          await context
                              .setLocale(Locale(AppCubit.get(context).local)).then((value) {
                            Navigator.push(context, FadeRoute(page: LoginScreen()));
                          });
                          if (kDebugMode) {
                            print(LocaleKeys.language.tr());
                          }
                        }else {
                          await context
                              .setLocale(Locale(AppCubit.get(context).local)).then((value) {
                            Navigator.push(context, FadeRoute(page: LoginScreen()));
                          });
                          if (kDebugMode) {
                            print(LocaleKeys.language.tr());
                          }
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

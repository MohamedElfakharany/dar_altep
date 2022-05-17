// ignore_for_file: must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dar_altep/cubit/cubit.dart';
import 'package:dar_altep/cubit/states.dart';
import 'package:dar_altep/screens/auth/register_screen.dart';
import 'package:dar_altep/screens/auth/reset_password.dart';
import 'package:dar_altep/screens/home/home_screen.dart';
import 'package:dar_altep/shared/components/general_components.dart';
import 'package:dar_altep/shared/constants/colors.dart';
import 'package:dar_altep/shared/constants/generalConstants.dart';
import 'package:dar_altep/shared/network/local/cache_helper.dart';
import 'package:dar_altep/shared/network/local/const_shared.dart';
import 'package:dar_altep/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final mobileController = TextEditingController();
  final passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is AppLoginSuccessState) {
            if (state.userModel.status) {

              CacheHelper.saveData(
                key: 'token',
                value: state.userModel.data?.token,
              ).then((value) {
                CacheHelper.saveData(key: 'name', value: state.userModel.data?.name);
                CacheHelper.saveData(key: 'mobile', value: state.userModel.data?.phone);
                CacheHelper.saveData(key: 'email', value: state.userModel.data?.email);
                CacheHelper.saveData(key: 'image', value: state.userModel.data?.idImage);
                CacheHelper.saveData(key: 'nationality', value: state.userModel.data?.nationality);
                CacheHelper.saveData(key: 'birthrate', value: state.userModel.data?.birthrate);
                CacheHelper.saveData(key: 'gender', value: state.userModel.data?.gender);

                name = CacheHelper.getData(key: 'name');
                mobile = CacheHelper.getData(key: 'mobile');
                email = CacheHelper.getData(key: 'email');
                image = CacheHelper.getData(key: 'image');
                birthrate = CacheHelper.getData(key: 'birthrate');
                nationality = CacheHelper.getData(key: 'nationality');
                gender = CacheHelper.getData(key: 'gender');

                token = state.userModel.data?.token;
                name = state.userModel.data?.name;
                mobile = state.userModel.data?.phone;
                email = state.userModel.data?.email;
                image = state.userModel.data?.idImage;
                birthrate = state.userModel.data?.birthrate;
                nationality = state.userModel.data?.nationality;
                gender = state.userModel.data?.gender;

                navigateAndFinish(
                  context,
                  const HomeScreen(),
                );
              });
            }
          }
        },
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
          ));
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.transparent,
            ),
            body: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: whiteColor,
                ),
                Positioned.fill(
                    top: 0.0,
                    right: 0.0,
                    left: 0.0,
                    bottom: MediaQuery.of(context).size.height / 3,
                    child: Image.asset(
                      'assets/images/appbarImage.png',
                      fit: BoxFit.cover,
                      height: 200,
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 20),
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          LocaleKeys.loginTxtMain.tr(),
                          style: TextStyle(
                            color: whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            fontFamily: fontFamily,
                          ),
                        ),
                        verticalSmallSpace,
                        Text(
                          LocaleKeys.loginTxtSecondary.tr(),
                          style: TextStyle(
                            color: whiteColor,
                            fontWeight: FontWeight.normal,
                            fontSize: 20,
                            fontFamily: fontFamily,
                          ),
                        ),
                        verticalSmallSpace,
                        Material(
                          borderRadius: BorderRadius.circular(20),
                          elevation: 1.5,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 600,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: Form(
                              key: formKey,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'assets/images/logo.png',
                                      height: 100,
                                      width: 100,
                                    ),
                                    DefaultFormField(
                                      controller: mobileController,
                                      type: TextInputType.number,
                                      label: LocaleKeys.txtFieldMobile.tr(),
                                      validatedText: 'Mobile Number',
                                      suffixPressed: () {},
                                    ),
                                    verticalSmallSpace,
                                    DefaultFormField(
                                      controller: passwordController,
                                      type: TextInputType.text,
                                      validatedText: 'Password',
                                      label: 'Password',
                                      obscureText: cubit.isPassword,
                                      suffixIcon: cubit.sufIcon,
                                      suffixPressed: () {
                                        cubit.changePasswordVisibility();
                                      },
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(context,
                                            FadeRoute(page: ResetPassword()));
                                      },
                                      child: DefaultTextButton(
                                        title: 'Forgot your password?',
                                      ),
                                    ),
                                    CheckboxListTile(
                                      side: const BorderSide(
                                        style: BorderStyle.solid,
                                      ),
                                      title: const Text('Remember Me'),
                                      activeColor: blueDark,
                                      value: cubit.rememberMe,
                                      onChanged: (value) {
                                        cubit.onRememberMeChanged();
                                      },
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                    ),
                                    verticalMediumSpace,
                                    ConditionalBuilder(
                                      condition: state is! AppLoginLoadingState,
                                      builder: (context) {
                                        return GeneralButton(
                                          title: 'Sign In',
                                          onPress: () {
                                            if (formKey.currentState!
                                                .validate()) {
                                              AppCubit.get(context).login(
                                                phone: mobileController.text,
                                                password:
                                                    passwordController.text,
                                              );
                                            }
                                          },
                                        );
                                      },
                                      fallback: (context) => const Center(
                                          child: CircularProgressIndicator()),
                                    ),
                                    verticalMediumSpace,
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            'Don\'t have an account?',
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  FadeRoute(
                                                      page:
                                                          const RegisterScreen()));
                                            },
                                            child: DefaultTextButton(
                                              title: 'Register',
                                              weight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

// ignore_for_file: must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dar_altep/cubit/cubit.dart';
import 'package:dar_altep/cubit/states.dart';
import 'package:dar_altep/screens/auth/register_screen.dart';
import 'package:dar_altep/screens/auth/send_email_reser_password_screen.dart';
import 'package:dar_altep/screens/home/home_screen.dart';
import 'package:dar_altep/shared/components/general_components.dart';
import 'package:dar_altep/shared/constants/colors.dart';
import 'package:dar_altep/shared/constants/generalConstants.dart';
import 'package:dar_altep/shared/network/local/const_shared.dart';
import 'package:dar_altep/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final mobileController = TextEditingController();
  final passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  tokenSaving(String tokenSave) async {
    (await SharedPreferences.getInstance()).setString('token', tokenSave);
    token = tokenSave;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is AppLoginSuccessState) {
            if (state.userModel.status) {
              tokenSaving(state.userModel.data?.token);
              navigateAndFinish(context, const HomeScreen());
            } else {
              print('state.userModel.message ${state.userModel.message}');
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Error...!'),
                    content: Text('${state.userModel.message}'),
                  );
                },
              );
            }
          } else if (state is AppLoginErrorState) {
            print('state.userModel.message ${state.error}}');
            showDialog(
                context: context,
                builder: (context) {
                  return const AlertDialog(
                    title: Text('Login Error...!'),
                    content: Text('please contact with lab'),
                  );
                });
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
                                      validatedText: LocaleKeys.txtFieldMobile.tr(),
                                      suffixPressed: () {},
                                    ),
                                    verticalSmallSpace,
                                    DefaultFormField(
                                      controller: passwordController,
                                      type: TextInputType.text,
                                      validatedText: LocaleKeys.txtFieldPassword.tr(),
                                      label: LocaleKeys.txtFieldPassword.tr(),
                                      obscureText: cubit.isPassword,
                                      suffixIcon: cubit.sufIcon,
                                      suffixPressed: () {
                                        cubit.changePasswordVisibility();
                                      },
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(context,
                                            FadeRoute(page: SendEmailScreen()));
                                      },
                                      child: DefaultTextButton(
                                        title: LocaleKeys.BtnForgetPassword.tr(),
                                      ),
                                    ),
                                    // CheckboxListTile(
                                    //   side: const BorderSide(
                                    //     style: BorderStyle.solid,
                                    //   ),
                                    //   title: const Text('Remember Me'),
                                    //   activeColor: blueDark,
                                    //   value: cubit.rememberMe,
                                    //   onChanged: (value) {
                                    //     cubit.onRememberMeChanged();
                                    //   },
                                    //   controlAffinity:
                                    //       ListTileControlAffinity.leading,
                                    // ),
                                    verticalMediumSpace,
                                    ConditionalBuilder(
                                      condition: state is! AppLoginLoadingState,
                                      builder: (context) {
                                        return GeneralButton(
                                          title: LocaleKeys.BtnSignIn.tr(),
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
                                          Text(
                                            LocaleKeys.loginTxtDontHaveAccount.tr(),
                                            style: const TextStyle(
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
                                              title: LocaleKeys.registerTxtMain.tr(),
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

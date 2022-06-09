// ignore_for_file: must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dar_altep/cubit/cubit.dart';
import 'package:dar_altep/cubit/states.dart';
import 'package:dar_altep/screens/home/home_screen.dart';
import 'package:dar_altep/shared/components/general_components.dart';
import 'package:dar_altep/shared/constants/colors.dart';
import 'package:dar_altep/shared/constants/generalConstants.dart';
import 'package:dar_altep/shared/network/local/const_shared.dart';
import 'package:dar_altep/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckCodeScreen extends StatelessWidget {
  CheckCodeScreen({required this.email, Key? key}) : super(key: key);

  String email;
  final codeController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is AppResetEmailSuccessState) {
            if (state.resetEmailModel.status) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    // title: Text(LocaleKeys.txtError.tr()),
                    content: Text('${state.resetEmailModel.message}'),
                    actions: [
                      GeneralButton(title: LocaleKeys.BtnDone, onPress: (){
                        navigateAndFinish(context, const HomeScreen());
                      }),
                    ],
                  );
                },
              );
            } else {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(LocaleKeys.txtError.tr()),
                    content: Text('${state.resetEmailModel.message}'),
                  );
                },
              );
            }
          }
          if (state is AppResetEmailErrorState){
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(LocaleKeys.txtError.tr()),
                  content: Text(state.error.toString()),
                );
              },
            );
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
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: whiteColor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
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
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 20),
                  child: SingleChildScrollView(
                    // physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          LocaleKeys.txtChangeEmail.tr(),
                          style: TextStyle(
                            color: whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            fontFamily: fontFamily,
                          ),
                        ),
                        verticalSmallSpace,
                        Text(
                          LocaleKeys.txtChangeEmailSecond.tr(),
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
                                    verticalLargeSpace,
                                    Text(
                                      LocaleKeys.txtCheckCode.tr(),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 20,
                                        fontFamily: fontFamily,
                                      ),
                                    ),
                                    verticalLargeSpace,
                                    DefaultFormField(
                                      controller: codeController,
                                      type: TextInputType.text,
                                      label: LocaleKeys.txtFieldCodeReset.tr(),
                                      validatedText:
                                          LocaleKeys.txtFieldCodeReset.tr(),
                                      onTap: () {},
                                    ),
                                    verticalMediumSpace,
                                    ConditionalBuilder(
                                      condition: state
                                          is! AppResetEmailLoadingState,
                                      builder: (context) => GeneralButton(
                                        title: LocaleKeys.BtnReset.tr(),
                                        onPress: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            AppCubit.get(context)
                                                .resetEmail(
                                              code: codeController.text,
                                              email: email,
                                            );
                                          }
                                        },
                                      ),
                                      fallback: (context) => const Center(
                                          child: CircularProgressIndicator()),
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

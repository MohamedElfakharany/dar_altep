// ignore_for_file: must_be_immutable, body_might_complete_normally_nullable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:country_picker/country_picker.dart';
import 'package:dar_altep/cubit/cubit.dart';
import 'package:dar_altep/cubit/states.dart';
import 'package:dar_altep/screens/auth/login_screen.dart';
import 'package:dar_altep/screens/auth/otp/otp_screen.dart';
import 'package:dar_altep/shared/components/general_components.dart';
import 'package:dar_altep/shared/constants/colors.dart';
import 'package:dar_altep/shared/constants/general_constants.dart';
import 'package:dar_altep/shared/network/local/const_shared.dart';
import 'package:dar_altep/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final mobileController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmationPasswordController = TextEditingController();

  final dateOfBirthController = TextEditingController();

  final ageController = TextEditingController();

  final nationalityController = TextEditingController();

  String? nationalValue;

  final genderItems = ['Male', 'Female'];
  String? genderValue;

  var formKey = GlobalKey<FormState>();

  tokenSaving(String tokenSave) async {
    (await SharedPreferences.getInstance()).setString('token', tokenSave);
    token = tokenSave;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppRegisterSuccessState) {
          if (state.userModel.status) {
            tokenSaving(state.userModel.data?.token);
            Navigator.push(
              context,
              FadeRoute(
                page: OtpScreen(
                  mobile: state.userModel.data?.phone,
                  verification: state.userModel.data?.verificationCode,
                ),
              ),
            );
          } else {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(LocaleKeys.txtError.tr()),
                    content: Text('${state.userModel.message}'),
                  );
                });
          }
        }
        if (state is AppRegisterErrorState) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(LocaleKeys.txtError.tr()),
                  content: const Text(
                    'Please contact with lab',
                  ),
                );
              });
        }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        final DateTime today = DateTime.now();
        DateTime? selectedDay;
        Object day;
        Object month;
        const CalendarFormat calendarFormat = CalendarFormat.month;
        SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ));
        return ScreenUtilInit(builder: (ctx, _) {
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
                          LocaleKeys.registerTxtMain.tr(),
                          style: const TextStyle(
                            color: whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            fontFamily: fontFamily,
                          ),
                        ),
                        verticalSmallSpace,
                        Text(
                          LocaleKeys.registerTxtSecondary.tr(),
                          style: const TextStyle(
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
                            height: 500,
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
                                      controller: nameController,
                                      type: TextInputType.name,
                                      label: LocaleKeys.txtFieldName.tr(),
                                      validatedText:
                                          LocaleKeys.txtFieldName.tr(),
                                      suffixPressed: () {},
                                      onTap: () {},
                                    ),
                                    verticalSmallSpace,
                                    DefaultFormField(
                                      controller: emailController,
                                      type: TextInputType.emailAddress,
                                      validatedText:
                                          LocaleKeys.txtFieldEmail.tr(),
                                      label: LocaleKeys.txtFieldEmail.tr(),
                                      onTap: () {},
                                    ),
                                    verticalSmallSpace,
                                    DefaultFormField(
                                      controller: mobileController,
                                      type: TextInputType.phone,
                                      validatedText:
                                          LocaleKeys.txtFieldMobile.tr(),
                                      label: LocaleKeys.txtFieldMobile.tr(),
                                      onTap: () {},
                                    ),
                                    verticalSmallSpace,
                                    DefaultFormField(
                                      controller: passwordController,
                                      type: TextInputType.text,
                                      validatedText:
                                          LocaleKeys.txtFieldPassword.tr(),
                                      label: LocaleKeys.txtFieldPassword.tr(),
                                      obscureText: cubit.isPassword,
                                      suffixIcon: cubit.sufIcon,
                                      suffixPressed: () {
                                        cubit.changePasswordVisibility();
                                      },
                                      onTap: () {},
                                    ),
                                    verticalSmallSpace,
                                    DefaultFormField(
                                      controller:
                                          confirmationPasswordController,
                                      type: TextInputType.text,
                                      validatedText: LocaleKeys
                                          .TxtFieldConfirmPassword.tr(),
                                      isConfirm: true,
                                      confirm: passwordController.text,
                                      label: LocaleKeys.TxtFieldConfirmPassword
                                          .tr(),
                                      obscureText: cubit.isPassword,
                                      suffixIcon: cubit.sufIcon,
                                      suffixPressed: () {
                                        cubit.changePasswordVisibility();
                                      },
                                      // onTap: (){},
                                    ),
                                    verticalSmallSpace,
                                    // Container(
                                    //   height: 60.0,
                                    //   padding: const EdgeInsets.symmetric(
                                    //       horizontal: 20.0),
                                    //   decoration: BoxDecoration(
                                    //     boxShadow: [
                                    //       BoxShadow(
                                    //         color: Colors.grey.withOpacity(0.2),
                                    //         spreadRadius: 3,
                                    //         blurRadius: 10,
                                    //         offset: const Offset(0,
                                    //             10), // changes position of shadow
                                    //       ),
                                    //     ],
                                    //   ),
                                    //   child: DropdownButtonHideUnderline(
                                    //     child: DropdownButtonFormField<String>(
                                    //       validator: (String? value) {
                                    //         if (value == null) {
                                    //           return LocaleKeys
                                    //               .txtFieldNationality
                                    //               .tr();
                                    //         }
                                    //       },
                                    //       decoration: InputDecoration(
                                    //         contentPadding:
                                    //             const EdgeInsetsDirectional.only(
                                    //                 start: 20.0, end: 10.0),
                                    //         fillColor: Colors.white,
                                    //         filled: true,
                                    //         errorStyle: const TextStyle(
                                    //             color: Color(0xFF4F4F4F)),
                                    //         label: Text(LocaleKeys
                                    //             .txtFieldNationality
                                    //             .tr()),
                                    //         border: const OutlineInputBorder(
                                    //           borderSide: BorderSide(
                                    //             width: 2,
                                    //             color: blueDark,
                                    //           ),
                                    //         ),
                                    //       ),
                                    //       value: nationalValue,
                                    //       isExpanded: true,
                                    //       iconSize: 35,
                                    //       items: AppCubit.get(context).countriesName
                                    //           .map(buildMenuItem)
                                    //           .toList(),
                                    //       onChanged: (value) => setState(
                                    //           () => nationalValue = value),
                                    //       onTap: (){},
                                    //       // onSaved: (v) {
                                    //       //   FocusScope.of(context).unfocus();
                                    //       // },
                                    //     ),
                                    //   ),
                                    // ),
                                    DefaultFormField(
                                      controller: nationalityController,
                                      type: TextInputType.none,
                                      validatedText:
                                          LocaleKeys.txtFieldNationality.tr(),
                                      label:
                                          LocaleKeys.txtFieldNationality.tr(),
                                      onTap: () {
                                        showCountryPicker(
                                          context: context,
                                          onSelect: (Country country) {
                                            nationalityController.text =
                                                country.name;
                                            nationalValue = country.name;
                                            print(country);
                                          },
                                        );
                                      },
                                    ),
                                    verticalSmallSpace,
                                    DefaultFormField(
                                      controller: dateOfBirthController,
                                      type: TextInputType.datetime,
                                      validatedText:
                                          LocaleKeys.txtFieldDateOfBirth.tr(),
                                      label:
                                          LocaleKeys.txtFieldDateOfBirth.tr(),
                                      onTap: () {
                                        showDatePicker(
                                          locale: Locale(AppCubit.get(context).local),
                                          initialEntryMode: DatePickerEntryMode.calendarOnly,
                                          context: context,
                                          initialDate: DateTime?.now(),
                                          firstDate:
                                              DateTime?.parse('1950-01-01'),
                                          lastDate: DateTime?.now(),
                                        ).then((value) {
                                          dateOfBirthController.text =
                                              DateFormat.yMd().format(value!);
                                          FocusScope.of(context).unfocus();
                                        }).catchError((error) {
                                          if (kDebugMode) {
                                            print('error in fetching date');
                                            print(error.toString());
                                          }
                                        });
                                      },
                                      hintText: 'mm/dd/yyyy',
                                      // suffixIcon: Icons.calendar_month,
                                    ),
                                    verticalSmallSpace,
                                    Container(
                                      height: 60.0,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            spreadRadius: 3,
                                            blurRadius: 10,
                                            offset: const Offset(0,
                                                10), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButtonFormField<String>(
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return LocaleKeys.txtFieldGender
                                                  .tr();
                                            }
                                          },
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsetsDirectional
                                                        .only(
                                                    start: 20.0, end: 10.0),
                                            fillColor: Colors.white,
                                            filled: true,
                                            errorStyle: const TextStyle(
                                                color: Color(0xFF4F4F4F)),
                                            label: Text(
                                                LocaleKeys.txtFieldGender.tr()),
                                            border: const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                width: 2,
                                                color: blueDark,
                                              ),
                                            ),
                                          ),
                                          value: genderValue,
                                          isExpanded: true,
                                          iconSize: 35,
                                          items: genderItems
                                              .map(buildMenuItem)
                                              .toList(),
                                          onChanged: (value) => setState(
                                              () => genderValue = value),
                                          onSaved: (v) {
                                            FocusScope.of(context).unfocus();
                                          },
                                        ),
                                      ),
                                    ),
                                    verticalMediumSpace,
                                    ConditionalBuilder(
                                      condition:
                                          state is! AppRegisterLoadingState,
                                      builder: (context) => GeneralButton(
                                        title: LocaleKeys.BtnSignUp.tr(),
                                        onPress: () {
                                          if (kDebugMode) {
                                            print(
                                                'from ConditionalBuilder btn pressed before validate');
                                          }
                                          if (formKey.currentState!
                                              .validate()) {
                                            if (kDebugMode) {
                                              print(
                                                  'from ConditionalBuilder btn pressed');
                                            }
                                            AppCubit.get(context).register(
                                              name: nameController.text,
                                              phone: mobileController.text,
                                              email: emailController.text,
                                              password: passwordController.text,
                                              birthdate:
                                                  dateOfBirthController.text,
                                              nationality: nationalValue ?? '',
                                              gender: genderValue ?? '',
                                              deviceTokenLogin: deviceToken!,
                                            );
                                          } else {
                                            if (kDebugMode) {
                                              print('error');
                                            }
                                          }
                                        },
                                      ),
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
                                            LocaleKeys.registerTxtHaveAccount
                                                .tr(),
                                            style: const TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              navigateAndFinish(
                                                context,
                                                LoginScreen(),
                                              );
                                            },
                                            child: DefaultTextButton(
                                              title: LocaleKeys.BtnSignIn.tr(),
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
        });
      },
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(item),
      );
}

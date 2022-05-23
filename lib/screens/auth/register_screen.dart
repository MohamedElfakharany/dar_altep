// ignore_for_file: must_be_immutable, body_might_complete_normally_nullable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dar_altep/cubit/cubit.dart';
import 'package:dar_altep/cubit/states.dart';
import 'package:dar_altep/screens/auth/login_screen.dart';
import 'package:dar_altep/screens/auth/otp/otp_screen.dart';
import 'package:dar_altep/shared/components/general_components.dart';
import 'package:dar_altep/shared/constants/colors.dart';
import 'package:dar_altep/shared/constants/generalConstants.dart';
import 'package:dar_altep/shared/network/local/cache_helper.dart';
import 'package:dar_altep/shared/network/local/const_shared.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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

  final dateOfBirthController = TextEditingController();

  final ageController = TextEditingController();

  final nationalityItems = ['Saudi Arabia', 'U A E', 'Qatar', 'Egyptian'];
  String? nationalValue;

  final genderItems = ['Male', 'Female'];
  String? genderValue;

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is AppRegisterSuccessState) {

              if (state.userModel.status != 'error') {
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

                Navigator.push(
                  context,
                  FadeRoute(
                    page: OtpScreen(
                      mobile: state.userModel.data?.phone,
                      verification: state.userModel.data?.verificationCode,
                    ),
                  ),
                );
              });
              // if (kDebugMode) {
              //   print(state.userModel.message);
              // }
              // showDialog(
              //     context: context,
              //     builder: (context) {
              //       return AlertDialog(
              //         title: const Text('Error...!'),
              //         content: Text('${state.userModel.message}'),
              //       );
              //     });
            }
          } else if (state is AppRegisterErrorState) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Error...!'),
                    content: Text(state.error),
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
                          'Sign Up',
                          style: TextStyle(
                            color: whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            fontFamily: fontFamily,
                          ),
                        ),
                        verticalSmallSpace,
                        Text(
                          'Create an account',
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
                                      label: 'Full Name',
                                      validatedText: 'Full Name',
                                      suffixPressed: () {},
                                    ),
                                    verticalSmallSpace,
                                    DefaultFormField(
                                      controller: emailController,
                                      type: TextInputType.emailAddress,
                                      validatedText: 'Email',
                                      label: 'Email',
                                    ),
                                    verticalSmallSpace,
                                    DefaultFormField(
                                      controller: mobileController,
                                      type: TextInputType.phone,
                                      validatedText: 'Mobile Number',
                                      label: 'Mobile Number',
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
                                          validator: (String? value) {
                                            if (value != null &&
                                                value.isEmpty) {
                                              return 'Choose Nationality';
                                            }
                                          },
                                          decoration: const InputDecoration(
                                            contentPadding:
                                                EdgeInsetsDirectional.only(
                                                    start: 20.0, end: 10.0),
                                            fillColor: Colors.white,
                                            filled: true,
                                            errorStyle: TextStyle(
                                                color: Color(0xFF4F4F4F)),
                                            label: Text('Nationality'),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                width: 2,
                                                color: blueDark,
                                              ),
                                            ),
                                          ),
                                          value: nationalValue,
                                          isExpanded: true,
                                          iconSize: 35,
                                          items: nationalityItems
                                              .map(buildMenuItem)
                                              .toList(),
                                          onChanged: (value) => setState(
                                              () => nationalValue = value),
                                        ),
                                      ),
                                    ),
                                    verticalSmallSpace,
                                    DefaultFormField(
                                      controller: dateOfBirthController,
                                      type: TextInputType.datetime,
                                      validatedText: 'Date Of Birth',
                                      label: 'Date Of Birth',
                                      onTap: () {
                                        showDatePicker(
                                          context: context,
                                          initialDate: DateTime?.now(),
                                          firstDate:
                                              DateTime?.parse('2000-01-01'),
                                          lastDate: DateTime?.now(),
                                        ).then((value) {
                                          dateOfBirthController.text =
                                              DateFormat.yMd().format(value!);
                                        }).catchError((error) {
                                          if (kDebugMode) {
                                            print('error in fetching date');
                                            print(error.toString());
                                          }
                                        });
                                      },
                                      suffixIcon: Icons.calendar_month,
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
                                              return 'Choose Gender';
                                            }
                                          },
                                          decoration: const InputDecoration(
                                            contentPadding:
                                                EdgeInsetsDirectional.only(
                                                    start: 20.0, end: 10.0),
                                            fillColor: Colors.white,
                                            filled: true,
                                            errorStyle: TextStyle(
                                                color: Color(0xFF4F4F4F)),
                                            label: Text('Gender'),
                                            border: OutlineInputBorder(
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
                                        ),
                                      ),
                                    ),
                                    verticalMediumSpace,
                                    ConditionalBuilder(
                                      condition:
                                          state is! AppRegisterLoadingState,
                                      builder: (context) => GeneralButton(
                                        title: 'Sign In',
                                        onPress: () {
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
                                          const Text(
                                            'Have an account?',
                                            style: TextStyle(
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
                                              title: 'Sign In',
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

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(item),
      );
}

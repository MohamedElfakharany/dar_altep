// ignore_for_file: must_be_immutable, body_might_complete_normally_nullable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dar_altep/cubit/cubit.dart';
import 'package:dar_altep/cubit/states.dart';
import 'package:dar_altep/screens/auth/login_screen.dart';
import 'package:dar_altep/screens/auth/otp/otp_screen.dart';
import 'package:dar_altep/screens/auth/reset_password.dart';
import 'package:dar_altep/shared/components/general_components.dart';
import 'package:dar_altep/shared/constants/colors.dart';
import 'package:dar_altep/shared/constants/generalConstants.dart';
import 'package:dar_altep/shared/network/local/const_shared.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {

  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final mobileController = TextEditingController();

  final passwordController = TextEditingController();

  final dateOfBirthController = TextEditingController();

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
          if (state is AppEditProfileSuccessState) {
            if (state.userModel.status != 'error') {
              Navigator.push(context, FadeRoute(page: OtpScreen(mobile: state.userModel.data?.phone,verification: state.userModel.data?.verificationCode,)));
            } else {
              if (kDebugMode) {
                print(state.userModel.message);
              }
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Error...!'),
                      content: Text('${state.userModel.message}'),
                    );
                  });
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
          // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          //   statusBarColor: Colors.transparent,
          // ));
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: GeneralAppBar(title: 'Settings',),
            body: ListView(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: const AssetImage("assets/images/onboardingbackground.png"),
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.15), BlendMode.dstATop),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 20),
                  child: Form(
                    key: formKey,
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
                        // DefaultFormField(
                        //   controller: nationalityController,
                        //   type: TextInputType.text,
                        //   validate: (String value) {
                        //     if (value.isEmpty) {
                        //       return 'Enter Your Nationality';
                        //     }
                        //   },
                        //   label: 'Nationality',
                        //   suffixIcon: Icons.keyboard_arrow_down,
                        // ),
                        Container(
                          // height: 50.0,
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
                          // height: 50.0,
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
                        GeneralButton(
                          title: 'Change Password',
                          onPress: () {
                            Navigator.push(context, FadeRoute(page: ResetPassword()));
                          },
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

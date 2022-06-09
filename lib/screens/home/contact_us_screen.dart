// ignore_for_file: must_be_immutable, body_might_complete_normally_nullable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dar_altep/cubit/cubit.dart';
import 'package:dar_altep/cubit/states.dart';
import 'package:dar_altep/models/auth/user_model.dart';
import 'package:dar_altep/screens/home/home_screen.dart';
import 'package:dar_altep/shared/components/general_components.dart';
import 'package:dar_altep/shared/constants/colors.dart';
import 'package:dar_altep/shared/constants/generalConstants.dart';
import 'package:dar_altep/shared/network/local/const_shared.dart';
import 'package:dar_altep/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactUsScreen extends StatefulWidget {
  ContactUsScreen({Key? key,required this.user}) : super(key: key);
  UserModel? user;
  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final emailController = TextEditingController();

  final mobileController = TextEditingController();

  final messageController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  final serviceItems = [LocaleKeys.txtExplanation.tr(), LocaleKeys.txtComplaint.tr(), LocaleKeys.txtChangeMobile.tr()];

  String? serviceValue;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is AppSendMessageErrorState) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(LocaleKeys.txtError.tr()),
                    content: Text(state.error),
                  );
                });
          } else if (state is AppSendMessageSuccessState) {
            showPopUp(
              context,
              Container(
                height: height * 0.7,
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsetsDirectional.only(end: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalMediumSpace,
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          verticalMediumSpace,
                          Center(
                            child: Image.asset(
                              'assets/images/sentMessage.png',
                              height: height * 0.3,
                              width: width * 0.6,
                            ),
                          ),
                          verticalMediumSpace,
                          Text(
                            LocaleKeys.txtThank.tr(),
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: fontFamily,
                              fontWeight: FontWeight.bold,
                              color: blueDark,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          verticalMediumSpace,
                          Text(
                            LocaleKeys.txtThankSecond.tr(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: fontFamily,
                              fontWeight: FontWeight.normal,
                              color: darkColor,
                            ),
                          ),
                          verticalLargeSpace,
                          GeneralButton(
                            title: LocaleKeys.BtnDone.tr(),
                            onPress: () {
                              if (kDebugMode) {
                                print('done pressed');
                              }
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  FadeRoute(page: const HomeScreen()),
                                  (route) => false);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          var user = widget.user;
          emailController.text = user?.data?.email;
          mobileController.text = user?.data?.phone;
          return Scaffold(
            // extendBodyBehindAppBar: true,
            appBar: GeneralAppBar(
              title: LocaleKeys.homeTxtContactUs.tr(),
            ),
            body: Container(
              padding: const EdgeInsetsDirectional.only(
                start: 10.0,
                top: 20.0,
                bottom: 20.0,
              ),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image:
                      const AssetImage("assets/images/onboardingbackground.png"),
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.15), BlendMode.dstATop),
                  fit: BoxFit.cover,
                ),
              ),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 20),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Center(
                            child: Text(
                              LocaleKeys.contactUsMainTxt.tr(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: fontFamily,
                                color: blueDark2,
                              ),
                            ),
                          ),
                          verticalLargeSpace,
                          Container(
                            height: 60.0,
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 3,
                                  blurRadius: 5,
                                  offset: const Offset(
                                      0, 5), // changes position of shadow
                                ),
                              ],
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField<String>(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Choose Test Name';
                                  }
                                },
                                decoration: const InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  contentPadding: EdgeInsetsDirectional.only(
                                      start: 20.0, end: 10.0),
                                  errorStyle: TextStyle(color: Color(0xFF4F4F4F)),
                                  label: Text('Service Type'),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: blueDark,
                                    ),
                                  ),
                                ),
                                value: serviceValue,
                                isExpanded: true,
                                iconSize: 35,
                                items: serviceItems.map(buildMenuItem).toList(),
                                onChanged: (value) =>
                                    setState(() => serviceValue = value),
                              ),
                            ),
                          ),
                          verticalSmallSpace,
                          DefaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            label: LocaleKeys.txtFieldEmail.tr(),
                            validatedText: LocaleKeys.txtFieldEmail.tr(),
                            hintText: LocaleKeys.txtFieldEmail.tr(),
                            suffixPressed: () {},
                          ),
                          verticalSmallSpace,
                          DefaultFormField(
                            controller: mobileController,
                            type: TextInputType.phone,
                            validatedText: LocaleKeys.txtFieldMobile.tr(),
                            label: LocaleKeys.txtFieldMobile.tr(),
                            hintText: LocaleKeys.txtFieldMobile.tr(),
                          ),
                          verticalSmallSpace,
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight: height *
                                  0.2, //when it reach the max it will use scroll
                              // maxWidth: width,
                            ),
                            child: DefaultFormField(
                              controller: messageController,
                              expend: true,
                              type: TextInputType.multiline,
                              validatedText: LocaleKeys.TxtFieldMessage.tr(),
                              label: LocaleKeys.TxtFieldMessage.tr(),
                              hintText: LocaleKeys.TxtFieldMessage.tr(),
                              height: 200.0,
                              contentPadding: const EdgeInsetsDirectional.only(
                                  top: 10.0, start: 20.0, bottom: 10.0),
                            ),
                          ),
                          verticalLargeSpace,
                          // verticalLargeSpace,
                          ConditionalBuilder(
                            condition: state is! AppSendMessageLoadingState,
                            builder: (context) => GeneralButton(
                              title: LocaleKeys.BtnSend.tr(),
                              onPress: () {
                                if (formKey.currentState!.validate()) {
                                  if (kDebugMode) {
                                    print('from ConditionalBuilder btn pressed');
                                  }
                                  AppCubit.get(context).sendContactUs(
                                    serviceName: serviceValue ?? '',
                                    email: emailController.text,
                                    phone: mobileController.text,
                                    message: messageController.text,
                                  );
                                }
                              },
                            ),
                            fallback: (context) =>
                                const Center(child: CircularProgressIndicator()),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
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

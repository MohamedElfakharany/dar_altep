// ignore_for_file: body_might_complete_normally_nullable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dar_altep/cubit/cubit.dart';
import 'package:dar_altep/cubit/states.dart';
import 'package:dar_altep/models/appointments_model.dart';
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

class LabVisitSubmitScreen extends StatefulWidget {
  const LabVisitSubmitScreen(
      {Key? key, required this.appointmentId, required this.appointmentsModel, required this.index})
      : super(key: key);
  final int appointmentId;
  final AppointmentsModel appointmentsModel;
  final int index;

  @override
  State<LabVisitSubmitScreen> createState() => _LabVisitSubmitScreenState();
}

class _LabVisitSubmitScreenState extends State<LabVisitSubmitScreen> {
  final nameController = TextEditingController();

  final mobileController = TextEditingController();

  final dateController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  final serviceItems = ['Sugar Test', 'Blood Test'];

  String? serviceValue;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppLabReservationsErrorState) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Error...!'),
                  content: Text(state.error),
                );
              });
        } else if (state is AppLabReservationsSuccessState) {
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
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  verticalMediumSpace,
                  Padding(
                    padding:
                    const EdgeInsetsDirectional.only(
                        start: 20.0),
                    child: Column(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: [
                        verticalMediumSpace,
                        Center(
                          child: Image.asset(
                            'assets/images/onboarding1.png',
                            height: height * 0.3,
                            width: width * 0.6,
                          ),
                        ),
                        verticalMediumSpace,
                        Text(
                          'Thank You',
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
                          'your data saved successfully and we will contact you',
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
                          title: 'Done',
                          onPress: () {
                            if (kDebugMode) {
                              print('done pressed');
                            }
                            Navigator.pushAndRemoveUntil(
                                context, FadeRoute(page: const HomeScreen()), (
                                route) => false);
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
        var user = AppCubit
            .get(context)
            .userdata
            ?.data;
        var appointment = AppCubit.get(context).appointmentsModel?.data?[widget.index];
        nameController.text = user?.name;
        mobileController.text = user?.phone;
        dateController.text = appointment?.date;
        return Scaffold(
          // extendBodyBehindAppBar: true,
          appBar: GeneralAppBar(
            title: LocaleKeys.TxtLabVisit.tr(),
          ),
          body: Container(
            padding: const EdgeInsetsDirectional.only(
              start: 10.0,
              top: 20.0,
              bottom: 20.0,
            ),
            height: MediaQuery
                .of(context)
                .size
                .height,
            width: MediaQuery
                .of(context)
                .size
                .width,
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
                            'Enter patient data and we will contact you to reserve',
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
                        DefaultFormField(
                          controller: nameController,
                          type: TextInputType.text,
                          validatedText: LocaleKeys.TxtFieldMessage.tr(),
                          label: LocaleKeys.TxtFieldMessage.tr(),
                          hintText: LocaleKeys.TxtFieldMessage.tr(),
                          contentPadding: const EdgeInsetsDirectional.only(
                              top: 10.0, start: 20.0, bottom: 10.0),
                        ),
                        verticalSmallSpace,
                        DefaultFormField(
                          controller: mobileController,
                          type: TextInputType.phone,
                          label: LocaleKeys.txtFieldMobile.tr(),
                          validatedText: LocaleKeys.txtFieldMobile.tr(),
                          hintText: LocaleKeys.txtFieldMobile.tr(),
                          suffixPressed: () {},
                        ),
                        verticalSmallSpace,
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
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                contentPadding:
                                const EdgeInsetsDirectional.only(
                                    start: 20.0, end: 10.0),
                                errorStyle:
                                const TextStyle(color: Color(0xFF4F4F4F)),
                                label: Text(LocaleKeys.txtTestName.tr()),
                                border: const OutlineInputBorder(
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
                          controller: dateController,
                          type: TextInputType.text,
                          validatedText: 'Date',
                          label: 'Date',
                          hintText: 'Date',
                        ),
                        verticalLargeSpace,
                        verticalLargeSpace,
                        ConditionalBuilder(
                          condition: state is! AppLabReservationsLoadingState,
                          builder: (context) =>
                              GeneralButton(
                                title: LocaleKeys.BtnSend.tr(),
                                onPress: () {
                                  if (formKey.currentState!.validate()) {
                                    if (kDebugMode) {
                                      print(
                                          'from ConditionalBuilder btn pressed');
                                    }
                                    AppCubit.get(context).addLabReservation(
                                      serviceName: serviceValue ?? '',
                                      name: nameController.text,
                                      phone: mobileController.text,
                                      appointmentId: '${appointment?.id}',
                                      date: appointment?.date,
                                      time: appointment?.time,);
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
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) =>
      DropdownMenuItem(
        value: item,
        child: Text(item),
      );
}

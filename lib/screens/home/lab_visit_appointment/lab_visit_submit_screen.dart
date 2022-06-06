// ignore_for_file: body_might_complete_normally_nullable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dar_altep/cubit/cubit.dart';
import 'package:dar_altep/cubit/states.dart';
import 'package:dar_altep/models/appointments_model.dart';
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

class LabVisitSubmitScreen extends StatefulWidget {
  const LabVisitSubmitScreen(
      {Key? key,
      required this.appointmentId,
      required this.appointments,
      required this.index,
      this.testNames,
      this.user})
      : super(key: key);
  final int appointmentId;
  final AppointmentsModel appointments;
  final int index;
  final List<String>? testNames;
  final UserModel? user;

  @override
  State<LabVisitSubmitScreen> createState() => _LabVisitSubmitScreenState();
}

class _LabVisitSubmitScreenState extends State<LabVisitSubmitScreen> {
  final nameController = TextEditingController();

  final mobileController = TextEditingController();

  final dateController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  String? serviceValue;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is AppLabReservationsErrorState) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(LocaleKeys.txtError.tr()),
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
                              'assets/images/onboarding1.png',
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
          nameController.text = widget.user?.data?.name;
          mobileController.text = widget.user?.data?.phone;
          dateController.text = widget.appointments.data?[widget.index].date;
          var uploadImage = AppCubit.get(context).labVisitImage;
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
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage(
                      "assets/images/onboardingbackground.png"),
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
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
                                items: widget.testNames
                                    ?.map(buildMenuItem)
                                    .toList(),
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
                          GeneralButton(title: 'Upload Image', onPress: (){
                            showPopUp(
                              context,
                              Container(
                                height: 280,
                                width: MediaQuery.of(context).size.width * 0.9,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    verticalMediumSpace,
                                    Padding(
                                      padding:
                                      const EdgeInsetsDirectional.only(start: 20.0),
                                      child: Text(
                                        'Pick Image',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: fontFamily,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    verticalMicroSpace,
                                    myDivider(),
                                    verticalLargeSpace,
                                    GeneralUnfilledButton(
                                      borderWidth: 1,
                                      btnRadius: radius - 5,
                                      borderColor: blueLight,
                                      title: 'Open Camera',
                                      // image: 'assets/images/homeIcon.png',
                                      width: double.infinity,
                                      onPress: () {
                                        AppCubit.get(context).getLabVisitImage(isCamera: true);
                                        Navigator.pop(context);
                                      },
                                    ),
                                    verticalLargeSpace,
                                    GeneralUnfilledButton(
                                      btnRadius: radius - 5,
                                      borderColor: whiteColor,
                                      title: 'Open Gallery',
                                      // image: 'assets/images/labIcon.png',
                                      width: double.infinity,
                                      onPress: () {
                                        AppCubit.get(context).getLabVisitImage(isCamera: false);
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                          verticalSmallSpace,
                          if (uploadImage != null)
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Image.file(
                                uploadImage,
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          verticalLargeSpace,
                          ConditionalBuilder(
                            condition: state is! AppLabReservationsLoadingState,
                            builder: (context) => GeneralButton(
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
                                    appointmentId:
                                        '${widget.appointments.data?[widget.index].id}',
                                    date: widget
                                        .appointments.data?[widget.index].date,
                                    time: widget
                                        .appointments.data?[widget.index].time,
                                    image: uploadImage == null
                                        ? ''
                                        : 'storage/photosOffer/${Uri.file(uploadImage.path).pathSegments.last}',
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

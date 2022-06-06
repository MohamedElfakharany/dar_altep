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

class HomeVisitScreen extends StatefulWidget {
  HomeVisitScreen({Key? key, this.user, this.testNames, this.testName})
      : super(key: key);
  String? testName;
  List<String>? testNames = [];
  UserModel? user;

  @override
  State<HomeVisitScreen> createState() => _HomeVisitScreenState();
}

class _HomeVisitScreenState extends State<HomeVisitScreen> {
  final nameController = TextEditingController();

  final mobileController = TextEditingController();

  final addressController = TextEditingController();

  final dateOfVisitController = TextEditingController();

  final testNameController = TextEditingController();

  final timeController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..getProfileData(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is AppHomeReservationsErrorState) {
          } else if (state is AppHomeReservationsSuccessState) {
            if (!state.homeReservationsModel.status) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(LocaleKeys.txtError.tr(),),
                      content:
                          Text(state.homeReservationsModel.message.toString()),
                    );
                  });
            }
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
          // if (kDebugMode) {
          //   print('widget.testName ${widget.testName}');
          // }
          nameController.text = widget.user?.data?.name;
          mobileController.text = widget.user?.data?.phone;
          testNameController.text = widget.testName ?? '';
          String? testValue = widget.testName ?? widget.testNames?.first;
          String idValue = AppCubit.get(context)
              .testNames!
              .where((element) => element.name == testValue)
              .toString();
          var uploadImage = AppCubit.get(context).homeVisitImage;
          return Scaffold(
            appBar: GeneralAppBar(
              title: LocaleKeys.txtHomeVisitAppBar.tr(),
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
                physics: const BouncingScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 20),
                    child: Form(
                      key: formKey,
                      child: ConditionalBuilder(
                        condition: AppCubit.get(context).testsModel == null,
                        builder: (context) => Column(
                          children: [
                            Center(
                              child: Text(
                                LocaleKeys.txtHomeMain.tr(),
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
                              type: TextInputType.name,
                              label: LocaleKeys.txtFieldName.tr(),
                              validatedText: LocaleKeys.txtFieldName.tr(),
                              hintText: LocaleKeys.txtFieldName.tr(),
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
                            DefaultFormField(
                              controller: addressController,
                              type: TextInputType.text,
                              validatedText: LocaleKeys.txtFieldName.tr(),
                              label: LocaleKeys.txtFieldAddress.tr(),
                              onTap: (){},
                            ),
                            verticalSmallSpace,
                            DefaultFormField(
                              controller: dateOfVisitController,
                              type: TextInputType.none,
                              validatedText:
                                  LocaleKeys.TxtFieldDateOfVisit.tr(),
                              label: LocaleKeys.TxtFieldDateOfVisit.tr(),
                              onTap: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime?.now(),
                                  firstDate: DateTime?.now(),
                                  lastDate: DateTime?.now().add(const Duration(days: 6)),
                                ).then((value) {
                                  dateOfVisitController.text =
                                      DateFormat.yMd().format(value!);
                                  FocusScope.of(context).unfocus();
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
                            DefaultFormField(
                              controller: timeController,
                              type: TextInputType.none,
                              suffixIcon: Icons.watch_later_outlined,
                              label: LocaleKeys.TxtFieldTimeOfVisit.tr(),
                              validatedText:
                                  LocaleKeys.TxtFieldTimeOfVisit.tr(),
                              onTap: () async {
                                try {
                                  var time = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now());
                                  timeController.text =
                                      time!.format(context).toString();
                                  FocusScope.of(context).unfocus();
                                  if (kDebugMode) {
                                    print(timeController.text);
                                  }
                                } catch (error) {
                                  if (kDebugMode) {
                                    print(error);
                                  }
                                }
                              },
                              onSubmit: (){
                                FocusScope.of(context).unfocus();
                              },
                            ),
                            verticalSmallSpace,
                            if (widget.testName == null)
                              Container(
                                height: 60.0,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
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
                                        return LocaleKeys.txtTestName.tr();
                                      }
                                    },
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      contentPadding:
                                          const EdgeInsetsDirectional.only(
                                              start: 20.0, end: 10.0),
                                      errorStyle: const TextStyle(
                                          color: Color(0xFF4F4F4F)),
                                      label: Text(LocaleKeys.txtTestName.tr()),
                                      border: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 2,
                                          color: blueDark,
                                        ),
                                      ),
                                    ),
                                    value: testValue,
                                    isExpanded: true,
                                    iconSize: 35,
                                    items: widget.testNames
                                        ?.map(buildMenuItem)
                                        .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        testValue = value;
                                        if (kDebugMode) {
                                          print(
                                              'testValue ${testValue.toString()}');
                                        }
                                        idValue = AppCubit.get(context)
                                            .testNames!
                                            .where((element) =>
                                                element.name == testValue)
                                            .toString();
                                      });
                                      if (kDebugMode) {
                                        print('idValue : $idValue');
                                      }
                                    },
                                  ),
                                ),
                              ),
                            if (widget.testName != null)
                              DefaultFormField(
                                readOnly: true,
                                controller: testNameController,
                                type: TextInputType.text,
                                label: LocaleKeys.txtTestName.tr(),
                                validatedText: LocaleKeys.txtTestName.tr(),
                              ),
                            verticalLargeSpace,
                            GeneralButton(title: LocaleKeys.BtnUploadImage.tr(), onPress: (){
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
                                          LocaleKeys.txtPickImage.tr(),
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
                                        title: LocaleKeys.BtnOpenCamera.tr(),
                                        // image: 'assets/images/homeIcon.png',
                                        width: double.infinity,
                                        onPress: () {
                                          AppCubit.get(context).getHomeVisitImage(isCamera: true);
                                          Navigator.pop(context);
                                        },
                                      ),
                                      verticalLargeSpace,
                                      GeneralUnfilledButton(
                                        btnRadius: radius - 5,
                                        borderColor: whiteColor,
                                        title: LocaleKeys.BtnGallery.tr(),
                                        // image: 'assets/images/labIcon.png',
                                        width: double.infinity,
                                        onPress: () {
                                          AppCubit.get(context).getHomeVisitImage(isCamera: false);
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
                              condition:
                                  state is! AppHomeReservationsLoadingState,
                              builder: (context) => GeneralButton(
                                title: LocaleKeys.BtnSubmit.tr(),
                                onPress: () {
                                  if (formKey.currentState!.validate()) {
                                    AppCubit.get(context).addHomeReservation(
                                      name: nameController.text,
                                      phone: mobileController.text,
                                      testName: testValue ?? '',
                                      address: addressController.text,
                                      dateOfVisit: dateOfVisitController.text,
                                      time: timeController.text,
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
                        fallback: (context) => const ScreenHolder('data'),
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

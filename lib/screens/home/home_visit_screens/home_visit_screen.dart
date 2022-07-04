// ignore_for_file: must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dar_altep/cubit/cubit.dart';
import 'package:dar_altep/cubit/states.dart';
import 'package:dar_altep/models/auth/user_model.dart';
import 'package:dar_altep/screens/home/home_screen.dart';
import 'package:dar_altep/shared/components/general_components.dart';
import 'package:dar_altep/shared/constants/colors.dart';
import 'package:dar_altep/shared/constants/general_constants.dart';
import 'package:dar_altep/shared/network/local/const_shared.dart';
import 'package:dar_altep/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:searchfield/searchfield.dart';

//AIzaSyD2_OeF1fg8mpOTZwM1HMmx4MkJRD8PM1E
class HomeVisitScreen extends StatefulWidget {
  HomeVisitScreen(
      {required this.date,
      Key? key,
      this.user,
      this.testNames,
      this.testName,
      required this.address,
      required this.timing,
      required this.lat,
      required this.long})
      : super(key: key);
  String? testName;
  List<String>? testNames = [];
  UserModel? user;
  final String address;
  final String timing;
  final String date;
  final double lat;
  final double long;

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
  String? _selectedItem;

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
                      title: Text(
                        LocaleKeys.txtError.tr(),
                      ),
                      content:
                          Text(state.homeReservationsModel.message.toString()),
                    );
                  });
            }
            showPopUp(
              context,
              Container(
                height: height * 0.75,
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
                            style: const TextStyle(
                              fontSize: 20,
                              fontFamily: fontFamily,
                              fontWeight: FontWeight.bold,
                              color: blueDark,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          verticalMediumSpace,
                          Text(
                            LocaleKeys.txtHomeReservationSucceeded.tr(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
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
          if (kDebugMode) {
            print('widget.testName ${widget.testName}');
          }
          nameController.text = widget.user?.data?.name ?? '';
          mobileController.text = widget.user?.data?.phone ?? '';
          testNameController.text = widget.testName ?? '';
          addressController.text = widget.address;
          dateOfVisitController.text = widget.date;
          timeController.text = widget.timing;
          String? testValue = widget.testName;
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
                                style: const TextStyle(
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
                              readOnly: true,
                              controller: addressController,
                              type: TextInputType.none,
                              validatedText: LocaleKeys.txtFieldName.tr(),
                              label: LocaleKeys.txtFieldAddress.tr(),
                              onTap: () {},
                            ),
                            verticalSmallSpace,
                            DefaultFormField(
                              readOnly: true,
                              controller: dateOfVisitController,
                              type: TextInputType.none,
                              validatedText:
                                  LocaleKeys.TxtFieldDateOfVisit.tr(),
                              label: LocaleKeys.TxtFieldDateOfVisit.tr(),
                              onTap: () {},
                              suffixIcon: Icons.calendar_month,
                            ),
                            verticalSmallSpace,
                            DefaultFormField(
                              readOnly: true,
                              controller: timeController,
                              type: TextInputType.none,
                              suffixIcon: Icons.watch_later_outlined,
                              label: LocaleKeys.TxtFieldTimeOfVisit.tr(),
                              validatedText:
                                  LocaleKeys.TxtFieldTimeOfVisit.tr(),
                              onTap: () {},
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
                                    // ignore: body_might_complete_normally_nullable
                                    validator: (value) {
                                      if (value == null) {
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
                                        widget.testName = value ;
                                        if (kDebugMode) {
                                          print(
                                              'testValue ${testValue.toString()}');
                                        }
                                      });
                                    },
                                  ),
                                ),
                                // SearchField<String>(
                                //   hint: LocaleKeys.txtTestName.tr(),
                                //   searchInputDecoration: InputDecoration(
                                //     enabledBorder: OutlineInputBorder(
                                //       borderSide: BorderSide(
                                //         color: Colors.blueGrey.shade200,
                                //         width: 1,
                                //       ),
                                //       borderRadius: BorderRadius.circular(10),
                                //     ),
                                //     focusedBorder: OutlineInputBorder(
                                //       borderSide: BorderSide(
                                //         width: 2,
                                //         color: Colors.blue.withOpacity(0.8),
                                //       ),
                                //       borderRadius: BorderRadius.circular(10),
                                //     ),
                                //   ),
                                //   maxSuggestionsInViewPort: 6,
                                //   itemHeight: 50,
                                //   suggestionsDecoration: BoxDecoration(
                                //     color: Colors.white,
                                //     borderRadius: BorderRadius.circular(10),
                                //   ),
                                //   // onSuggestionTap: (value) {
                                //   //   AppCubit.get(context)
                                //   //       .getTestsData(testName: value.toString());
                                //   // },
                                //   validator: (value){
                                //     if (value == null) {
                                //       return LocaleKeys.txtTestName.tr();
                                //     }
                                //   },
                                //   onSuggestionTap: (value){
                                //
                                //   },
                                //   onSubmit: (value) {
                                //     setState(() {
                                //       _selectedItem = value;
                                //     });
                                //   },
                                //   suggestions: widget.testNames!
                                //       .map(
                                //         (e) => SearchFieldListItem<String>(
                                //       e,
                                //       item: e,
                                //     ),
                                //   )
                                //       .toList(),
                                // ),
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
                            GeneralButton(
                                title: LocaleKeys.BtnUploadImage.tr(),
                                onPress: () {
                                  showPopUp(
                                    context,
                                    Container(
                                      height: 280,
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          verticalMediumSpace,
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .only(start: 20.0),
                                            child: Text(
                                              LocaleKeys.txtPickImage.tr(),
                                              style: const TextStyle(
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
                                            title:
                                                LocaleKeys.BtnOpenCamera.tr(),
                                            // image: 'assets/images/homeIcon.png',
                                            width: double.infinity,
                                            onPress: () {
                                              AppCubit.get(context)
                                                  .getHomeVisitImage(
                                                      isCamera: true);
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
                                              AppCubit.get(context)
                                                  .getHomeVisitImage(
                                                      isCamera: false);
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
                                      testName: widget.testName!,
                                      address: addressController.text,
                                      dateOfVisit: widget.date,
                                      time: timeController.text,
                                      image: uploadImage == null
                                          ? ''
                                          : 'storage/photosOffer/${Uri.file(uploadImage.path).pathSegments.last}',
                                      lat: widget.lat,
                                      long: widget.long,
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

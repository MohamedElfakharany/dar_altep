// ignore_for_file: must_be_immutable

import 'package:dar_altep/cubit/cubit.dart';
import 'package:dar_altep/models/offers_model.dart';
import 'package:dar_altep/models/tests_model.dart';
import 'package:dar_altep/screens/home/home_visit_screens/map_screen.dart';
import 'package:dar_altep/screens/home/lab_visit_appointment/lab_visit_appointment_screen.dart';
import 'package:dar_altep/shared/components/cached_network_image.dart';
import 'package:dar_altep/shared/components/general_components.dart';
import 'package:dar_altep/shared/constants/colors.dart';
import 'package:dar_altep/shared/constants/general_constants.dart';
import 'package:dar_altep/shared/network/local/const_shared.dart';
import 'package:dar_altep/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PrecautionsScreen extends StatelessWidget {
  PrecautionsScreen({
    Key? key,
    this.offersModel,
    this.testsModel,
    required this.index,
  }) : super(key: key);
  OffersModel? offersModel;
  TestsModel? testsModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: GeneralAppBar(title: LocaleKeys.BtnPrecautions.tr()),
      body: Container(
        padding: const EdgeInsetsDirectional.only(
            start: 10.0, top: 12.0, bottom: 12.0, end: 10.0),
        height: height,
        width: width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage("assets/images/onboardingbackground.png"),
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.15), BlendMode.dstATop),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              border: Border.all(color: whiteColor, width: 0.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.15),
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: const Offset(0, 2),
                ),
              ],
              color: whiteColor,
            ),
            child: ListView(
              children: [
                Center(
                  child: CachedNetworkImageNormal(
                    imageUrl: offersModel?.data?[index].image ??
                        testsModel?.data?[index].image,
                    // imageUrl:
                    //     'https://image.shutterstock.com/image-photo/mountains-under-mist-morning-amazing-260nw-1725825019.jpg',
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.width * 0.4,
                  ),
                ),
                verticalLargeSpace,
                Center(
                  child: Text(
                    offersModel?.data?[index].name ??
                        testsModel?.data?[index].name,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                      fontFamily: fontFamily,
                    ),
                  ),
                ),
                verticalMiniSpace,
                Center(
                  child: Text(
                    offersModel?.data?[index].type ??
                        testsModel?.data?[index].type,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: 20,
                      color: blueDark,
                      fontWeight: FontWeight.bold,
                      fontFamily: fontFamily,
                    ),
                  ),
                ),
                if (offersModel?.data?[index].testOffer == 'individual')
                  verticalMiniSpace,
                if (offersModel?.data?[index].testOffer == 'individual')
                  Center(
                    child: Text(
                      LocaleKeys.BtnAtHome.tr(),
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontSize: 20,
                        color: blueDark,
                        fontWeight: FontWeight.bold,
                        fontFamily: fontFamily,
                      ),
                    ),
                  ),
                if (offersModel?.data?[index].testOffer == 'laboratory')
                  verticalMiniSpace,
                if (offersModel?.data?[index].testOffer == 'laboratory')
                  Center(
                    child: Text(
                      LocaleKeys.BtnAtLab.tr(),
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontSize: 20,
                        color: blueDark,
                        fontWeight: FontWeight.bold,
                        fontFamily: fontFamily,
                      ),
                    ),
                  ),
                verticalMediumSpace,
                Text(
                  offersModel?.data?[index].description ??
                      testsModel?.data?[index].description,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                    fontFamily: fontFamily,
                  ),
                ),
                verticalMiniSpace,
                Row(
                  children: [
                    if (offersModel?.data?[index].discount != null)
                      Text(
                        '${offersModel?.data?[index].discount} ${LocaleKeys.salary.tr()}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: fontFamily,
                          decoration: TextDecoration.lineThrough,
                          color: darkColor,
                        ),
                      ),
                    if (offersModel?.data?[index].price != null)
                      horizontalSmallSpace,
                    if (offersModel?.data?[index].price != null)
                      Text(
                        '${offersModel?.data?[index].price} ${LocaleKeys.salary.tr()}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: titleStyle,
                      ),
                    if (testsModel?.data?[index].price != null)
                      Text(
                        '${testsModel?.data?[index].price} ${LocaleKeys.salary.tr()}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: titleStyle,
                      ),
                  ],
                ),
                verticalMiniSpace,
                Row(
                  children: [
                    Text('${LocaleKeys.txtDuration.tr()}:   ',
                        textAlign: TextAlign.start, style: subTitleSmallStyle),
                    Text(
                      '${offersModel?.data?[index].duration ?? testsModel?.data?[index].duration} ${LocaleKeys.txthomeOfferCardDays.tr()}',
                      textAlign: TextAlign.start,
                      style: titleStyle,
                    ),
                  ],
                ),
                verticalLargeSpace,
                Container(
                  height: 50.0,
                  width: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: const LinearGradient(
                      colors: [blueDark, blueLight],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: blueDark.withOpacity(0.25),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset:
                            const Offset(0, 5), // changes position of shadow
                      ),
                    ],
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      if (offersModel?.data?[index].testOffer == 'individual') {
                        Navigator.push(
                          context,
                          FadeRoute(
                            page: MapScreen(
                              testName: offersModel?.data?[index].type,
                            ),
                          ),
                        );
                      }
                      if (offersModel?.data?[index].testOffer == 'laboratory') {
                        Navigator.push(
                          context,
                          FadeRoute(
                            page: LabVisitAppointmentScreen(
                              appointments:
                                  AppCubit.get(context).appointmentsModel,
                              user: AppCubit.get(context).userModel,
                              testNames: AppCubit.get(context).testName,
                            ),
                          ),
                        );
                      }
                      if (testsModel?.data != null){
                        showPopUp(
                          context,
                          Container(
                            height: 230,
                            width: MediaQuery.of(context).size.width * 0.6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                verticalMiniSpace,
                                Padding(
                                  padding:
                                  const EdgeInsetsDirectional.only(start: 20.0),
                                  child: Text(
                                    LocaleKeys.TxtPopUpReservationType.tr(),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontFamily: fontFamily,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                verticalMicroSpace,
                                myDivider(),
                                verticalMiniSpace,
                                GeneralUnfilledButton(
                                  borderWidth: 1,
                                  btnRadius: radius - 5,
                                  borderColor: blueLight,
                                  title: LocaleKeys.BtnAtHome.tr(),
                                  image: 'assets/images/homeIcon.png',
                                  width: double.infinity,
                                  onPress: () {
                                    Navigator.pop(context);
                                    // Navigator.push(
                                    //     context,
                                    //     FadeRoute(
                                    //         page: HomeVisitScreen(
                                    //       testNames: testNames,
                                    //       user: user,
                                    //     )));
                                    Navigator.push(
                                      context,
                                      FadeRoute(
                                        page: MapScreen(testName: testsModel?.data?[index].name),
                                      ),
                                    );
                                  },
                                ),
                                verticalMediumSpace,
                                GeneralUnfilledButton(
                                  btnRadius: radius - 5,
                                  borderColor: whiteColor,
                                  title: LocaleKeys.BtnAtLab.tr(),
                                  image: 'assets/images/labIcon.png',
                                  width: double.infinity,
                                  onPress: () {
                                    Navigator.pop(context);
                                    Navigator.push(
                                        context,
                                        FadeRoute(
                                            page: LabVisitAppointmentScreen(
                                              appointments:
                                              AppCubit.get(context).appointmentsModel,
                                              user: AppCubit.get(context).userModel,
                                              testNames: AppCubit.get(context).testName,
                                              testName: testsModel?.data?[index].name,
                                            )));
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    },
                    child: Center(
                      child: Text(
                        LocaleKeys.BtnConfirm.tr(),
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

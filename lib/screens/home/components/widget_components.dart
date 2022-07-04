// ignore_for_file: must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dar_altep/cubit/cubit.dart';
import 'package:dar_altep/cubit/states.dart';
import 'package:dar_altep/models/appointments_model.dart';
import 'package:dar_altep/models/auth/user_model.dart';
import 'package:dar_altep/models/home_appointments_model.dart';
import 'package:dar_altep/models/notification_model.dart';
import 'package:dar_altep/models/offers_model.dart';
import 'package:dar_altep/models/tests_model.dart';
import 'package:dar_altep/screens/home/home_visit_screens/map_screen.dart';
import 'package:dar_altep/screens/home/lab_visit_appointment/lab_visit_appointment_screen.dart';
import 'package:dar_altep/screens/home/lab_visit_appointment/lab_visit_submit_screen.dart';
import 'package:dar_altep/screens/home/home_visit_screens/home_visit_screen.dart';
import 'package:dar_altep/screens/home/test_screen/precautions_screen.dart';
import 'package:dar_altep/shared/components/cached_network_image.dart';
import 'package:dar_altep/shared/components/general_components.dart';
import 'package:dar_altep/shared/constants/colors.dart';
import 'package:dar_altep/shared/constants/general_constants.dart';
import 'package:dar_altep/shared/network/local/const_shared.dart';
import 'package:dar_altep/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeOffersCard extends StatelessWidget {
  const HomeOffersCard({
    Key? key,
    this.offersModel,
    required this.context,
    required this.index,
    required this.user,
    required this.testNames,
    this.appointments,
  }) : super(key: key);
  final UserModel? user;
  final List<String>? testNames;
  final OffersModel? offersModel;
  final AppointmentsModel? appointments;
  final BuildContext context;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! AppGetOffersLoadingState,
          builder: (context) => Padding(
            padding: const EdgeInsetsDirectional.only(
              start: 10.0,
              top: 12.0,
              bottom: 12.0,
            ),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 4,
                    blurRadius: 6,
                    offset: const Offset(0, 1), // changes position of shadow
                  ),
                ],
                border: Border.all(color: whiteColor),
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              width: 160.0,
              height: 230.0,
              child: Stack(
                children: [
                  Positioned.fill(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 100,
                    child: CachedNetworkImageNormal(
                      imageUrl: offersModel?.data?[index].image,
                      // imageUrl: 'https://avatars.githubusercontent.com/u/34916493?s=400&u=e7300b829193270fbcd03a813551a3702299cbb1&v=4',
                      imageBoxFit: BoxFit.cover,
                      height: 10.0,
                    ),
                  ),
                  Positioned.fill(
                    top: 100,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: whiteColor,
                      ),
                      height: 122,
                      padding: const EdgeInsetsDirectional.only(
                          top: 10.0, start: 10.0, end: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${offersModel?.data?[index].name}',
                            style: const TextStyle(
                              fontFamily: fontFamily,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          // verticalMicroSpace,
                          Text(
                            '${LocaleKeys.txtDuration.tr()}: ${offersModel?.data?[index].duration} ${LocaleKeys.txthomeOfferCardDays.tr()}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: subTitleSmallStyle,
                          ),
                          // verticalMicroSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${offersModel?.data?[index].price} ${LocaleKeys.salary.tr()}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontFamily: fontFamily,
                                  decoration: TextDecoration.lineThrough,
                                  color: darkColor,
                                ),
                              ),
                              horizontalSmallSpace,
                              horizontalSmallSpace,
                              Text(
                                '${offersModel?.data?[index].discount} ${LocaleKeys.salary.tr()}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: titleSmallStyle,
                              ),
                            ],
                          ),
                          verticalMicroSpace,
                          Container(
                            width: double.infinity,
                            height: 30,
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
                                  offset: const Offset(
                                      0, 5), // changes position of shadow
                                ),
                              ],
                            ),
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  FadeRoute(
                                    page: PrecautionsScreen(
                                      offersModel: offersModel,
                                      index: index,
                                    ),
                                  ),
                                );
                                // if (offersModel?.data?[index].testOffer ==
                                //     'individual') {
                                //   Navigator.push(
                                //     context,
                                //     FadeRoute(
                                //       page: MapScreen(
                                //         testName:
                                //             offersModel?.data?[index].type,
                                //       ),
                                //     ),
                                //   );
                                // }
                                // if (offersModel?.data?[index].testOffer ==
                                //     'laboratory') {
                                //   Navigator.push(
                                //       context,
                                //       FadeRoute(
                                //           page: LabVisitAppointmentScreen(
                                //         appointments: appointments,
                                //         user: user,
                                //         testNames: testNames,
                                //       )));
                                // }
                              },
                              child: Center(
                                child: Text(
                                  LocaleKeys.BtnMore.tr(),
                                  style: const TextStyle(
                                    fontSize: 12,
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
                ],
              ),
            ),
          ),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

class TestLibraryCard extends StatelessWidget {
  TestLibraryCard({
    Key? key,
    this.testsModel,
    required this.context,
    required this.index,
    this.user,
    this.testNames,
    // this.appointments
  }) : super(key: key);
  final UserModel? user;
  final List<String>? testNames;
  final TestsModel? testsModel;

  // final AppointmentsModel? appointments;
  final BuildContext context;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsetsDirectional.only(
              start: 10.0, top: 12.0, end: 10.0),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 4,
                  blurRadius: 6,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
              border: Border.all(color: whiteColor),
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            width: double.infinity,
            height: 115.0,
            child: Row(
              children: [
                CachedNetworkImageNormal(
                  imageUrl: testsModel?.data?[index].image,
                  width: 130,
                  height: double.infinity,
                ),
                horizontalMiniSpace,
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: whiteColor,
                    ),
                    // padding: const EdgeInsetsDirectional.all(10.0),
                    // height: 115,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${AppCubit.get(context).testsModel?.data?[index].name}',
                              style: titleStyle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsetsDirectional.only(
                                  top: 10.0, end: 20.0),
                              child: CircleAvatar(
                                radius: 12,
                                backgroundColor: blueDark,
                                child: FloatingActionButton(
                                  elevation: 10,
                                  backgroundColor: blueDark,
                                  child: const Icon(
                                    Icons.add_rounded,
                                    color: whiteColor,
                                    size: 25,
                                  ),
                                  onPressed: () {
                                    showPopUp(
                                      context,
                                      Container(
                                        height: 230,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            verticalMiniSpace,
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .only(start: 20.0),
                                              child: Text(
                                                LocaleKeys
                                                        .TxtPopUpReservationType
                                                    .tr(),
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
                                              image:
                                                  'assets/images/homeIcon.png',
                                              width: double.infinity,
                                              onPress: () {
                                                Navigator.pop(context);
                                                Navigator.push(
                                                  context,
                                                  FadeRoute(
                                                    page: MapScreen(testName: AppCubit.get(context).testsModel?.data?[index].name),
                                                  ),
                                                );
                                              },
                                            ),
                                            verticalMediumSpace,
                                            GeneralUnfilledButton(
                                              btnRadius: radius - 5,
                                              borderColor: whiteColor,
                                              title: LocaleKeys.BtnAtLab.tr(),
                                              image:
                                                  'assets/images/labIcon.png',
                                              width: double.infinity,
                                              onPress: () {
                                                Navigator.pop(context);
                                                Navigator.push(
                                                    context,
                                                    FadeRoute(
                                                        page:
                                                            LabVisitAppointmentScreen(
                                                              testName: AppCubit.get(context).testsModel?.data?[index].name,
                                                      appointments: AppCubit
                                                              .get(context)
                                                          .appointmentsModel,
                                                      user: user,

                                                      testNames: testNames,
                                                    )));
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(end: 30),
                          child: Text(
                            '${LocaleKeys.txtDuration.tr()}: ${testsModel?.data?[index].duration} ${LocaleKeys.txthomeOfferCardDays.tr()}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: fontFamily,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Text(
                              '${testsModel?.data?[index].price} ${LocaleKeys.salary.tr()}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontFamily: fontFamily,
                              ),
                            ),
                            const Spacer(),
                            GeneralUnfilledButton(
                              title: LocaleKeys.BtnPrecautions.tr(),
                              titleSize: 12,
                              height: 30,
                              width: 80,
                              btnRadius: 8,
                              borderColor: blueLight,
                              onPress: () {
                                Navigator.push(
                                  context,
                                  FadeRoute(
                                    page: PrecautionsScreen(
                                      testsModel: testsModel,
                                      index: index,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class OffersCard extends StatelessWidget {
  const OffersCard(
      {Key? key,
      this.offersModel,
      required this.context,
      required this.index,
      this.user,
      this.testNames,
      this.appointments})
      : super(key: key);
  final UserModel? user;
  final AppointmentsModel? appointments;
  final List<String>? testNames;
  final OffersModel? offersModel;
  final BuildContext context;
  final int index;

  @override
  Widget build(BuildContext context) {
    // var width = MediaQuery.of(context).size.width;
    return Padding(
      padding:
          const EdgeInsetsDirectional.only(start: 10.0, top: 12.0, end: 10.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 4,
              blurRadius: 6,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          border: Border.all(color: whiteColor),
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        width: double.infinity,
        height: 120.0,
        child: Row(
          children: [
            horizontalMicroSpace,
            CachedNetworkImageNormal(
              imageUrl: offersModel?.data?[index].image,
              width: 115,
              height: 90,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${offersModel?.data?[index].name}',
                      style: titleStyle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    verticalMicroSpace,
                    Text(
                      '${offersModel?.data?[index].description}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: subTitleSmallStyle,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GeneralUnfilledButton(
                            title: LocaleKeys.BtnMore.tr(),
                            onPress: () {
                              Navigator.push(
                                context,
                                FadeRoute(
                                  page: PrecautionsScreen(
                                    offersModel: offersModel,
                                    index: index,
                                  ),
                                ),
                              );
                            },
                            width: 50,
                            height: 30,
                            btnRadius: 8.0,
                          ),
                          Container(
                            height: 30.0,
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
                                  offset: const Offset(
                                      0, 5), // changes position of shadow
                                ),
                              ],
                            ),
                            child: MaterialButton(
                              onPressed: () {
                                if (offersModel?.data?[index].testOffer ==
                                    'individual') {
                                  Navigator.push(
                                    context,
                                    FadeRoute(
                                      page: MapScreen(
                                        testName:
                                            offersModel?.data?[index].type,
                                      ),
                                    ),
                                  );
                                }
                                if (offersModel?.data?[index].testOffer ==
                                    'laboratory') {
                                  Navigator.push(
                                      context,
                                      FadeRoute(
                                          page: LabVisitAppointmentScreen(
                                        appointments: appointments,
                                        user: user,
                                        testNames: testNames,
                                      )));
                                }
                              },
                              child: Center(
                                child: Text(
                                  LocaleKeys.BtnConfirm.tr(),
                                  style: const TextStyle(
                                    fontSize: 12,
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  AppointmentCard({
    Key? key,
    this.appointments,
    required this.context,
    required this.index,
    this.user,
    this.testNames,
    this.testName,
  }) : super(key: key);

  final AppointmentsModel? appointments;
  final BuildContext context;
  final int index;
  final UserModel? user;
  final List<String>? testNames;
  String? testName;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            FadeRoute(
                page: LabVisitSubmitScreen(
              user: user,
              testNames: testNames,
              testName: testName,
              index: index,
              appointments: appointments!,
              appointmentId: appointments?.data?[index].id,
            )));
      },
      /*appointments?.data?[index].day,
              style: const TextStyle(
                  fontFamily: fontFamily,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),*/
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
        decoration: const BoxDecoration(color: whiteColor),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          decoration: BoxDecoration(
            color: whiteColor,
            border: Border.all(color: blueLight),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text(
                      LocaleKeys.txtStartAt.tr(),
                      style: const TextStyle(
                        color: blueDark2,
                        fontFamily: fontFamily,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '${appointments?.data?[index].start_time}',
                      style: const TextStyle(
                        color: blueDark,
                        fontFamily: fontFamily,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Expanded(
                child: Row(
                  children: [
                    Text(
                      LocaleKeys.txtEndAt.tr(),
                      style: const TextStyle(
                        color: blueDark2,
                        fontFamily: fontFamily,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '${appointments?.data?[index].end_time}',
                      style: const TextStyle(
                        color: blueDark,
                        fontFamily: fontFamily,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeAppointmentCard extends StatelessWidget {
  HomeAppointmentCard({
    Key? key,
    required this.context,
    required this.index,
    this.user,
    this.testNames,
    required this.address,
    this.lat,
    this.long,
    this.homeAppointments,
    this.testName,
  }) : super(key: key);

  final HomeAppointmentsModel? homeAppointments;
  final BuildContext context;
  final int index;
  final UserModel? user;
  final List<String>? testNames;
  final String address;
  final String? testName;
  dynamic lat = 0.0;
  dynamic long = 0.0;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            FadeRoute(
                page: HomeVisitScreen(
              user: user,
              testNames: testNames,
              testName: testName,
              address: address,
              timing: homeAppointments?.data?[index].timing,
              date: homeAppointments?.data?[index].date,
              lat: lat,
              long: long,
            )));
      },
      child: Container(
        height: 85,
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
        decoration: const BoxDecoration(color: whiteColor),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          decoration: BoxDecoration(
            color: whiteColor,
            border: Border.all(color: blueLight),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${homeAppointments?.data?[index].timing}',
                style: const TextStyle(
                  color: blueDark,
                  fontFamily: fontFamily,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              verticalMicroSpace,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          LocaleKeys.txtStartAt.tr(),
                          style: const TextStyle(
                            color: blueDark2,
                            fontFamily: fontFamily,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '${homeAppointments?.data?[index].startTime}',
                          style: const TextStyle(
                            color: blueDark,
                            fontFamily: fontFamily,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          LocaleKeys.txtEndAt.tr(),
                          style: const TextStyle(
                            color: blueDark2,
                            fontFamily: fontFamily,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '${homeAppointments?.data?[index].endTime}',
                          style: const TextStyle(
                            color: blueDark,
                            fontFamily: fontFamily,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NotificationCard extends StatefulWidget {
  NotificationCard(
      {required this.index, required this.notificationsModel, Key? key})
      : super(key: key);
  NotificationsModel? notificationsModel;
  int index;

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  @override
  Widget build(BuildContext context) {
    Color containerColor = whiteColor;
    setState((){
      if (widget.notificationsModel?.data?[widget.index].seen ==
          0) {
        containerColor = blueLight.withOpacity(0.1);
      } else {
        containerColor = whiteColor;
      }
    });
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          child: Container(
            constraints: const BoxConstraints(
              maxHeight: double.infinity,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 4,
                  blurRadius: 6,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
              border: Border.all(color: whiteColor),
              color: containerColor,
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  flex: 4,
                  child: Column(
                    children: [
                      Text(
                        AppCubit.get(context)
                            .notificationsModel
                            ?.data?[widget.index]
                            .message,
                        maxLines: 3,
                        textAlign: TextAlign.start,
                        style: titleStyle,
                      ),
                      Text(
                        AppCubit.get(context)
                            .notificationsModel
                            ?.data?[widget.index]
                            .title,
                        maxLines: 2,
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                // const Spacer(),
                // const Spacer(),
                // const Spacer(),
                // const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(AppCubit.get(context)
                        .notificationsModel
                        ?.data?[widget.index]
                        .date),
                    Text(AppCubit.get(context)
                        .notificationsModel
                        ?.data?[widget.index]
                        .time),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

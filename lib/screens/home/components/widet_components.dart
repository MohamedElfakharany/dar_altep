import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dar_altep/cubit/cubit.dart';
import 'package:dar_altep/cubit/states.dart';
import 'package:dar_altep/models/appointments_model.dart';
import 'package:dar_altep/models/offers_model.dart';
import 'package:dar_altep/models/tests_model.dart';
import 'package:dar_altep/screens/home/lab_visit_appointment/lab_visit_appointment_screen.dart';
import 'package:dar_altep/screens/home/lab_visit_appointment/lab_visit_submit_screen.dart';
import 'package:dar_altep/screens/home/test_screen/home_visit_screen.dart';
import 'package:dar_altep/screens/home/test_screen/precautions_screen.dart';
import 'package:dar_altep/shared/components/cached_network_image.dart';
import 'package:dar_altep/shared/components/general_components.dart';
import 'package:dar_altep/shared/constants/colors.dart';
import 'package:dar_altep/shared/constants/generalConstants.dart';
import 'package:dar_altep/shared/network/local/const_shared.dart';
import 'package:dar_altep/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeOffersCard extends StatelessWidget {
  const HomeOffersCard(
      {Key? key, this.offersModel, required this.context, required this.index})
      : super(key: key);
  final OffersModel? offersModel;
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
              height: 227.0,
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
                            style: TextStyle(
                              fontFamily: fontFamily,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          verticalMicroSpace,
                          Text(
                            offersModel?.data?[index].duration,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: fontFamily,
                              color: Colors.black54,
                            ),
                          ),
                          verticalMicroSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                offersModel?.data?[index].price,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: fontFamily,
                                  decoration: TextDecoration.lineThrough,
                                  color: darkColor,
                                ),
                              ),
                              horizontalSmallSpace,
                              horizontalSmallSpace,
                              Text(
                                offersModel?.data?[index].discount,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: fontFamily,
                                  fontWeight: FontWeight.bold,
                                  color: blueDark,
                                ),
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
                              onPressed: () {},
                              child: const Center(
                                child: Text(
                                  'Get Offers',
                                  style: TextStyle(
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
  const TestLibraryCard(
      {Key? key, this.testsModel, required this.context, required this.index})
      : super(key: key);
  final TestsModel? testsModel;
  final BuildContext context;
  final int index;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
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
        height: 110.0,
        child: Row(
          children: [
            CachedNetworkImageNormal(
              imageUrl: testsModel?.data?[index].image,
              width: 130,
              height: double.infinity,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: whiteColor,
                ),
                padding: const EdgeInsetsDirectional.all(10.0),
                // height: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${testsModel?.data?[index].name}',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: fontFamily,
                        fontWeight: FontWeight.bold,
                        color: blueDark,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    verticalMicroSpace,
                    Text(
                      'Duration : ${testsModel?.data?[index].duration} days',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: fontFamily,
                        color: Colors.grey,
                      ),
                    ),
                    verticalMicroSpace,
                    Text(
                      'Price : ${testsModel?.data?[index].price} \$',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: fontFamily,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding:
                      const EdgeInsetsDirectional.only(top: 10.0, end: 20.0),
                  child: CircleAvatar(
                    radius: 15,
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
                            height: 280,
                            width: width * 0.9,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                verticalMediumSpace,
                                Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                      start: 20.0),
                                  child: Text(
                                    'Reservation type',
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
                                  title: 'At Home',
                                  image: 'assets/images/homeIcon.png',
                                  width: double.infinity,
                                  onPress: () {
                                    Navigator.push(
                                        context,
                                        FadeRoute(
                                            page: HomeVisitScreen(testName: testsModel?.data?[index].name,)));
                                  },
                                ),
                                verticalLargeSpace,
                                GeneralUnfilledButton(
                                  btnRadius: radius - 5,
                                  borderColor: whiteColor,
                                  title: 'At laboratory',
                                  image: 'assets/images/labIcon.png',
                                  width: double.infinity,
                                  onPress: () {
                                    Navigator.push(
                                        context,
                                        FadeRoute(
                                            page:
                                                const LabVisitAppointmentScreen()));
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
                const Spacer(),
                GeneralUnfilledButton(
                  title: LocaleKeys.BtnPrecautions.tr(),
                  height: 35,
                  width: 90,
                  btnRadius: 8,
                  borderColor: blueLight,
                  onPress: () {
                    Navigator.push(
                        context,
                        FadeRoute(
                            page: PrecautionsScreen(
                                title: testsModel?.data?[index].name ??
                                    'Test Precautions',
                                description:
                                    testsModel?.data?[index].description,
                                type: testsModel?.data?[index].type)));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class OffersCard extends StatelessWidget {
  const OffersCard(
      {Key? key, this.offersModel, required this.context, required this.index})
      : super(key: key);
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
        height: 110.0,
        child: Row(
          children: [
            horizontalMicroSpace,
            CachedNetworkImageNormal(
              imageUrl: offersModel?.data?[index].image,
              width: 130,
              height: 90,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsetsDirectional.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${offersModel?.data?[index].name}',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: fontFamily,
                        fontWeight: FontWeight.bold,
                        color: blueDark,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    verticalMicroSpace,
                    Text(
                      '${offersModel?.data?[index].description}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: fontFamily,
                        color: Colors.grey,
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GeneralUnfilledButton(title: 'More', onPress: () {},width: 70,btnRadius: 8.0,),
                          GeneralButton(title: 'Get Offer', onPress: (){},height: 30.0,width: 100,radius: 8.0,)
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
  const AppointmentCard(
      {Key? key,
      this.appointmentsModel,
      required this.context,
      required this.index})
      : super(key: key);

  final AppointmentsModel? appointmentsModel;
  final BuildContext context;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            FadeRoute(
                page: LabVisitSubmitScreen(
              index: index,
              appointmentsModel: appointmentsModel!,
              appointmentId: appointmentsModel?.data?[index].id,
            )));
      },
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
        decoration: const BoxDecoration(color: whiteColor),
        child: Row(
          children: [
            Text(
              appointmentsModel?.data?[index].day,
              style: TextStyle(
                  fontFamily: fontFamily,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            const Spacer(),
            Text(
              appointmentsModel?.data?[index].date,
              style: TextStyle(
                  fontFamily: fontFamily,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            const Spacer(),
            Text(
              appointmentsModel?.data?[index].time,
              style: TextStyle(
                  fontFamily: fontFamily,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

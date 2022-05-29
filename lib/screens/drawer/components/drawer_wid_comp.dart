import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dar_altep/cubit/cubit.dart';
import 'package:dar_altep/cubit/states.dart';
import 'package:dar_altep/models/reservation_model.dart';
import 'package:dar_altep/models/search_model.dart';
import 'package:dar_altep/screens/test_result_screen.dart';
import 'package:dar_altep/shared/components/general_components.dart';
import 'package:dar_altep/shared/constants/colors.dart';
import 'package:dar_altep/shared/constants/generalConstants.dart';
import 'package:dar_altep/shared/network/local/const_shared.dart';
import 'package:dar_altep/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResevationsCard extends StatelessWidget {
  const ResevationsCard(
      {Key? key,
      this.reservationsModel,
      required this.context,
      required this.index})
      : super(key: key);
  final ReservationsModel? reservationsModel;
  final BuildContext context;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppGetTestResultSuccessState) {
          Navigator.push(
            context,
            FadeRoute(
              page: TestResultScreen(
                testName: AppCubit.get(context).testResultModel?.data?.name,
                testImage: AppCubit.get(context).testResultModel?.data?.image,
                // testImage: 'https://avatars.githubusercontent.com/u/34916493?s=400&u=e7300b829193270fbcd03a813551a3702299cbb1&v=4',
              ),
            ),
          );
        }
      },
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
            height: 160.0,
            child: Container(
              padding: const EdgeInsetsDirectional.only(
                  top: 15.0, bottom: 15.0, start: 20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: whiteColor,
              ),
              height: 160,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '${reservationsModel?.data?[index].testName}',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: fontFamily,
                          fontWeight: FontWeight.bold,
                          color: darkColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      horizontalMicroSpace,
                      if (reservationsModel?.data?[index].status == 'away')
                        Text(
                          '(Away)',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: fontFamily,
                            fontWeight: FontWeight.normal,
                            color: greenTxtColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      if (reservationsModel?.data?[index].status ==
                          'finished')
                        Text(
                          '(Finished)',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: fontFamily,
                            fontWeight: FontWeight.normal,
                            color: blueDark,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      if (reservationsModel?.data?[index].status == 'cancel')
                        Text(
                          '(Cancelled)',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: fontFamily,
                            fontWeight: FontWeight.normal,
                            color: redTxtColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                  verticalMiniSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${reservationsModel?.data?[index].date}, ',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: fontFamily,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      horizontalMicroSpace,
                      Text(
                        '${reservationsModel?.data?[index].time}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontFamily: fontFamily,
                        ),
                      ),
                    ],
                  ),
                  verticalMicroSpace,
                  Row(
                    children: [
                      if (reservationsModel?.data?[index].type == 'home')
                        Image.asset(
                          'assets/images/homeIcon.png',
                          fit: BoxFit.cover,
                          height: 30,
                          width: 30,
                        ),
                      if (reservationsModel?.data?[index].type == 'lab')
                        Image.asset(
                          'assets/images/labIcon.png',
                          fit: BoxFit.cover,
                          height: 30,
                          width: 30,
                        ),
                      horizontalMiniSpace,
                      if (reservationsModel?.data?[index].type == 'home')
                        const Expanded(
                          child: Text(
                            'At home',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 20,
                              color: darkColor,
                            ),
                          ),
                        ),
                      if (reservationsModel?.data?[index].type == 'lab')
                        const Expanded(
                          child: Text(
                            'At Laboratory',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 20,
                              color: darkColor,
                            ),
                          ),
                        ),
                      if (reservationsModel?.data?[index].status == 'cancel')
                        GeneralUnfilledButton(
                          title: LocaleKeys.BtnDelete.tr(),
                          height: 35,
                          width: 70,
                          btnRadius: 8,
                          borderColor: blueLight,
                          onPress: () {
                            showPopUp(
                              context,
                              Container(
                                height: 200,
                                width:
                                    MediaQuery.of(context).size.width * 0.9,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10.0),
                                child: Column(
                                  children: [
                                    verticalSmallSpace,
                                    Text(
                                      LocaleKeys.TxtdeleteMain.tr(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: fontFamily,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    verticalMediumSpace,
                                    GeneralUnfilledButton(
                                      title: LocaleKeys.BtnDelete.tr(),
                                      height: 35,
                                      width: double.infinity,
                                      btnRadius: 8,
                                      color: redTxtColor,
                                      borderColor: redTxtColor,
                                      onPress: () {
                                        AppCubit.get(context).deleteReservation(
                                            reservationId:
                                                '${reservationsModel?.data?[index].id}');
                                        Navigator.pop(context);
                                        AppCubit.get(context)
                                            .getReservationsData();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      if (reservationsModel?.data?[index].status ==
                          'finished')

                        ConditionalBuilder(
                          condition: state is! AppGetUserResultsLoadingState,
                          builder: (context) => GeneralButton(
                            title: LocaleKeys.BtnResult.tr(),
                            height: 35,
                            width: 70,
                            radius: 8,
                            btnBackgroundColor: blueLight,
                            onPress: () {
                              if (kDebugMode) {
                                print('result');
                              }
                              AppCubit.get(context).getTestResultData(
                                  reservationId: reservationsModel?.data?[index].id);
                            },
                          ),
                          fallback: (context) => const Center(child: CircularProgressIndicator()),
                        ),
                      if (reservationsModel?.data?[index].status == 'away' ||
                          reservationsModel?.data?[index].status == 'lab')
                        GeneralUnfilledButton(
                          title: LocaleKeys.BtnCancel.tr(),
                          height: 35,
                          width: 70,
                          btnRadius: 8,
                          borderColor: blueLight,
                          onPress: () {
                            showPopUp(
                              context,
                              Container(
                                height: 200,
                                width:
                                    MediaQuery.of(context).size.width * 0.9,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10.0),
                                child: Column(
                                  children: [
                                    verticalSmallSpace,
                                    Text(
                                      LocaleKeys.TxtCancelMain.tr(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: fontFamily,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    verticalSmallSpace,
                                    GeneralUnfilledButton(
                                      title: LocaleKeys.BtnCancel.tr(),
                                      height: 35,
                                      width: double.infinity,
                                      btnRadius: 8,
                                      color: redTxtColor,
                                      borderColor: redTxtColor,
                                      onPress: () {
                                        AppCubit.get(context).cancelReservation(
                                            reservationId:
                                                '${reservationsModel?.data?[index].id}');
                                        Navigator.pop(context);
                                        AppCubit.get(context)
                                            .getReservationsData();
                                      },
                                    ),
                                  ],
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
        );
      },
    );
  }
}

class MyResultsCard extends StatelessWidget {
  const MyResultsCard(
      {Key? key, this.checkedData, required this.context, required this.index})
      : super(key: key);
  final Checked? checkedData;
  final BuildContext context;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          height: 70,
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    checkedData?.name ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // verticalMicroSpace,
                  Text(
                    '${checkedData?.date}, ${checkedData?.time}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const CircleAvatar(
                radius: 8,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage(
                  'assets/images/checkIcon.png',
                ),
              ),
              horizontalMiniSpace,
              horizontalMiniSpace,
              horizontalMiniSpace,
            ],
          ),
        );
      },
    );
  }
}

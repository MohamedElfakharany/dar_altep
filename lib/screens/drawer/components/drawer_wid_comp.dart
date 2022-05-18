import 'package:dar_altep/cubit/cubit.dart';
import 'package:dar_altep/cubit/states.dart';
import 'package:dar_altep/models/reservation_model.dart';
import 'package:dar_altep/screens/test_result_screen.dart';
import 'package:dar_altep/shared/components/general_components.dart';
import 'package:dar_altep/shared/constants/colors.dart';
import 'package:dar_altep/shared/constants/generalConstants.dart';
import 'package:dar_altep/shared/network/local/const_shared.dart';
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
    return BlocConsumer<AppCubit,AppStates>(
      listener:  (context,state){
        if (state is AppGetTestResultSuccessState){
          Navigator.push(context, FadeRoute(page: TestResultScreen(testName: AppCubit.get(context).testResultModel?.data?.name,testImage: AppCubit.get(context).testResultModel?.data?.file,)));
        }
      },
      builder: (context,state){
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
            height: 160.0,
            child: Stack(
              children: [
                Positioned.fill(
                  top: 15,
                  left: 20,
                  right: 0,
                  bottom: 15,
                  child: Container(
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
                            horizontalMiniSpace,
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
                            if (reservationsModel?.data?[index].status == 'finished')
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
                        verticalMicroSpace,
                        verticalSmallSpace,
                        Row(
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
                            horizontalMiniSpace,
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
                        verticalSmallSpace,
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
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                if (reservationsModel?.data?[index].status == 'cancel')
                  Positioned(
                    right: 0,
                    bottom: 10,
                    child: GeneralUnfilledButton(
                      title: 'Delete',
                      height: 35,
                      width: 70,
                      btnRadius: 8,
                      borderColor: blueLight,
                      onPress: () {
                        showPopUp(
                          context,
                          Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width * 0.9,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            child: Column(
                              children: [
                                verticalSmallSpace,
                                Text(
                                  'Are you sure to delete this reservation?',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: fontFamily,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                verticalMediumSpace,
                                GeneralUnfilledButton(
                                  title: 'Delete',
                                  height: 35,
                                  width: double.infinity,
                                  btnRadius: 8,
                                  color: redTxtColor,
                                  borderColor: redTxtColor,
                                  onPress: (){},
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                if (reservationsModel?.data?[index].status == 'finished')
                  Positioned(
                    right: 0,
                    bottom: 10,
                    child: GeneralButton(
                      title: 'Result',
                      height: 35,
                      width: 70,
                      radius: 8,
                      btnBackgroundColor: blueLight,
                      onPress: () {
                        if (kDebugMode) {
                          print('result');
                        }
                        AppCubit.get(context).getTestResultData(reservationId: reservationsModel?.data?[index].id);
                      },
                    ),
                  ),
                if (reservationsModel?.data?[index].status == 'away' ||
                    reservationsModel?.data?[index].status == 'lab')
                  Positioned(
                    right: 0,
                    bottom: 10,
                    child: GeneralUnfilledButton(
                      title: 'Cancel',
                      height: 35,
                      width: 70,
                      btnRadius: 8,
                      borderColor: blueLight,
                      onPress: () {
                        showPopUp(
                          context,
                          Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width * 0.9,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            child: Column(
                              children: [
                                verticalSmallSpace,
                                Text(
                                  'Are you sure to cancel this reservation?',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: fontFamily,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                verticalMediumSpace,
                                GeneralUnfilledButton(
                                  title: 'Cancel',
                                  height: 35,
                                  width: double.infinity,
                                  btnRadius: 8,
                                  color: redTxtColor,
                                  borderColor: redTxtColor,
                                  onPress: (){},
                                ),
                              ],
                            ),
                          ),
                        );
                      },
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

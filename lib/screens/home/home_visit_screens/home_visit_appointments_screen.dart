import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dar_altep/cubit/cubit.dart';
import 'package:dar_altep/cubit/states.dart';
import 'package:dar_altep/models/appointments_model.dart';
import 'package:dar_altep/models/auth/user_model.dart';
import 'package:dar_altep/screens/home/components/widget_components.dart';
import 'package:dar_altep/shared/components/general_components.dart';
import 'package:dar_altep/shared/constants/colors.dart';
import 'package:dar_altep/shared/constants/general_constants.dart';
import 'package:dar_altep/shared/network/local/const_shared.dart';
import 'package:dar_altep/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeVisitAppointmentScreen extends StatefulWidget {
  const HomeVisitAppointmentScreen({
    Key? key,
    this.user,
    this.testName,
    this.testNames,
    required this.address,
    required this.lat,
    required this.long,
  }) : super(key: key);
  final UserModel? user;
  final String? testName;
  final List<String>? testNames;
  final String address;
  final double lat;
  final double long;

  @override
  State<HomeVisitAppointmentScreen> createState() =>
      _HomeVisitAppointmentScreenState();
}

class _HomeVisitAppointmentScreenState
    extends State<HomeVisitAppointmentScreen> {
  @override
  Widget build(BuildContext context) {
    final DateTime today = DateTime.now();
    return BlocProvider(
      create: (BuildContext context) =>
          AppCubit()..getHomeAppointmentsData(date: today.toString()),
      child: Scaffold(
        appBar: GeneralAppBar(title: LocaleKeys.AppointmentScreenTxtTitle.tr()),
        body: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) => {},
          builder: (context, state) {
            print('widget.testName from home appointments ${widget.testName}');
            return ScreenUtilInit(builder: (ctx, _) {
              return Container(
                padding: const EdgeInsetsDirectional.only(
                    start: 10.0, top: 12.0, bottom: 12.0, end: 10.0),
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
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: MediaQuery.removePadding(
                    context: context,
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        Text(
                          LocaleKeys.AppointmentScreenTxtSelect.tr(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                            fontFamily: fontFamily,
                            fontWeight: FontWeight.bold,
                            color: blueDark,
                            // decoration: TextDecoration.underline,
                          ),
                        ),
                        verticalSmallSpace,
                        const HomeCalenderView(),
                        verticalSmallSpace,
                        ConditionalBuilder(
                          condition:
                              AppCubit.get(context).homeAppointmentsModel !=
                                  null,
                          builder: (context) => Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.0),
                                  spreadRadius: 10,
                                  blurRadius: 10,
                                  offset: const Offset(
                                      0, 0), // changes position of shadow
                                ),
                              ],
                            ),
                            height: MediaQuery.of(context).size.height * 0.65,
                            child: ConditionalBuilder(
                              condition:
                                  AppCubit.get(context).homeAppointmentsModel !=
                                      null,
                              builder: (context) => ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) =>
                                    HomeAppointmentCard(
                                  user: widget.user,
                                  testName: widget.testName,
                                  testNames: widget.testNames,
                                  index: index,
                                  context: context,
                                  homeAppointments: AppCubit.get(context)
                                      .homeAppointmentsModel,
                                  address: widget.address,
                                  lat: widget.lat,
                                  long: widget.long,
                                ),
                                separatorBuilder: (context, index) => Container(
                                  // color: Colors.grey,
                                  height: 10,
                                ),
                                itemCount: AppCubit.get(context)
                                    .homeAppointmentsModel!
                                    .data!
                                    .length,
                              ),
                              fallback: (context) => const Center(
                                  child: CircularProgressIndicator()),
                            ),
                          ),
                          fallback: (context) => ScreenHolder(
                              LocaleKeys.AppointmentScreenTxtTitle.tr()),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
          },
        ),
      ),
    );
  }
}

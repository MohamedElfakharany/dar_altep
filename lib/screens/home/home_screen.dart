import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dar_altep/cubit/cubit.dart';
import 'package:dar_altep/cubit/states.dart';
import 'package:dar_altep/screens/drawer/drawer_screen.dart';
import 'package:dar_altep/screens/drawer/my_results_screen.dart';
import 'package:dar_altep/screens/home/components/widet_components.dart';
import 'package:dar_altep/screens/home/contact_us_screen.dart';
import 'package:dar_altep/screens/home/lab_visit_appointment/lab_visit_appointment_screen.dart';
import 'package:dar_altep/screens/home/messaging_screen.dart';
import 'package:dar_altep/screens/home/offers/offers_screen.dart';
import 'package:dar_altep/screens/home/test_screen/home_visit_screen.dart';
import 'package:dar_altep/screens/home/test_screen/test_library_screen.dart';
import 'package:dar_altep/shared/components/general_components.dart';
import 'package:dar_altep/shared/constants/colors.dart';
import 'package:dar_altep/shared/constants/generalConstants.dart';
import 'package:dar_altep/shared/network/local/const_shared.dart';
import 'package:dar_altep/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var searchModel = AppCubit.get(context).searchModel;
    var testItems = AppCubit.get(context).testName;
    var notificationModel = AppCubit.get(context).notificationsModel;
    return BlocProvider(
      create: (BuildContext context) => AppCubit()
        ..getOffersData()
        ..getTestsData()
        ..getProfileData()
        ..getReservationsData()
        ..getTestNameData()
        ..getAppointmentsData()
        ..getHomeOffersData()
        ..getLabOffersData(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is AppGetNotificationsSuccessState) {
            if (state.notificationsModel.status){
              notificationModel = AppCubit.get(context).notificationsModel;
              Navigator.push(
                context,
                FadeRoute(
                  page: MessagingScreen(),
                ),
              );
            }else {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title:
                      Center(child: Text(state.notificationsModel.message)),
                    );
                  });
            }
          } else if (state is AppGetNotificationsErrorState) {
            showDialog(
                context: context,
                builder: (context) {
                  return const AlertDialog(
                    title:
                        Center(child: Text('no notifications for you')),
                  );
                });
          }

          if (state is AppGetUserResultsSuccessState) {
            searchModel = AppCubit.get(context).searchModel;
            Navigator.push(
                context,
                FadeRoute(
                    page: MyResultsScreen(
                  testNames: testItems,
                  searchModel: searchModel,
                )));
          } else if (state is AppGetUserResultsErrorState) {
            showDialog(
                context: context,
                builder: (context) {
                  return const AlertDialog(
                    title:
                        const Center(child: Text('no results for this user')),
                  );
                });
          }
        },
        builder: (context, state) {
          var offers = AppCubit.get(context).offersModel;
          var labOffers = AppCubit.get(context).labOffersModel;
          var homeOffers = AppCubit.get(context).homeOffersModel;
          var labAppointments = AppCubit.get(context).appointmentsModel;
          var user = AppCubit.get(context).userModel;
          var testNames = AppCubit.get(context).testName;
          return Scaffold(
            appBar: AppBar(
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/homeAppbarImage.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                width: double.infinity,
              ),
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              actions: [
                TextButton(
                  onPressed: () async {
                    AppCubit.get(context).changeLanguage();
                    await context
                        .setLocale(Locale(AppCubit.get(context).local));
                    if (kDebugMode) {
                      print(LocaleKeys.language.tr());
                    }
                  },
                  child: Text(
                    LocaleKeys.language.tr(),
                    style: TextStyle(
                      color: whiteColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: fontFamily,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
              bottom: PreferredSize(
                preferredSize: const Size(double.infinity, 60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 20.0),
                      child: Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          '${LocaleKeys.homeTxtWelcome.tr()} ${AppCubit.get(context).userModel?.data?.name ?? 'Sir'},',
                          style: TextStyle(
                            color: whiteColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: fontFamily,
                            fontSize: 20,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    verticalSmallSpace,
                    verticalSmallSpace,
                  ],
                ),
              ),
            ),
            body: ConditionalBuilder(
              condition: state is! AppGetOffersLoadingState,
              builder: (context) => Container(
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
                      padding: const EdgeInsetsDirectional.only(start: 10),
                      child: Row(
                        children: [
                          Text(
                            LocaleKeys.homeTxtDiscover.tr(),
                            style: TextStyle(
                              color: darkColor,
                              fontWeight: FontWeight.w600,
                              fontFamily: fontFamily,
                              fontSize: 20,
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  FadeRoute(
                                      page: OffersScreen(
                                    offersModel: offers,
                                    homeOffersModel: homeOffers,
                                    labOffersModel: labOffers,
                                    user: user,
                                    testNames: testNames,
                                  )));
                            },
                            child: DefaultTextButton(
                              title: LocaleKeys.BtnSeeAll.tr(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 20.0),
                      child: SizedBox(
                        height: 247.0,
                        child: ConditionalBuilder(
                          condition: AppCubit.get(context).offersModel != null,
                          builder: (context) => ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => HomeOffersCard(
                              user: user,
                              testNames: testNames,
                              context: context,
                              offersModel: AppCubit.get(context).offersModel,
                              index: index,
                            ),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              width: 10.0,
                            ),
                            itemCount:
                                AppCubit.get(context).offersModel!.data!.length,
                            // itemCount: 10,
                          ),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        top: 20.0,
                        start: 10.0,
                        end: 20.0,
                      ),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                FadeRoute(
                                  page: TestLibraryScreen(
                                      user: user,
                                      appointments: labAppointments,
                                      testNames: testNames),
                                ),
                              );
                            },
                            child: Stack(
                              alignment: AlignmentDirectional.centerStart,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 4,
                                        blurRadius: 6,
                                        offset: const Offset(
                                            0, 5), // changes position of shadow
                                      ),
                                    ],
                                    border: Border.all(color: whiteColor),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  height: 50,
                                  child: Center(
                                    child: Text(
                                      LocaleKeys.homeTxtTestLibrary.tr(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: fontFamily,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.transparent,
                                  child: Image.asset(
                                    'assets/images/homeTestLab.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    ConditionalBuilder(
                      condition: state is! AppGetUserResultsLoadingState,
                      builder: (context) => Padding(
                        padding: const EdgeInsetsDirectional.only(
                          top: 20.0,
                          start: 10.0,
                          end: 20.0,
                        ),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                AppCubit.get(context).getUserResults();
                              },
                              child: Stack(
                                alignment: AlignmentDirectional.centerStart,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 4,
                                          blurRadius: 6,
                                          offset: const Offset(0,
                                              5), // changes position of shadow
                                        ),
                                      ],
                                      border: Border.all(color: whiteColor),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    height: 50,
                                    child: Center(
                                      child: Text(
                                        LocaleKeys.drawerResults.tr(),
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: fontFamily,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.transparent,
                                    child: Image.asset(
                                      'assets/images/homeTestResults.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      fallback: (context) =>
                          const Center(child: CircularProgressIndicator()),
                    ),
                    ConditionalBuilder(
                      condition: state is! AppGetNotificationsLoadingState,
                      builder: (context) => Padding(
                        padding: const EdgeInsetsDirectional.only(
                            top: 20.0, start: 10.0, end: 20.0),
                        child: InkWell(
                          onTap: () {
                            AppCubit.get(context).getNotifications();
                          },
                          child: Column(
                            children: [
                              Stack(
                                alignment: AlignmentDirectional.centerStart,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 4,
                                          blurRadius: 6,
                                          offset: const Offset(0,
                                              5), // changes position of shadow
                                        ),
                                      ],
                                      border: Border.all(color: whiteColor),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    height: 50,
                                    child: Center(
                                      child: Text(
                                        LocaleKeys.homeTxtNotifications.tr(),
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: fontFamily,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.transparent,
                                    child: Image.asset(
                                      'assets/images/homeNotification.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      fallback: (context) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                          top: 20.0, start: 10.0, end: 20.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              FadeRoute(
                                  page: OffersScreen(
                                offersModel: offers,
                                homeOffersModel: homeOffers,
                                labOffersModel: labOffers,
                                user: user,
                                testNames: testNames,
                              )));
                        },
                        child: Column(
                          children: [
                            Stack(
                              alignment: AlignmentDirectional.centerStart,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 4,
                                        blurRadius: 6,
                                        offset: const Offset(
                                            0, 5), // changes position of shadow
                                      ),
                                    ],
                                    border: Border.all(color: whiteColor),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  height: 50,
                                  child: Center(
                                    child: Text(
                                      LocaleKeys.homeTxtOffers.tr(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: fontFamily,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.transparent,
                                  child: Image.asset(
                                    'assets/images/homeDiscount.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                          top: 20.0, start: 10.0, end: 20.0),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                FadeRoute(
                                  page: ContactUsScreen(user: user),
                                ),
                              );
                            },
                            child: Stack(
                              alignment: AlignmentDirectional.centerStart,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 4,
                                        blurRadius: 6,
                                        offset: const Offset(
                                            0, 5), // changes position of shadow
                                      ),
                                    ],
                                    border: Border.all(color: whiteColor),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  height: 50,
                                  child: Center(
                                    child: Text(
                                      LocaleKeys.homeTxtContactUs.tr(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: fontFamily,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.transparent,
                                  child: Image.asset(
                                    'assets/images/homeContactUs.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              fallback: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              elevation: 25,
              backgroundColor: blueDark,
              child: const Icon(
                Icons.add_rounded,
                color: whiteColor,
                size: 35,
              ),
              onPressed: () {
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
                            LocaleKeys.TxtPopUpReservationType.tr(),
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
                          title: LocaleKeys.BtnAtHome.tr(),
                          image: 'assets/images/homeIcon.png',
                          width: double.infinity,
                          onPress: () {
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                FadeRoute(
                                    page: HomeVisitScreen(
                                  testNames: testNames,
                                  user: user,
                                )));
                          },
                        ),
                        verticalLargeSpace,
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
            drawer: Drawer(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/drawerBackgoundImage.png'),
                  ),
                  color: Colors.transparent,
                ),
                child: DrawerScreen(testNames: testNames),
              ),
            ),
          );
        },
      ),
    );
  }
}

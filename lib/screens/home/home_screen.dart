import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dar_altep/cubit/cubit.dart';
import 'package:dar_altep/cubit/states.dart';
import 'package:dar_altep/screens/drawer/drawer_screen.dart';
import 'package:dar_altep/screens/home/components/widet_components.dart';
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
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: const Icon(
              Icons.menu,
            ),
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
                  await context.setLocale(Locale(AppCubit.get(context).local));
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
              preferredSize: const Size(double.infinity, 110),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(start: 20.0),
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        '${LocaleKeys.homeTxtWelcome.tr()} ${AppCubit.get(context).userdata?.data?.name},',
                        style: TextStyle(
                          color: whiteColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: fontFamily,
                          fontSize: 26,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  verticalSmallSpace,
                  Padding(
                    padding: const EdgeInsetsDirectional.only(start: 20.0),
                    child: Text(
                      LocaleKeys.homeTxtAppBarSecondary.tr(),
                      style: TextStyle(
                        color: whiteColor,
                        fontWeight: FontWeight.normal,
                        fontFamily: fontFamily,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  verticalSmallSpace,
                ],
              ),
            ),
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
                image: const AssetImage("assets/images/onboardingbackground.png"),
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.15), BlendMode.dstATop),
                fit: BoxFit.cover,
              ),
            ),
            child: ListView(
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
                      DefaultTextButton(
                        title: LocaleKeys.BtnSeeAll.tr(),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 20.0),
                  child: SizedBox(
                    height: 247.0,
                    child: ConditionalBuilder(
                      condition: state is! AppGetOffersLoadingState,
                      builder: (context) => ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => HomeOffersCard(context: context, offersModel: AppCubit.get(context).offersModel, index: index,),
                        separatorBuilder: (context, index) => const SizedBox(
                          width: 10.0,
                        ),
                        itemCount: AppCubit.get(context).offersModel!.data!.length,
                        // itemCount: 10,
                      ),
                      fallback: (context) => const Center(child: CircularProgressIndicator()),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                      top: 20.0, start: 10.0, end: 20.0,),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.push(context, FadeRoute(page: TestLibraryScreen(),),);
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
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                      top: 20.0, start: 10.0, end: 20.0),
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
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                      top: 20.0, start: 10.0, end: 20.0),
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
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                      top: 20.0, start: 10.0, end: 20.0),
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
                    ],
                  ),
                ),
              ],
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
                        padding: const EdgeInsetsDirectional.only(start: 20.0),
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
                          Navigator.push(context, FadeRoute(page: const HomeVisitScreen()));
                        },
                      ),
                      verticalLargeSpace,
                      GeneralUnfilledButton(
                        btnRadius: radius - 5,
                        borderColor: whiteColor,
                        title: 'At laboratory',
                        image: 'assets/images/labIcon.png',
                        width: double.infinity,
                        onPress: () {},
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          drawer: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/drawerBackgoundImage.png'),
              ),
              color: Colors.transparent,
            ),
            child: const DrawerScreen(),
          ),
        ) ;
      },
    );
  }
}

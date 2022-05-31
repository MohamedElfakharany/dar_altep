import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dar_altep/cubit/cubit.dart';
import 'package:dar_altep/cubit/states.dart';
import 'package:dar_altep/screens/drawer/reservation_screen.dart';
import 'package:dar_altep/screens/drawer/settings_screen.dart';
import 'package:dar_altep/screens/drawer/my_results_screen.dart';
import 'package:dar_altep/shared/components/general_components.dart';
import 'package:dar_altep/shared/constants/colors.dart';
import 'package:dar_altep/shared/constants/generalConstants.dart';
import 'package:dar_altep/shared/network/local/const_shared.dart';
import 'package:dar_altep/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerScreen extends StatelessWidget {
  DrawerScreen({Key? key, required this.testNames}) : super(key: key);
  List<String> testNames = [];

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var searchModel = AppCubit.get(context).searchModel;
    var testItems = testNames;
    return BlocProvider(
      create: (BuildContext context) => AppCubit()
        ..getProfileData()
        ..getTestsData(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is AppGetUserResultsSuccessState) {
            Navigator.push(
                context,
                FadeRoute(
                    page: MyResultsScreen(
                  testNames: testItems,
                  searchModel: searchModel,
                )));
          }else if (state is AppGetUserResultsErrorState){
            showDialog(context: context, builder: (context){
              return AlertDialog(title: Center(child: Text('no results for this user')),);
            });
          }
        },
        builder: (context, state) {
          var user = AppCubit.get(context).userModel;
          return Container(
            padding: const EdgeInsetsDirectional.only(
                start: 0.0, top: 0.0, bottom: 0.0),
            color: blueDark2,
            width: width * 0.75,
            child: ConditionalBuilder(
              condition: state is! AppGetProfileLoadingState &&
                  state is! AppGetTestsLoadingState,
              builder: (context) => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  verticalLargeSpace,
                  verticalLargeSpace,
                  verticalLargeSpace,
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: CachedNetworkImage(
                            imageUrl: user?.data?.idImage ?? '',
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const SizedBox(
                              child: Center(
                                  child: CircularProgressIndicator(
                                color: blueLight,
                              )),
                              width: 30,
                              height: 30,
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            width: 100,
                            height: 100,
                          ),
                        ),
                        horizontalSmallSpace,
                        Padding(
                          padding: const EdgeInsetsDirectional.only(end: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                user?.data?.name ?? '',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: fontFamily,
                                  fontWeight: FontWeight.bold,
                                  color: whiteColor,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              verticalMiniSpace,
                              Text(
                                user?.data?.email ?? '',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: fontFamily,
                                  fontWeight: FontWeight.normal,
                                  color: whiteColor,
                                ),
                                overflow: TextOverflow.ellipsis,
                                // maxLines: 2,
                                // textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  verticalLargeSpace,
                  Padding(
                    padding: const EdgeInsetsDirectional.only(start: 50.0),
                    child: Column(
                      children: [
                        ConditionalBuilder(
                          condition: state is! AppGetUserResultsLoadingState,
                          builder: (context) => InkWell(
                            onTap: () {
                              AppCubit.get(context).getUserResults();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Image(
                                  image: AssetImage(
                                      'assets/images/drawerIconResult.png'),
                                  width: 30,
                                  height: 40,
                                ),
                                horizontalMiniSpace,
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                                  child: Text(
                                    LocaleKeys.drawerResults.tr(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: fontFamily,
                                      fontWeight: FontWeight.bold,
                                      color: whiteColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          fallback: (context) => const Center(child: CircularProgressIndicator()),
                        ),
                        verticalMediumSpace,
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context, FadeRoute(page: ReservationScreen()));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Image(
                                image: AssetImage(
                                    'assets/images/drawerIconBooking.png'),
                                width: 30,
                                height: 40,
                              ),
                              horizontalMiniSpace,
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: Text(
                                  LocaleKeys.drawerReservations.tr(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: fontFamily,
                                    fontWeight: FontWeight.bold,
                                    color: whiteColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        verticalMediumSpace,
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                FadeRoute(
                                    page: const SettingsScreen(
                                        // user: user,
                                        )));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Image(
                                image: AssetImage(
                                    'assets/images/drawerIconSettings.png'),
                                width: 30,
                                height: 40,
                              ),
                              horizontalMiniSpace,
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: Text(
                                  LocaleKeys.drawerSettings.tr(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: fontFamily,
                                    fontWeight: FontWeight.bold,
                                    color: whiteColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        verticalMediumSpace,
                        InkWell(
                          onTap: () {
                            showPopUp(
                              context,
                              Container(
                                height: 200,
                                width: width * 0.9,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10.0),
                                child: Column(
                                  children: [
                                    verticalSmallSpace,
                                    Text(
                                      AppCubit.get(context)
                                              .userModel
                                              ?.data
                                              ?.name ??
                                          '',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: fontFamily,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    verticalMediumSpace,
                                    Text(LocaleKeys.drawerLogOutMain.tr()),
                                    verticalMediumSpace,
                                    GeneralButton(
                                      radius: radius,
                                      title: LocaleKeys.drawerLogout.tr(),
                                      onPress: () {
                                        AppCubit.get(context).signOut(context);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Image(
                                image: AssetImage(
                                    'assets/images/drawerIconLogout.png'),
                                width: 30,
                                height: 40,
                              ),
                              horizontalMiniSpace,
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: Text(
                                  LocaleKeys.drawerLogout.tr(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: fontFamily,
                                    fontWeight: FontWeight.bold,
                                    color: whiteColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        verticalMediumSpace,
                      ],
                    ),
                  ),
                ],
              ),
              fallback: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        },
      ),
    );
  }
}

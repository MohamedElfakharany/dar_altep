import 'package:cached_network_image/cached_network_image.dart';
import 'package:dar_altep/cubit/cubit.dart';
import 'package:dar_altep/screens/drawer/settings_screen.dart';
import 'package:dar_altep/shared/components/general_components.dart';
import 'package:dar_altep/shared/constants/colors.dart';
import 'package:dar_altep/shared/constants/generalConstants.dart';
import 'package:dar_altep/shared/network/local/const_shared.dart';
import 'package:dar_altep/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.75,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          verticalLargeSpace,
          verticalLargeSpace,
          verticalLargeSpace,
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://avatars.githubusercontent.com/u/34916493?s=400&u=e7300b829193270fbcd03a813551a3702299cbb1&v=4',
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
                Expanded(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(end: 8.0),
                    child: Column(
                      children: [
                        Text(
                          'Mohamed Elfakharany',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: fontFamily,
                            fontWeight: FontWeight.bold,
                            color: whiteColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        verticalMiniSpace,
                        Text(
                          'mohamed_elfakharany00',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: fontFamily,
                            fontWeight: FontWeight.normal,
                            color: whiteColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
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
                InkWell(
                  onTap: () {
                    showPopUp(
                      context,
                      Container(
                        height: height * 0.4,
                        width: width * 0.8,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        child: Column(
                          children: const [
                            Text('My Results'),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Image(
                        image: AssetImage('assets/images/drawerIconResult.png'),
                        width: 30,
                        height: 40,
                      ),
                      horizontalMiniSpace,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
                verticalMediumSpace,
                InkWell(
                  onTap: () {
                    showPopUp(
                      context,
                      Container(
                        height: height * 0.4,
                        width: width * 0.8,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        child: Column(
                          children: const [
                            Text('Reservation type'),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Image(
                        image:
                            AssetImage('assets/images/drawerIconBooking.png'),
                        width: 30,
                        height: 40,
                      ),
                      horizontalMiniSpace,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
                    Navigator.push(context, FadeRoute(page: const SettingsScreen()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Image(
                        image:
                            AssetImage('assets/images/drawerIconSettings.png'),
                        width: 30,
                        height: 40,
                      ),
                      horizontalMiniSpace,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
                              'Mohamed Elfakharany',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: fontFamily,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            verticalMediumSpace,
                            const Text('Do you want to logout?'),
                            verticalMediumSpace,
                            GeneralButton(
                              radius: radius,
                              title: 'Logout',
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
                        image: AssetImage('assets/images/drawerIconLogout.png'),
                        width: 30,
                        height: 40,
                      ),
                      horizontalMiniSpace,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
    );
  }
}

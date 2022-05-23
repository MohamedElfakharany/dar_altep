import 'package:dar_altep/cubit/cubit.dart';
import 'package:dar_altep/cubit/states.dart';
import 'package:dar_altep/screens/home/components/widet_components.dart';
import 'package:dar_altep/shared/components/cached_network_image.dart';
import 'package:dar_altep/shared/components/general_components.dart';
import 'package:dar_altep/shared/constants/colors.dart';
import 'package:dar_altep/shared/constants/generalConstants.dart';
import 'package:dar_altep/shared/network/local/const_shared.dart';
import 'package:dar_altep/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OffersScreen extends StatefulWidget {
  const OffersScreen({Key? key}) : super(key: key);

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: GeneralAppBar(title: LocaleKeys.homeTxtTestLibrary.tr()),
            body: Column(
              children: <Widget>[
                // the tab bar with two items
                SizedBox(
                  height: 60,
                  child: AppBar(
                    backgroundColor: whiteColor,
                    // elevation: 0.0,
                    // shape: RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.circular(20),
                    // ),
                    bottom: TabBar(
                      tabs: [
                        Tab(
                          child: Container(
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: blueLight, width: 2),
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
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/images/medicalLab.png',
                                  fit: BoxFit.cover,
                                  height: 30,
                                  width: 30,
                                ),
                                horizontalSmallSpace,
                                const Expanded(
                                  child: Text(
                                    'Medical laboratory',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: darkColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: blueLight, width: 2),
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
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/images/individual.png',
                                  fit: BoxFit.cover,
                                  height: 30,
                                  width: 30,
                                ),
                                horizontalSmallSpace,
                                const Expanded(
                                  child: Text(
                                    'individual',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: darkColor,
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
                // create widgets for each tab bar here
                Expanded(
                  child: TabBarView(
                    children: [
                      // first tab bar view widget
                      Container(
                        child: Column(
                          children: [
                            verticalSmallSpace,
                            Text(
                              '20 % OFF till 20 / 6 / 2021',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: redTxtColor,
                                fontFamily: fontFamily,
                              ),
                            ),
                            // verticalSmallSpace,
                            Expanded(
                              child: ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) =>
                                    OffersCard(
                                        context: context,
                                        index: index,
                                        offersModel:
                                            AppCubit.get(context).homeOffersModel),
                                separatorBuilder: (context, index) =>
                                    verticalMiniSpace,
                                itemCount: AppCubit.get(context)
                                    .homeOffersModel!
                                    .data!
                                    .length,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // second tab bar viiew widget
                      Container(
                        child: Column(
                          children: [
                            verticalSmallSpace,
                            Text(
                              '20 % OFF till 20 / 6 / 2021',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: redTxtColor,
                                fontFamily: fontFamily,
                              ),
                            ),
                            Expanded(
                              child: ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) => OffersCard(
                                    context: context,
                                    index: index,
                                    offersModel:
                                    AppCubit.get(context).labOffersModel),
                                separatorBuilder: (context, index) =>
                                    verticalMiniSpace,
                                itemCount:
                                    AppCubit.get(context).labOffersModel!.data!.length,
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
        );
      },
    );
  }
}

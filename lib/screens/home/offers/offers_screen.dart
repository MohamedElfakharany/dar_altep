// ignore_for_file: must_be_immutable

import 'package:dar_altep/cubit/cubit.dart';
import 'package:dar_altep/cubit/states.dart';
import 'package:dar_altep/models/auth/user_model.dart';
import 'package:dar_altep/models/offers_model.dart';
import 'package:dar_altep/screens/home/components/widget_components.dart';
import 'package:dar_altep/shared/components/general_components.dart';
import 'package:dar_altep/shared/constants/colors.dart';
import 'package:dar_altep/shared/constants/general_constants.dart';
import 'package:dar_altep/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OffersScreen extends StatefulWidget {
  OffersScreen(
      {Key? key,
      required this.offersModel,
      required this.homeOffersModel,
      required this.labOffersModel,
      this.user,
      this.testNames})
      : super(key: key);
  UserModel? user;
  List<String>? testNames;
  OffersModel? offersModel;
  OffersModel? homeOffersModel;
  OffersModel? labOffersModel;

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: GeneralAppBar(title: LocaleKeys.OffersScreenTxtTitle.tr()),
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
                            child: Column(
                              children: [
                                Expanded(
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
                                        horizontalMiniSpace,
                                        Image.asset(
                                          'assets/images/offersLabIcon.png',
                                          fit: BoxFit.cover,
                                          height: 30,
                                          width: 30,
                                        ),
                                        horizontalSmallSpace,
                                        Expanded(
                                          child: Text(
                                            LocaleKeys.BtnAtLab.tr(),
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: darkColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                verticalMicroSpace,
                              ],
                            ),
                          ),
                          Tab(
                            child: Column(
                              children: [
                                Expanded(
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
                                        horizontalMiniSpace,
                                        Image.asset(
                                          'assets/images/offersHomeIcon.png',
                                          fit: BoxFit.cover,
                                          height: 30,
                                          width: 30,
                                        ),
                                        horizontalSmallSpace,
                                        Expanded(
                                          child: Text(
                                            LocaleKeys.BtnAtHome.tr(),
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: darkColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                verticalMicroSpace,
                              ],
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
                        Column(
                          children: [
                            verticalSmallSpace,
                            Expanded(
                              child: ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) => OffersCard(
                                    user: widget.user,
                                    testNames: widget.testNames,
                                    context: context,
                                    index: index,
                                    offersModel: widget.labOffersModel),
                                separatorBuilder: (context, index) =>
                                verticalMiniSpace,
                                itemCount:
                                widget.labOffersModel!.data!.length,
                              ),
                            ),
                          ],
                        ),
                        // second tab bar view widget
                        Column(
                          children: [
                            verticalSmallSpace,
                            Expanded(
                              child: ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) => OffersCard(
                                    user: widget.user,
                                    testNames: widget.testNames,
                                    context: context,
                                    index: index,
                                    offersModel: widget.homeOffersModel),
                                separatorBuilder: (context, index) =>
                                verticalMiniSpace,
                                itemCount:
                                widget.homeOffersModel!.data!.length,
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
          );
        },
      ),
    );
  }
}

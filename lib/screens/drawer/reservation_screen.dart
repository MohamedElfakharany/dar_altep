// ignore_for_file: must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dar_altep/cubit/cubit.dart';
import 'package:dar_altep/cubit/states.dart';
import 'package:dar_altep/screens/drawer/components/drawer_wid_comp.dart';
import 'package:dar_altep/shared/components/general_components.dart';
import 'package:dar_altep/shared/constants/colors.dart';
import 'package:dar_altep/shared/constants/general_constants.dart';
import 'package:dar_altep/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReservationScreen extends StatelessWidget {
  ReservationScreen({Key? key}) : super(key: key);

  var searchController = TextEditingController();
  GlobalKey formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..getReservationsData(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar:
                GeneralAppBar(title: LocaleKeys.TxtReservationScreenTitle.tr()),
            body: Container(
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
              child: Column(
                children: [
                  horizontalLargeSpace,
                  Image.asset(
                    'assets/images/logo.png',
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                  ),
                  Expanded(
                    child: ConditionalBuilder(
                      condition: AppCubit.get(context)
                              .reservationModel
                              ?.data
                              ?.length !=
                          null,
                      builder: (context) => ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) => ResevationsCard(
                            context: context,
                            index: index,
                            reservationsModel:
                                AppCubit.get(context).reservationModel),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 1),
                        itemCount: AppCubit.get(context)
                            .reservationModel!
                            .data!
                            .length,
                      ),
                      fallback: (context) => const ScreenHolder('Reservations'),
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

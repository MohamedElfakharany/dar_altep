import 'dart:async';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dar_altep/cubit/cubit.dart';
import 'package:dar_altep/cubit/states.dart';
import 'package:dar_altep/screens/home/components/widget_components.dart';
import 'package:dar_altep/shared/constants/colors.dart';
import 'package:dar_altep/shared/constants/generalConstants.dart';
import 'package:dar_altep/shared/network/local/const_shared.dart';
import 'package:dar_altep/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:dar_altep/shared/components/general_components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessagingScreen extends StatefulWidget {
  const MessagingScreen({Key? key}) : super(key: key);

  @override
  State<MessagingScreen> createState() => _MessagingScreenState();
}

class _MessagingScreenState extends State<MessagingScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () {
        AppCubit.get(context).getNotifications();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..getNotifications(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is AppDeleteNotificationsSuccessState) {
            if (state.deleteNotificationsModel.status) {
              showToast(
                  msg: state.deleteNotificationsModel.message,
                  state: ToastState.success);
            }
          }
        },
        builder: (context, state) {
          // var notificationsModel = AppCubit.get(context).notificationsModel;
          return Scaffold(
            appBar: GeneralAppBar(title: 'Notifications', centerTitle: true),
            body: ConditionalBuilder(
              condition: AppCubit.get(context).notificationsModel?.data?.length != null,
              builder: (context) => Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 10),
                      child: Row(
                        children: [
                          const Spacer(),
                          InkWell(
                            onTap: () {
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
                                        'Are you sure to delete Notifications?',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: fontFamily,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      verticalMediumSpace,
                                      ConditionalBuilder(
                                        condition: state
                                            is! AppDeleteNotificationsLoadingState,
                                        builder: (context) =>
                                            GeneralUnfilledButton(
                                          title: LocaleKeys.BtnDelete.tr(),
                                          height: 35,
                                          width: double.infinity,
                                          btnRadius: 8,
                                          color: redTxtColor,
                                          borderColor: redTxtColor,
                                          onPress: () {
                                            AppCubit.get(context)
                                                .deleteNotifications()
                                                .then((value) {
                                              Navigator.pop(context);
                                            }).catchError((error) {});
                                          },
                                        ),
                                        fallback: (context) => const Center(
                                            child: CircularProgressIndicator()),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            child: DefaultTextButton(
                              title: LocaleKeys.BtnDelete.tr(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.9,
                      padding: const EdgeInsets.only(top: 20.0),
                      child: ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => NotificationCard(
                          notificationsModel: AppCubit.get(context).notificationsModel,
                          index: index,
                        ),
                        separatorBuilder: (context, index) => verticalMiniSpace,
                        itemCount: AppCubit.get(context)
                            .notificationsModel!
                            .data!
                            .length,
                      ),
                    ),
                  ],
                ),
              ),
              fallback: (context) => const ScreenHolder('Notifications'),
            ),
          );
        },
      ),
    );
  }
}

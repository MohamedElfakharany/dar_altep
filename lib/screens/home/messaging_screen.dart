import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dar_altep/cubit/cubit.dart';
import 'package:dar_altep/cubit/states.dart';
import 'package:dar_altep/models/notification_model.dart';
import 'package:dar_altep/screens/home/components/widget_components.dart';
import 'package:dar_altep/shared/constants/colors.dart';
import 'package:dar_altep/shared/constants/general_constants.dart';
import 'package:dar_altep/shared/network/local/const_shared.dart';
import 'package:dar_altep/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dar_altep/shared/components/general_components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessagingScreen extends StatefulWidget {
  MessagingScreen({Key? key, required this.notificationsModel})
      : super(key: key);

  final NotificationsModel notificationsModel;

  @override
  State<MessagingScreen> createState() => _MessagingScreenState();
}

class _MessagingScreenState extends State<MessagingScreen> {
  // @override
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..getNotifications(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is AppDeleteNotificationsSuccessState) {
            if (state.deleteNotificationsModel.status == true) {
              if (kDebugMode) {
                print('inside true');
              }
              showToast(
                  msg: state.deleteNotificationsModel.message,
                  state: ToastState.success);
              AppCubit.get(context).getNotifications();
              Navigator.pop(context);
            } else {
              if (kDebugMode) {
                print('inside false');
              }
              Navigator.pop(context);
              showToast(
                  msg: state.deleteNotificationsModel.message,
                  state: ToastState.error);
            }
          } else if (state is AppDeleteNotificationsErrorState) {
            if (kDebugMode) {
              print('inside error');
            }
            Navigator.pop(context);
          }
          if (state is AppSeenNotificationsSuccessState) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            // appBar: GeneralAppBar(
            //     title: LocaleKeys.homeTxtNotifications.tr(), centerTitle: true),
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
              title: Text(
                LocaleKeys.homeTxtNotifications.tr(),
                style: const TextStyle(
                  color: whiteColor,
                  fontWeight: FontWeight.bold,
                  fontFamily: fontFamily,
                  fontSize: 20,
                ),
              ),
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              leading: ConditionalBuilder(
                condition: state is! AppSeenNotificationsLoadingState,
                builder: (context) => IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: whiteColor,
                  ),
                  onPressed: () {
                    AppCubit.get(context).notificationSeen();
                  },
                ),
                fallback: (context) =>
                    const Center(child: CircularProgressIndicator()),
              ),
            ),
            body: ConditionalBuilder(
              condition: state is! AppGetNotificationsLoadingState,
              builder: (context) => Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ConditionalBuilder(
                  condition: AppCubit.get(context).notificationsModel?.data?.length != null,
                  builder: (context) => ListView(
                    physics: const NeverScrollableScrollPhysics(),
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
                                          LocaleKeys.txtDeleteNotifications.tr(),
                                          style: const TextStyle(
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
                            horizontalSmallSpace,
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.8,
                        padding: const EdgeInsets.only(top: 20.0),
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) => NotificationCard(
                            notificationsModel:
                            AppCubit.get(context).notificationsModel,
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
                  fallback: (context) => ScreenHolder(LocaleKeys.homeTxtNotifications.tr()),
                ),
              ),
              fallback: (context) => const Center(child: CircularProgressIndicator()),
            ),
          );
        },
      ),
    );
  }
}

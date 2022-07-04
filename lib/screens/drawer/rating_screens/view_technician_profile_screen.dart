// ignore_for_file: must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dar_altep/cubit/cubit.dart';
import 'package:dar_altep/cubit/states.dart';
import 'package:dar_altep/shared/components/cached_network_image.dart';
import 'package:dar_altep/shared/components/general_components.dart';
import 'package:dar_altep/shared/constants/colors.dart';
import 'package:dar_altep/shared/constants/general_constants.dart';
import 'package:dar_altep/shared/network/local/const_shared.dart';
import 'package:dar_altep/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class ViewTechnicianProfileScreen extends StatefulWidget {
  ViewTechnicianProfileScreen({required this.technicalId, Key? key})
      : super(key: key);

  String technicalId;

  @override
  State<ViewTechnicianProfileScreen> createState() =>
      _ViewTechnicianProfileScreenState();
}

class _ViewTechnicianProfileScreenState
    extends State<ViewTechnicianProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          AppCubit()..getTechnicalProfileData(technicalId: widget.technicalId),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: whiteColor,
            body: ConditionalBuilder(
              condition: state is! AppGetTechnicalProfileLoadingState,
              builder: (context) => Column(
                children: [
                  verticalMicroSpace,
                  Center(
                    child: Container(
                      height: 5,
                      width: MediaQuery.of(context).size.width * 0.3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  // verticalMicroSpace,
                  Expanded(
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        // verticalMicroSpace,
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 10),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 100.0,
                                width: 100.0,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50.0),
                                  child: Image.asset(
                                    'assets/images/showTechnecal.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              verticalMicroSpace,
                              Text(
                                LocaleKeys.txtHomeReserveAccepted.tr(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontFamily: fontFamily,
                                  fontWeight: FontWeight.bold,
                                  color: blueDark2,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              verticalSmallSpace,
                              Container(
                                height: 180,
                                width: MediaQuery.of(context).size.width * 0.9,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    verticalMiniSpace,
                                    SizedBox(
                                      height: 70.0,
                                      width: 70.0,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(70.0),
                                        child:
                                            // Image.asset(
                                            //     'assets/images/profileImagePlaceHolder.png'),
                                            CachedNetworkImageCircular(
                                          imageUrl: AppCubit.get(context)
                                                  .technicalModel
                                                  ?.data
                                                  ?.image ??
                                              '',
                                          height: 140,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          AppCubit.get(context)
                                                  .technicalModel
                                                  ?.data
                                                  ?.name ??
                                              '',
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontFamily: fontFamily,
                                            fontWeight: FontWeight.bold,
                                            color: blueDark2,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        verticalMiniSpace,
                                        Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/images/jobCall.png',
                                                width: 20,
                                                height: 20,
                                              ),
                                              horizontalMiniSpace,
                                              Text(
                                                AppCubit.get(context)
                                                        .technicalModel
                                                        ?.data
                                                        ?.phone ??
                                                    '',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        verticalMiniSpace,
                                        Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/images/jobName.png',
                                                width: 25,
                                                height: 25,
                                              ),
                                              horizontalMiniSpace,
                                              Text(
                                                AppCubit.get(context)
                                                        .technicalModel
                                                        ?.data
                                                        ?.profession ??
                                                    '',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    // verticalMiniSpace,
                                  ],
                                ),
                              ),
                              verticalMiniSpace,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // GeneralButton(
                                  //   title: LocaleKeys.BtnContactT.tr(),
                                  //   width:
                                  //       MediaQuery.of(context).size.width * 0.4,
                                  //   onPress: () async {
                                  //     await FlutterPhoneDirectCaller.callNumber(
                                  //         AppCubit.get(context)
                                  //                 .technicalModel
                                  //                 ?.data
                                  //                 ?.phone ??
                                  //             '');
                                  //   },
                                  // ),
                                  MaterialButton(
                                    onPressed: () async {
                                      await FlutterPhoneDirectCaller.callNumber(
                                          AppCubit.get(context)
                                                  .technicalModel
                                                  ?.data
                                                  ?.phone ??
                                              '');
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(radius),
                                        gradient: const LinearGradient(
                                          colors: [blueDark, blueLight],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: blueDark.withOpacity(0.25),
                                            spreadRadius: 5,
                                            blurRadius: 15,
                                            offset: const Offset(0,
                                                15), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.call,
                                              color: whiteColor,
                                              size: 20,
                                            ),
                                            horizontalMiniSpace,
                                            Text(
                                              LocaleKeys.BtnContactT.tr(),
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  GeneralUnfilledButton(
                                      title: LocaleKeys.BtnOk.tr(),
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      onPress: () {
                                        Navigator.pop(context);
                                      }),
                                ],
                              ),
                              verticalMediumSpace,
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
            ),
          );
        },
      ),
    );
  }
}

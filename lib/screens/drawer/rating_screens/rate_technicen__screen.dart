// ignore_for_file: must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dar_altep/cubit/cubit.dart';
import 'package:dar_altep/cubit/states.dart';
import 'package:dar_altep/screens/drawer/rating_screens/thanks_screen.dart';
import 'package:dar_altep/shared/components/general_components.dart';
import 'package:dar_altep/shared/constants/colors.dart';
import 'package:dar_altep/shared/constants/general_constants.dart';
import 'package:dar_altep/shared/network/local/const_shared.dart';
import 'package:dar_altep/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RateTechnicanScreen extends StatefulWidget {
  RateTechnicanScreen({
    Key? key,
    required this.technicalId,
    required this.reservationId,
  }) : super(key: key);

  String technicalId;
  String reservationId;

  @override
  State<RateTechnicanScreen> createState() => _RateTechnicanScreenState();
}

class _RateTechnicanScreenState extends State<RateTechnicanScreen> {
  @override
  Widget build(BuildContext context) {
    final messageController = TextEditingController();
    double rate = 3;
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is AppRateTechnicalProfileSuccessState) {
            if (state.rateTechnicalModel.status){
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              showCustomBottomSheet(context,
                  bottomSheetContent: const ThanksScreen(),
                  bottomSheetHeight: 0.6);
            }else {
              Navigator.pop(context);
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Center(
                            child: Text(
                              state.rateTechnicalModel.message,
                            ),
                          ),
                        );
                      });
            }
          } else {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(LocaleKeys.txtError.tr()),
                  );
                });
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: whiteColor,
            body: Center(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    verticalMicroSpace,
                    Container(
                      height: 5,
                      width: MediaQuery.of(context).size.width * 0.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey,
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        children: [
                          verticalMediumSpace,
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 0.0, horizontal: 10),
                            child: Column(
                              children: [
                                verticalMediumSpace,
                                Text(
                                  LocaleKeys.txtRate.tr(),
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontFamily: fontFamily,
                                    fontWeight: FontWeight.bold,
                                    color: blueDark2,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                verticalMediumSpace,
                                RatingBar.builder(
                                  initialRating: rate,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemPadding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {
                                    rate = rating;
                                    if (kDebugMode) {
                                      print(rating);
                                    }
                                  },
                                ),
                                verticalMediumSpace,
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxHeight: MediaQuery.of(context)
                                            .size
                                            .height *
                                        0.15, //when it reach the max it will use scroll
                                    // maxWidth: width,
                                  ),
                                  child: DefaultFormField(
                                    controller: messageController,
                                    expend: true,
                                    type: TextInputType.multiline,
                                    validatedText:
                                        LocaleKeys.TxtFieldMessage.tr(),
                                    label: LocaleKeys.TxtFieldMessage.tr(),
                                    hintText: LocaleKeys.TxtFieldMessage.tr(),
                                    height: 100.0,
                                    contentPadding:
                                        const EdgeInsetsDirectional.only(
                                            top: 10.0,
                                            start: 20.0,
                                            bottom: 10.0),
                                  ),
                                ),
                                verticalMediumSpace,
                                ConditionalBuilder(
                                  condition: state
                                      is! AppRateTechnicalProfileLoadingState,
                                  builder: (context) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Container(
                                      width: double.infinity,
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
                                      child: MaterialButton(
                                        onPressed: () {
                                          AppCubit.get(context)
                                              .rateTechnicalProfileData(
                                            technicalId: widget.technicalId,
                                            rate: rate,
                                            message: messageController.text,
                                            reservationId: widget.reservationId,
                                          );
                                        },
                                        child: Center(
                                          child: Text(
                                            LocaleKeys.BtnSend.tr(),
                                            style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                            ),
                                            maxLines: 1,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  fallback: (context) => const Center(
                                      child: CircularProgressIndicator()),
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
              ),
            ),
          );
        },
      ),
    );
  }
}

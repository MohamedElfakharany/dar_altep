import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dar_altep/cubit/cubit.dart';
import 'package:dar_altep/cubit/states.dart';
import 'package:dar_altep/screens/home/home_screen.dart';
import 'package:dar_altep/shared/components/general_components.dart';
import 'package:dar_altep/shared/constants/colors.dart';
import 'package:dar_altep/shared/constants/general_constants.dart';
import 'package:dar_altep/shared/network/local/const_shared.dart';
import 'package:dar_altep/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThanksScreen extends StatefulWidget {
  const ThanksScreen({Key? key}) : super(key: key);
  @override
  State<ThanksScreen> createState() =>
      _ThanksScreenState();
}

class _ThanksScreenState
    extends State<ThanksScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: whiteColor,
            body: Center(
              child: Column(
                children: [
                  verticalMicroSpace,
                  Container(
                    height: 5,
                    width: MediaQuery.of(context).size.width * 0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        verticalMediumSpace,
                        Padding(
                          padding:
                          const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 200.0,
                                width: 200.0,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100.0),
                                  child: Image.asset(
                                    'assets/images/like.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              verticalMediumSpace,
                              Text(
                                LocaleKeys.txtTrustThanks.tr(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontFamily: fontFamily,
                                  fontWeight: FontWeight.bold,
                                  color: blueDark2,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              verticalMediumSpace,
                              GeneralUnfilledButton(
                                  title: LocaleKeys.BtnBackMain.tr(),
                                  width: MediaQuery.of(context).size.width * 0.8,
                                  onPress: () {
                                    Navigator.push(context, FadeRoute(page: const HomeScreen()));
                                  }),
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
          );
        },
      ),
    );
  }
}

// ignore_for_file: must_be_immutable

import 'package:dar_altep/cubit/cubit.dart';
import 'package:dar_altep/cubit/states.dart';
import 'package:dar_altep/shared/components/cached_network_image.dart';
import 'package:dar_altep/shared/components/general_components.dart';
import 'package:dar_altep/shared/constants/colors.dart';
import 'package:dar_altep/shared/constants/generalConstants.dart';
import 'package:dar_altep/shared/network/local/const_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TestResultScreen extends StatelessWidget {
  const TestResultScreen({Key? key, this.testName, this.testImage}) : super(key: key);

  final String? testName;
  final String? testImage;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: GeneralAppBar(title: 'Test Result'),
          body: ListView(
            children: [
              Container(
                padding: const EdgeInsetsDirectional.only(
                    start: 10.0, top: 12.0, bottom: 12.0, end: 10.0),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image:
                        const AssetImage("assets/images/onboardingbackground.png"),
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.15), BlendMode.dstATop),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Accurate Results,',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: fontFamily,
                                  color: blueDark,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              verticalMiniSpace,
                              Text(
                                '$testName',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: fontFamily,
                                  color: darkColor,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          const Spacer(),
                          Image.asset(
                            'assets/images/logo.png',
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                    CachedNetworkImageNormal(
                        height: MediaQuery.of(context).size.height * 0.5,
                        width: MediaQuery.of(context).size.width * 0.6,
                        imageUrl: '$testImage'),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

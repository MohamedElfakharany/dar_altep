import 'package:dar_altep/shared/components/general_components.dart';
import 'package:dar_altep/shared/constants/colors.dart';
import 'package:dar_altep/shared/constants/generalConstants.dart';
import 'package:dar_altep/shared/network/local/const_shared.dart';
import 'package:dar_altep/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PrecautionsScreen extends StatelessWidget {
  const PrecautionsScreen(
      {Key? key,
      required this.title,
      required this.description,
      required this.type})
      : super(key: key);
  final String title;
  final String description;
  final String type;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: GeneralAppBar(title: LocaleKeys.BtnPrecautions.tr()),
      body: Container(
        padding: const EdgeInsetsDirectional.only(
            start: 10.0, top: 12.0, bottom: 12.0, end: 10.0),
        height: height,
        width: width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage("assets/images/onboardingbackground.png"),
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.15), BlendMode.dstATop),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              border: Border.all(color: whiteColor, width: 0.0),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 20,
                    color: blueDark,
                    fontWeight: FontWeight.bold,
                    fontFamily: fontFamily,
                    decoration: TextDecoration.underline,
                  ),
                ),
                verticalSmallSpace,
                Text(
                  description,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                    fontFamily: fontFamily,
                  ),
                ),
                verticalMediumSpace,
                Text(
                  'Type',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 20,
                    color: blueDark,
                    fontWeight: FontWeight.bold,
                    fontFamily: fontFamily,
                    decoration: TextDecoration.underline,
                  ),
                ),
                verticalSmallSpace,
                Text(
                  type,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                    fontFamily: fontFamily,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

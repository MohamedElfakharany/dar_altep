import 'package:dar_altep/shared/constants/colors.dart';
import 'package:dar_altep/shared/network/local/const_shared.dart';
import 'package:flutter/material.dart';

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 5, kToday.day);

const titleStyle = TextStyle(color: blueDark,fontFamily: fontFamily,fontSize: 16,fontWeight: FontWeight.bold);

const titleSmallStyle = TextStyle(color: blueDark,fontFamily: fontFamily,fontSize: 14,fontWeight: FontWeight.w600);

const titleSmallStyle2 = TextStyle(color: blueDark,fontFamily: fontFamily,fontSize: 12,fontWeight: FontWeight.w600);

const titleSmallStyleGreen = TextStyle(color: Colors.green,fontFamily: fontFamily,fontSize: 14,fontWeight: FontWeight.w600);

const subTitleSmallStyle = TextStyle(color: greyColor,fontFamily: fontFamily,fontSize: 14,fontWeight: FontWeight.normal);

const subTitleSmallStyle2 = TextStyle(color: greyColor,fontFamily: fontFamily,fontSize: 12,fontWeight: FontWeight.w600);

const subTitleSmallStyle3 = TextStyle(color: greyColor,fontFamily: fontFamily,fontSize: 10,fontWeight: FontWeight.w600);

const verticalMicroSpace = SizedBox(height: 5,);

const verticalMiniSpace = SizedBox(height: 10,);

const verticalSmallSpace = SizedBox(height: 15);

const verticalMediumSpace = SizedBox(height: 25);

const verticalLargeSpace = SizedBox(height: 35);

const horizontalMicroSpace = SizedBox(width: 5,);

const horizontalMiniSpace = SizedBox(width: 10,);

const horizontalSmallSpace = SizedBox(width: 15);

const horizontalMediumSpace = SizedBox(width: 25);

const horizontalLargeSpace = SizedBox(width: 35);


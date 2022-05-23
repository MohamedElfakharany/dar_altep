// ignore_for_file: body_might_complete_normally_nullable

import 'package:dar_altep/cubit/cubit.dart';
import 'package:dar_altep/cubit/states.dart';
import 'package:dar_altep/shared/components/general_components.dart';
import 'package:dar_altep/shared/constants/colors.dart';
import 'package:dar_altep/shared/constants/generalConstants.dart';
import 'package:dar_altep/shared/network/local/const_shared.dart';
import 'package:dar_altep/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyResultsScreen extends StatefulWidget {
  const MyResultsScreen({Key? key, this.testName}) : super(key: key);

  final String? testName;

  @override
  State<MyResultsScreen> createState() => _MyResultsScreenState();
}

class _MyResultsScreenState extends State<MyResultsScreen> {
  final dateOfVisitController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final testItems = AppCubit.get(context).testName;
        String? testValue = testItems.first;
        var newTest = AppCubit.get(context).searchModel?.data?.dataNew;
        return Scaffold(
          appBar: GeneralAppBar(title: LocaleKeys.drawerResults.tr()),
          body: Container(
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
            child: ListView(
              children: [
                verticalSmallSpace,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                            'We hope you are good',
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
                    ],
                  ),
                ),
                verticalSmallSpace,
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  // height: 60.0,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButtonFormField<String>(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return LocaleKeys.txtTestName.tr();
                        }
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding: const EdgeInsetsDirectional.only(
                            start: 20.0, end: 10.0),
                        errorStyle: const TextStyle(color: Color(0xFF4F4F4F)),
                        label: Text(LocaleKeys.txtTestName.tr()),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: blueDark,
                          ),
                        ),
                      ),
                      value: testValue,
                      // isExpanded: true,
                      iconSize: 35,
                      items: testItems.map(buildMenuItem).toList(),
                      onChanged: (value) {
                        setState(() {
                          testValue = value;
                          // print('idValue : ${AppCubit.get(context).testNames!.where((element) {
                          //   return element.name == testValue;
                          // })}');
                          if (kDebugMode) {
                            print('testValue : $testValue');
                          }
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: DefaultFormField(
                    height: 70.0,
                    controller: dateOfVisitController,
                    type: TextInputType.datetime,
                    validatedText: LocaleKeys.TxtFieldDateOfVisit.tr(),
                    label: LocaleKeys.TxtFieldDateOfVisit.tr(),
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime?.now(),
                        firstDate: DateTime?.parse('2020-01-01'),
                        lastDate: DateTime?.now(),
                      ).then((value) {
                        dateOfVisitController.text =
                            DateFormat.yMd().format(value!);
                      }).catchError((error) {
                        if (kDebugMode) {
                          print('error in fetching date');
                          print(error.toString());
                        }
                      });
                    },
                    suffixIcon: Icons.calendar_month,
                  ),
                ),
                verticalLargeSpace,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'New,',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: fontFamily,
                      color: darkColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                verticalSmallSpace,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(8)),
                    height: 70,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              newTest?.first.name ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: fontFamily,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            verticalMiniSpace,
                            Text(
                              '${newTest?.first.date ?? ''}, ${newTest?.first.time ?? ''}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: fontFamily,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        CircleAvatar(
                          radius: 5,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: blueDark,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      blurRadius: 2,
                                      spreadRadius: 2,
                                      offset: const Offset(1, 3)),
                                ]),
                          ),
                        ),
                        horizontalMiniSpace,
                      ],
                    ),
                  ),
                ),
                verticalLargeSpace,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'Checked,',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: fontFamily,
                      color: darkColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                verticalMiniSpace,
                myDivider(),
                verticalMiniSpace,
                Container(
                  height: MediaQuery.of(context).size.height * 0.68,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => Container(
                      height: 70,
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Test Name',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: fontFamily,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              // verticalMicroSpace,
                              Text(
                                '2/3/2021, 5:00 PM',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: fontFamily,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          const CircleAvatar(
                            radius: 8,
                            backgroundColor: Colors.transparent,
                            backgroundImage: AssetImage(
                              'assets/images/checkIcon.png',
                            ),
                          ),
                          horizontalMiniSpace,
                          horizontalMiniSpace,
                          horizontalMiniSpace,
                        ],
                      ),
                    ),
                    separatorBuilder: (context, index) => const SizedBox(),
                    itemCount: 10,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      );
}

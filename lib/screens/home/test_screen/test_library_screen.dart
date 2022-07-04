// ignore_for_file: must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dar_altep/cubit/cubit.dart';
import 'package:dar_altep/cubit/states.dart';
import 'package:dar_altep/models/appointments_model.dart';
import 'package:dar_altep/models/auth/user_model.dart';
import 'package:dar_altep/screens/home/components/widget_components.dart';
import 'package:dar_altep/shared/components/general_components.dart';
import 'package:dar_altep/shared/constants/colors.dart';
import 'package:dar_altep/shared/constants/general_constants.dart';
import 'package:dar_altep/shared/network/local/const_shared.dart';
import 'package:dar_altep/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:searchfield/searchfield.dart';

class TestLibraryScreen extends StatefulWidget {
  const TestLibraryScreen(
      {Key? key, this.user, this.appointments, this.testNames})
      : super(key: key);
  final UserModel? user;
  final AppointmentsModel? appointments;
  final List<String>? testNames;

  @override
  State<TestLibraryScreen> createState() => _TestLibraryScreenState();
}

class _TestLibraryScreenState extends State<TestLibraryScreen> {
  var searchController = TextEditingController();
  String? selectedItem;
  GlobalKey formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..getTestsData(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          String? testValue;
          return Scaffold(
            appBar: GeneralAppBar(title: LocaleKeys.homeTxtTestLibrary.tr()),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 3,
                                  blurRadius: 10,
                                  offset: const Offset(
                                      0, 10), // changes position of shadow
                                ),
                              ],
                            ),
                            alignment: AlignmentDirectional.center,
                            padding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 4),
                            child: TextFormField(
                              controller: searchController,
                              keyboardType: TextInputType.text,
                              onChanged: (val) {
                                AppCubit.get(context)
                                    .getTestsData(testName: val);
                              },
                              cursorColor: blueDark,
                              decoration: InputDecoration(
                                labelText: LocaleKeys.TxtFieldSearch.tr(),
                                // hintText: LocaleKeys.TxtFieldSearch.tr(),
                                suffixIcon: Icon(
                                  Icons.search,
                                  color: blueLight,
                                ),
                                border: InputBorder.none,
                                hintStyle:
                                    TextStyle(color: blueDark, fontSize: 14),
                                labelStyle: const TextStyle(
                                    // color: isClickable ? Colors.grey[400] : blueDark,
                                    color: blueLight,
                                    fontSize: 18,
                                    fontFamily: fontFamily,
                                    fontWeight: FontWeight.bold),
                                errorStyle:
                                    const TextStyle(color: Color(0xFF4F4F4F)),
                                // floatingLabelBehavior: FloatingLabelBehavior.never,
                                contentPadding:
                                    const EdgeInsetsDirectional.only(
                                        start: 20.0, end: 10.0, bottom: 5.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      horizontalMiniSpace,
                      Image.asset(
                        'assets/images/logo.png',
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                  Expanded(
                    child: ConditionalBuilder(
                      condition: state is! AppGetTestsLoadingState,
                      builder: (context) => ConditionalBuilder(
                        condition: AppCubit.get(context).testsModel != null,
                        builder: (context) => ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) => TestLibraryCard(
                              user: widget.user,
                              // appointments: AppCubit.get(context).appointmentsModel,
                              testNames: widget.testNames,
                              context: context,
                              index: index,
                              testsModel: AppCubit.get(context).testsModel),
                          separatorBuilder: (context, index) =>
                              verticalMiniSpace,
                          itemCount:
                              AppCubit.get(context).testsModel!.data!.length,
                        ),
                        fallback: (context) => const ScreenHolder('Tests'),
                      ),
                      fallback: (context) =>
                          Center(child: CircularProgressIndicator()),
                    ),
                  ),
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Container(
                  //       height: 90,
                  //       padding: const EdgeInsets.only(
                  //           right: 20, left: 20, bottom: 20),
                  //       decoration: const BoxDecoration(
                  //         color: Colors.white,
                  //       ),
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           selectedItem == null
                  //               ? const Text(
                  //                   'Please select a Country to Continue',
                  //                   style: TextStyle(
                  //                       fontSize: 16, color: Colors.blueGrey),
                  //                 )
                  //               : Text(selectedItem!,
                  //                   style: TextStyle(
                  //                       fontSize: 16,
                  //                       color: Colors.grey.shade800,
                  //                       fontWeight: FontWeight.w600)),
                  //           MaterialButton(
                  //             onPressed: () {},
                  //             color: Colors.black,
                  //             minWidth: 50,
                  //             height: 50,
                  //             shape: RoundedRectangleBorder(
                  //               borderRadius: BorderRadius.circular(50),
                  //             ),
                  //             padding: const EdgeInsets.all(0),
                  //             child: const Icon(
                  //               Icons.arrow_forward_ios,
                  //               color: Colors.blueGrey,
                  //               size: 24,
                  //             ),
                  //           )
                  //         ],
                  //       ),
                  //     )
                  //   ],
                  // ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(item),
      );
}

// ignore_for_file: body_might_complete_normally_nullable, must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dar_altep/cubit/cubit.dart';
import 'package:dar_altep/cubit/states.dart';
import 'package:dar_altep/models/search_model.dart';
import 'package:dar_altep/screens/drawer/components/drawer_wid_comp.dart';
import 'package:dar_altep/screens/test_result_screen.dart';
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

class MyResultsScreen extends StatefulWidget {
  MyResultsScreen(
      {Key? key, required this.searchModel, required this.testNames})
      : super(key: key);
  List<String> testNames = [];
  SearchModel? searchModel;

  @override
  State<MyResultsScreen> createState() => _MyResultsScreenState();
}

class _MyResultsScreenState extends State<MyResultsScreen> {
  final dateOfVisitController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // var newTest = widget.searchModel?.data?.dataNew;
    var checkedTest = widget.searchModel?.data?.checked;
    // var newTest = AppCubit.get(context).searchModel?.data?.dataNew;
    // var checkedTest = AppCubit.get(context).searchModel?.data?.checked;
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..getUserResults(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is AppGetTestResultSuccessState) {
            if (state.testResultModel.status == true) {
              // Navigator.push(
              //   context,
              //   FadeRoute(
              //     page: TestResultScreen(
              //       testName: newTest?.first.name,
              //       testImage: newTest?.first.image,
              //     ),
              //   ),
              // );
            } else {
              showToast(
                  msg: state.testResultModel.message, state: ToastState.error);
            }
          }
          if (state is AppGetUserResultsSuccessState) {
            if (state.searchModel.status) {
              // showToast(
              //     msg: state.searchModel.message, state: ToastState.success);
            } else {
              showToast(
                  msg: state.searchModel.message, state: ToastState.error);
            }
          }
          if (state is AppGetUserResultsErrorState) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(
                  LocaleKeys.txtError.tr(),
                ),
                content: Text(LocaleKeys.txtNoResults.tr()),
              ),
            );
          }
        },
        builder: (context, state) {
          final testItems = AppCubit.get(context).testName;
          String? _selectedItem;
          String? testValue;
          return Scaffold(
            appBar: GeneralAppBar(title: LocaleKeys.drawerResults.tr()),
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
              child: ConditionalBuilder(
                condition: widget.searchModel != null,
                builder: (context) => ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    verticalSmallSpace,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                LocaleKeys.TxtAccurateResults.tr(),
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: fontFamily,
                                  color: blueDark,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              verticalMiniSpace,
                              Text(
                                LocaleKeys.MyResultScreenWeHope.tr(),
                                style: const TextStyle(
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
                    verticalSmallSpace,
                    Container(
                      width: double.infinity,
                      margin:
                          const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.grey.withOpacity(0.2),
                        //     blurRadius: 10,
                        //     offset: const Offset(0, 10),
                        //   ),
                        // ],
                      ),
                      child: SearchField<String>(
                        hint: LocaleKeys.txtTestName.tr(),
                        searchInputDecoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blueGrey.shade200,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.blue.withOpacity(0.8),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        maxSuggestionsInViewPort: 6,
                        itemHeight: 50,
                        suggestionsDecoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onSuggestionTap: (value){
                          setState(() {
                            _selectedItem = value.toString();
                            print(_selectedItem);
                            if (dateOfVisitController.text == null) {
                              AppCubit.get(context)
                                  .getUserResults(name: _selectedItem);
                            } else {
                              AppCubit.get(context).getUserResults(
                                  date: dateOfVisitController.text,
                                  name: _selectedItem);
                            }
                          });
                        },
                        suggestions: widget.testNames
                            .map(
                              (e) => SearchFieldListItem<String>(
                                e,
                                item: e,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: DefaultFormField(
                        height: 70.0,
                        controller: dateOfVisitController,
                        type: TextInputType.none,
                        validatedText: LocaleKeys.TxtFieldDateOfVisit.tr(),
                        label: LocaleKeys.TxtFieldDateOfVisit.tr(),
                        onTap: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime?.now(),
                            firstDate: DateTime?.parse('2020-01-01'),
                            // lastDate: DateTime?.now(),
                            lastDate: DateTime?.parse('2023-01-01'),
                          ).then((value) {
                            dateOfVisitController.text =
                                DateFormat.yMd().format(value!);
                            if (_selectedItem == null) {
                              AppCubit.get(context).getUserResults(
                                  date: dateOfVisitController.text);
                            } else {
                              AppCubit.get(context).getUserResults(
                                  date: dateOfVisitController.text,
                                  name: _selectedItem);
                            }
                          }).catchError((error) {
                            if (kDebugMode) {
                              print('error in fetching date');
                              print(error.toString());
                            }
                          });
                        },
                        onSubmit: () {},
                        suffixIcon: Icons.calendar_month,
                      ),
                    ),
                    // verticalLargeSpace,
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    //   child: Text(
                    //     LocaleKeys.TxtSearchScreenchecked.tr(),
                    //     style: const TextStyle(
                    //       fontSize: 20.0,
                    //       fontWeight: FontWeight.bold,
                    //       fontFamily: fontFamily,
                    //       color: darkColor,
                    //     ),
                    //     overflow: TextOverflow.ellipsis,
                    //   ),
                    // ),
                    // if (checkedTest?.length != null) verticalMiniSpace,
                    // if (checkedTest?.length != null) myDivider(),
                    // if (checkedTest?.length != null) verticalMiniSpace,
                    if (checkedTest?.length != null)
                      ConditionalBuilder(
                        condition: state is! AppGetUserResultsLoadingState,
                        builder: (context) => Container(
                          height: MediaQuery.of(context).size.height * 0.45,
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: ConditionalBuilder(
                            condition: AppCubit.get(context)
                                    .searchModel?.data?.checked !=
                                null,
                            builder: (context) => Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) => InkWell(
                                  onTap: () {
                                    if (kDebugMode) {
                                      print('result');
                                    }
                                    AppCubit.get(context)
                                        .getTestResultData(
                                            reservationId:
                                                checkedTest?[index].visitId)
                                        .then((value) {
                                      if (state is AppGetTestResultSuccessState) {
                                        Navigator.push(
                                          context,
                                          FadeRoute(
                                            page: TestResultScreen(
                                              testName: checkedTest?[index].name,
                                              testImage:
                                                  checkedTest?[index].image,
                                              // testImage: 'https://avatars.githubusercontent.com/u/34916493?s=400&u=e7300b829193270fbcd03a813551a3702299cbb1&v=4',
                                            ),
                                          ),
                                        );
                                      }
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: MyResultsCard(
                                        context: context,
                                        index: index,
                                        checkedData: checkedTest?[index]),
                                  ),
                                ),
                                separatorBuilder: (context, index) =>
                                    myDivider(),
                                itemCount: AppCubit.get(context)
                                    .searchModel!
                                    .data!
                                    .checked!
                                    .length,
                              ),
                            ),
                            fallback: (context) =>
                                const Center(child: CircularProgressIndicator()),
                          ),
                        ),
                        fallback: (context) => const Center(child: CircularProgressIndicator()),
                      ),
                  ],
                ),
                fallback: (context) => const ScreenHolder('results'),
              ),
            ),
          );
        },
      ),
    );
  }

  // DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
  //       value: item,
  //       child: Text(
  //         item,
  //         overflow: TextOverflow.ellipsis,
  //         maxLines: 1,
  //       ),
  //     );
}
// if (newTest?.first != null)
//   Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 20.0),
//     child: Text(
//       LocaleKeys.TxtSearchScreenNew.tr(),
//       style: const TextStyle(
//         fontSize: 20.0,
//         fontWeight: FontWeight.bold,
//         fontFamily: fontFamily,
//         color: darkColor,
//       ),
//       overflow: TextOverflow.ellipsis,
//     ),
//   ),
// if (newTest?.first != null) verticalSmallSpace,
// if (newTest?.first != null)
//   ConditionalBuilder(
//     condition: state is! AppGetUserResultsLoadingState,
//     builder: (context) => Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: InkWell(
//         onTap: () {
//           if (kDebugMode) {
//             print('result ${newTest?.first.visitId}');
//           }
//           AppCubit.get(context)
//               .getTestResultData(
//                   reservationId: newTest?.first.visitId)
//               .then((value) {});
//         },
//         child: Container(
//           decoration: BoxDecoration(
//               color: Colors.grey.withOpacity(0.08),
//               borderRadius: BorderRadius.circular(8)),
//           height: 70,
//           padding:
//               const EdgeInsets.symmetric(horizontal: 10.0),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     newTest?.first.name ?? '',
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: const TextStyle(
//                       fontFamily: fontFamily,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   verticalMiniSpace,
//                   Text(
//                     '${newTest?.first.date ?? ''}, ${newTest?.first.time ?? ''}',
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: const TextStyle(
//                       fontFamily: fontFamily,
//                       fontWeight: FontWeight.normal,
//                     ),
//                   ),
//                 ],
//               ),
//               const Spacer(),
//               CircleAvatar(
//                 radius: 5,
//                 child: Container(
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(5),
//                       color: blueDark,
//                       boxShadow: [
//                         BoxShadow(
//                             color:
//                                 Colors.grey.withOpacity(0.3),
//                             blurRadius: 2,
//                             spreadRadius: 2,
//                             offset: const Offset(1, 3)),
//                       ]),
//                 ),
//               ),
//               horizontalMiniSpace,
//             ],
//           ),
//         ),
//       ),
//     ),
//     fallback: (context) => const Center(
//       child: CircularProgressIndicator(),
//     ),
//   ),
// if (newTest?.first != null) verticalLargeSpace,
// if (checkedTest?.length != null)
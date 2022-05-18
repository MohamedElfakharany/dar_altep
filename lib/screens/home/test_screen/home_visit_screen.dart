// ignore_for_file: must_be_immutable, body_might_complete_normally_nullable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dar_altep/cubit/cubit.dart';
import 'package:dar_altep/cubit/states.dart';
import 'package:dar_altep/screens/home/home_screen.dart';
import 'package:dar_altep/shared/components/general_components.dart';
import 'package:dar_altep/shared/constants/colors.dart';
import 'package:dar_altep/shared/constants/generalConstants.dart';
import 'package:dar_altep/shared/network/local/const_shared.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeVisitScreen extends StatefulWidget {
  const HomeVisitScreen({Key? key}) : super(key: key);

  @override
  State<HomeVisitScreen> createState() => _HomeVisitScreenState();
}

class _HomeVisitScreenState extends State<HomeVisitScreen> {
  final nameController = TextEditingController();

  final mobileController = TextEditingController();

  final addressController = TextEditingController();

  final dateOfVisitController = TextEditingController();

  final timeController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  final testItems = ['Sugar Test', 'Blood Test'];

  String? testValue;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppHomeReservationsErrorState) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Error...!'),
                  content: Text(state.error),
                );
              });
        } else if (state is AppHomeReservationsSuccessState) {
          showPopUp(
            context,
            Container(
              height: height * 0.7,
              width: width ,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsetsDirectional.only(end: 30.0),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  verticalMediumSpace,
                  Padding(
                    padding:
                    const EdgeInsetsDirectional.only(
                        start: 20.0),
                    child: Column(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: [
                        verticalMediumSpace,
                        Center(
                          child: Image.asset(
                            'assets/images/onboarding1.png',
                            height: height * 0.3,
                            width: width * 0.6,
                          ),
                        ),
                        verticalMediumSpace,
                        Text(
                          'Thank You',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: fontFamily,
                            fontWeight: FontWeight.bold,
                            color: blueDark,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        verticalMediumSpace,
                        Text(
                          'your data saved successfully and we will contact you',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: fontFamily,
                            fontWeight: FontWeight.normal,
                            color: darkColor,
                          ),
                        ),
                        verticalLargeSpace,
                        GeneralButton(
                          title: 'Done',
                          onPress: (){
                            if (kDebugMode) {
                              print('done pressed');
                            }
                            Navigator.pushAndRemoveUntil(context, FadeRoute(page: const HomeScreen()), (route) => false);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        var user = AppCubit.get(context).userdata?.data;
        nameController.text = user?.name;
        mobileController.text = user?.phone;
        return Scaffold(
          // extendBodyBehindAppBar: true,
          appBar: GeneralAppBar(
            title: 'Home Visit',
          ),
          body: Container(
            padding: const EdgeInsetsDirectional.only(
              start: 10.0,
              top: 20.0,
              bottom: 20.0,
            ),
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
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            'Enter patient data and we will contact you to confirm reservation',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: fontFamily,
                              color: blueDark2,
                            ),
                          ),
                        ),
                        verticalLargeSpace,
                        DefaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          label: 'Full Name',
                          validatedText: 'Full Name',
                          hintText: 'Full Name',
                          suffixPressed: () {},
                        ),
                        verticalSmallSpace,
                        DefaultFormField(
                          controller: mobileController,
                          type: TextInputType.phone,
                          validatedText: 'Mobile Number',
                          label: 'Mobile Number',
                          hintText: 'Mobile Number',
                        ),
                        verticalSmallSpace,
                        DefaultFormField(
                          controller: addressController,
                          type: TextInputType.text,
                          validatedText: 'Address',
                          label: 'Address',
                        ),
                        verticalSmallSpace,
                        DefaultFormField(
                          controller: dateOfVisitController,
                          type: TextInputType.datetime,
                          validatedText: 'Date Of Visit',
                          label: 'Date Of Visit',
                          onTap: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime?.now(),
                              firstDate: DateTime?.now(),
                              lastDate: DateTime?.parse('2022-05-30'),
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
                        verticalSmallSpace,
                        DefaultFormField(
                          controller: timeController,
                          type: TextInputType.datetime,
                          suffixIcon: Icons.watch_later_outlined,
                          label: 'choose Time',
                          validatedText: 'Time',
                          onTap: () async {
                            try {
                              var time = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now());
                              timeController.text =
                                  time!.format(context).toString();
                              if (kDebugMode) {
                                print(timeController.text);
                              }
                            } catch (error) {
                              if (kDebugMode) {
                                print(error);
                              }
                            }
                          },
                        ),
                        verticalSmallSpace,
                        Container(
                          height: 60.0,
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 5,
                                offset: const Offset(
                                    0, 5), // changes position of shadow
                              ),
                            ],
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField<String>(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Choose Test Name';
                                }
                              },
                              decoration: const InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                contentPadding: EdgeInsetsDirectional.only(
                                    start: 20.0, end: 10.0),
                                errorStyle: TextStyle(color: Color(0xFF4F4F4F)),
                                label: Text('Test Name'),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: blueDark,
                                  ),
                                ),
                              ),
                              value: testValue,
                              isExpanded: true,
                              iconSize: 35,
                              items: testItems.map(buildMenuItem).toList(),
                              onChanged: (value) =>
                                  setState(() => testValue = value),
                            ),
                          ),
                        ),
                        verticalLargeSpace,
                        verticalLargeSpace,
                        ConditionalBuilder(
                          condition: state is! AppHomeReservationsLoadingState,
                          builder: (context) => GeneralButton(
                            title: 'Submit',
                            onPress: () {
                              if (formKey.currentState!.validate()) {
                                if (kDebugMode) {
                                  print('from ConditionalBuilder btn pressed');
                                }
                                AppCubit.get(context).addHomeReservation(
                                  name: nameController.text,
                                  phone: mobileController.text,
                                  testName: testValue ?? '',
                                  address: addressController.text,
                                  dateOfVisit: dateOfVisitController.text,
                                  time: timeController.text,
                                );
                              }
                            },
                          ),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(item),
      );
}

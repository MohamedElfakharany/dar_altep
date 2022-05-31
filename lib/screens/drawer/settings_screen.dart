// ignore_for_file: must_be_immutable, body_might_complete_normally_nullable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dar_altep/cubit/cubit.dart';
import 'package:dar_altep/cubit/states.dart';
import 'package:dar_altep/screens/drawer/change_password.dart';
import 'package:dar_altep/shared/components/cached_network_image.dart';
import 'package:dar_altep/shared/components/general_components.dart';
import 'package:dar_altep/shared/constants/colors.dart';
import 'package:dar_altep/shared/constants/generalConstants.dart';
import 'package:dar_altep/shared/network/local/const_shared.dart';
import 'package:dar_altep/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final mobileController = TextEditingController();

  final dateOfBirthController = TextEditingController();

  final nationalityController = TextEditingController();

  final genderController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  final nationalityItems = ['Saudi Arabia', 'U A E', 'Qatar', 'Egyptian'];
  String? nationalValue;

  final genderItems = ['Male', 'Female'];
  String? genderValue;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..getProfileData(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is AppEditProfileErrorState) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Error...!'),
                    content: Text(state.error),
                  );
                });
          }
        },
        builder: (context, state) {
          var profileImage = AppCubit.get(context).profileImage;
          var user = AppCubit.get(context).userModel;
          return Scaffold(
            appBar: GeneralAppBar(
              title: LocaleKeys.drawerSettings.tr(),
            ),
            body: ConditionalBuilder(
              condition: state is! AppGetProfileLoadingState,
              builder: (context) {
                nameController.text = user?.data?.name ?? '';
                emailController.text = user?.data?.email ?? '';
                dateOfBirthController.text = user?.data?.birthrate ?? '';
                mobileController.text = user?.data?.phone ?? '';
                print('user?.data?.nationality : ${user?.data?.nationality}');
                print('user?.data?.nationality : ${user?.data?.gender}');
                // nationalValue = user?.data?.nationality;
                // genderValue = user?.data?.gender;
                return Container(
                  padding: const EdgeInsetsDirectional.only(
                    start: 10.0,
                    top: 20.0,
                    bottom: 20.0,
                  ),
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
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 20),
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              Container(
                                height: 140.0,
                                width: 140.0,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: blueLight.withOpacity(0.4),
                                      spreadRadius: 5,
                                      blurRadius: 10,
                                      offset: const Offset(
                                          0, 0), // changes position of shadow
                                    ),
                                  ],
                                  border: Border.all(color: Colors.grey),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(70),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(70.0),
                                  child: InkWell(
                                    onTap: () {
                                      AppCubit.get(context).getProfileImage();
                                    },
                                    child: profileImage == null
                                        ? CachedNetworkImageCircular(
                                            imageUrl: user?.data?.idImage ?? '',
                                            height: 140,
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(83),
                                            child: Image.file(
                                              profileImage,
                                              height: 140,
                                              width: 140,
                                              fit: BoxFit.cover,
                                            )),
                                  ),
                                ),
                              ),
                              verticalLargeSpace,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    user?.data?.name ?? '',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: fontFamily,
                                      fontWeight: FontWeight.bold,
                                      color: blueDark2,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  verticalMiniSpace,
                                  Text(
                                    user?.data?.email ?? '',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: fontFamily,
                                      fontWeight: FontWeight.normal,
                                      color: blueDark2,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              verticalMediumSpace,
                              DefaultFormField(
                                controller: nameController,
                                type: TextInputType.name,
                                label: LocaleKeys.txtFieldName.tr(),
                                validatedText: LocaleKeys.txtFieldName.tr(),
                                hintText: LocaleKeys.txtFieldName.tr(),
                                suffixPressed: () {},
                                onTap: () {},
                              ),
                              verticalSmallSpace,
                              DefaultFormField(
                                controller: emailController,
                                type: TextInputType.emailAddress,
                                validatedText: LocaleKeys.txtFieldEmail.tr(),
                                label: LocaleKeys.txtFieldEmail.tr(),
                                hintText: LocaleKeys.txtFieldEmail.tr(),
                                onTap: () {},
                              ),
                              verticalSmallSpace,
                              DefaultFormField(
                                controller: mobileController,
                                type: TextInputType.phone,
                                validatedText: LocaleKeys.txtFieldMobile.tr(),
                                label: LocaleKeys.txtFieldMobile.tr(),
                                hintText: LocaleKeys.txtFieldMobile.tr(),
                                onTap: () {},
                              ),
                              verticalSmallSpace,
                              Container(
                                height: 60.0,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 3,
                                      blurRadius: 10,
                                      offset: const Offset(0,
                                          10), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButtonFormField<String>(
                                    validator: (String? value) {
                                      if (value != null &&
                                          value.isEmpty) {
                                        return 'Choose Nationality';
                                      }
                                    },
                                    decoration: InputDecoration(
                                      contentPadding:
                                      const EdgeInsetsDirectional.only(
                                          start: 20.0, end: 10.0),
                                      fillColor: Colors.white,
                                      filled: true,
                                      errorStyle: const TextStyle(
                                          color: Color(0xFF4F4F4F)),
                                      label: Text(LocaleKeys.txtFieldNationality.tr(),),
                                      border: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 2,
                                          color: blueDark,
                                        ),
                                      ),
                                    ),
                                    value: nationalValue,
                                    isExpanded: true,
                                    iconSize: 35,
                                    items: nationalityItems
                                        .map(buildMenuItem)
                                        .toList(),
                                    onChanged: (value) => setState(
                                            () => nationalValue = value),
                                    onSaved: (v){
                                      FocusScope.of(context).unfocus();
                                    },
                                  ),
                                ),
                              ),
                              verticalSmallSpace,
                              DefaultFormField(
                                controller: dateOfBirthController,
                                type: TextInputType.datetime,
                                validatedText: LocaleKeys.txtFieldDateOfBirth.tr(),
                                label: LocaleKeys.txtFieldDateOfBirth.tr(),
                                onTap: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime?.now(),
                                    firstDate:
                                    DateTime?.parse('1950-01-01'),
                                    lastDate: DateTime?.now(),
                                  ).then((value) {
                                    dateOfBirthController.text =
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
                              Container(
                                height: 60.0,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 3,
                                      blurRadius: 10,
                                      offset: const Offset(0,
                                          10), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButtonFormField<String>(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Choose Gender';
                                      }
                                    },
                                    decoration: InputDecoration(
                                      contentPadding:
                                      const EdgeInsetsDirectional.only(
                                          start: 20.0, end: 10.0),
                                      fillColor: Colors.white,
                                      filled: true,
                                      errorStyle: const TextStyle(
                                          color: Color(0xFF4F4F4F)),
                                      label: Text(LocaleKeys.txtFieldGender.tr(),),
                                      border: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 2,
                                          color: blueDark,
                                        ),
                                      ),
                                    ),
                                    value: genderValue,
                                    isExpanded: true,
                                    iconSize: 35,
                                    items: genderItems
                                        .map(buildMenuItem)
                                        .toList(),
                                    onChanged: (value) => setState(
                                            () => genderValue = value),
                                    onSaved: (v){
                                      FocusScope.of(context).unfocus();
                                    },
                                  ),
                                ),
                              ),
                              verticalMediumSpace,
                              ConditionalBuilder(
                                condition: state is! AppEditProfileLoadingState,
                                builder: (context) => GeneralButton(
                                  title: LocaleKeys.BtnSaveChanges.tr(),
                                  onPress: () {
                                    if (formKey.currentState!.validate()) {
                                      if (kDebugMode) {
                                        print(
                                            'from ConditionalBuilder btn pressed');
                                      }
                                      AppCubit.get(context).editProfile(
                                        name: nameController.text,
                                        phone: mobileController.text,
                                        email: emailController.text,
                                        nationality: nationalValue ?? user?.data?.nationality,
                                        gender: genderValue ?? user?.data?.gender,
                                        birthdate: dateOfBirthController.text,
                                        image: profileImage == null
                                            ? user?.data?.idImage
                                            : 'storage/${Uri.file(profileImage.path).pathSegments.last}',
                                      );
                                    }
                                  },
                                ),
                                fallback: (context) => const Center(
                                    child: CircularProgressIndicator()),
                              ),
                              verticalMediumSpace,
                              GeneralButton(
                                title: LocaleKeys.BtnChangePassword.tr(),
                                onPress: () {
                                  Navigator.push(
                                      context, FadeRoute(page: ChangePasswordScreen()));
                                },
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
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

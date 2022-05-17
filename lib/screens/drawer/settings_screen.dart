// ignore_for_file: must_be_immutable, body_might_complete_normally_nullable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dar_altep/cubit/cubit.dart';
import 'package:dar_altep/cubit/states.dart';
import 'package:dar_altep/screens/auth/reset_password.dart';
import 'package:dar_altep/shared/components/cached_network_image.dart';
import 'package:dar_altep/shared/components/general_components.dart';
import 'package:dar_altep/shared/constants/colors.dart';
import 'package:dar_altep/shared/constants/generalConstants.dart';
import 'package:dar_altep/shared/network/local/const_shared.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final mobileController = TextEditingController();

  final dateOfBirthController = TextEditingController();

  final nationalityController = TextEditingController();

  final genderController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
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
        var user = AppCubit.get(context).userdata?.data;
        nameController.text = user?.name;
        emailController.text = user?.email;
        dateOfBirthController.text = user?.birthrate;
        mobileController.text = user?.phone;
        nationalityController.text = user?.nationality;
        genderController.text = user?.gender;
        // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        //   statusBarColor: Colors.transparent,
        // ));
        return Scaffold(
          // extendBodyBehindAppBar: true,
          appBar: GeneralAppBar(
            title: 'Settings',
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
                              onTap: (){
                                AppCubit.get(context).getProfileImage();
                              },
                              child: profileImage == null ? CachedNetworkImageCircular(
                                imageUrl: user?.idImage,
                                height: 140,
                              ): ClipRRect(
                                  borderRadius: BorderRadius.circular(83),
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
                              user?.name,
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
                              user?.email,
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
                          label: 'Full Name',
                          validatedText: 'Full Name',
                          hintText: 'Full Name',
                          suffixPressed: () {},
                        ),
                        verticalSmallSpace,
                        DefaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validatedText: 'Email',
                          label: 'Email',
                          hintText: 'Email',
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
                          readOnly: true,
                          controller: nationalityController,
                          type: TextInputType.datetime,
                          validatedText: 'Nationality',
                          label: 'Nationality',
                          hintText: user?.nationality,
                        ),
                        verticalSmallSpace,
                        DefaultFormField(
                          readOnly: true,
                          controller: dateOfBirthController,
                          type: TextInputType.datetime,
                          validatedText: 'Date Of Birth',
                          label: 'Date Of Birth',
                          hintText: 'Date Of Birth',
                          onTap: () {},
                          suffixIcon: Icons.calendar_month,
                        ),
                        verticalSmallSpace,
                        DefaultFormField(
                          readOnly: true,
                          controller: genderController,
                          type: TextInputType.datetime,
                          validatedText: 'Gender',
                          label: 'Gender',
                          hintText: 'Gender',
                        ),
                        verticalMediumSpace,
                        ConditionalBuilder(
                          condition: state is! AppEditProfileLoadingState,
                          builder: (context) => GeneralButton(
                            title: 'Save Changes',
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
                                  image: 'storage/${Uri.file(profileImage!.path).pathSegments.last}',
                                );
                              }
                            },
                          ),
                          fallback: (context) => const Center(
                              child: CircularProgressIndicator()),
                        ),
                        verticalMediumSpace,
                        GeneralButton(
                          title: 'Change Password',
                          onPress: () {
                            Navigator.push(
                                context, FadeRoute(page: ResetPassword()));
                          },
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
}

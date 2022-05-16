import 'dart:convert';

import 'package:dar_altep/cubit/states.dart';
import 'package:dar_altep/models/auth/check_code_model.dart';
import 'package:dar_altep/models/auth/offers_model.dart';
import 'package:dar_altep/models/auth/user_model.dart';
import 'package:dar_altep/screens/auth/onboarding/onboarding_screen.dart';
import 'package:dar_altep/shared/components/general_components.dart';
import 'package:dar_altep/shared/network/local/cache_helper.dart';
import 'package:dar_altep/shared/network/local/const_shared.dart';
import 'package:dar_altep/shared/network/remote/end_points.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialAppStates());

  static AppCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;
  VerificationModel? verificationModel;
  OffersModel? offersModel;

  Future login({
    required String phone,
    required String password,
  }) async {
    var headers = {
      'Accept': 'application/json',
      'lang': lang,
    };
    var formData = json.encode({
      'phone': phone,
      'password': password,
    });

    try {
      emit(AppLoginLoadingState());
      Dio dio = Dio();
      var response = await dio.post(
        loginURL,
        data: formData,
        options: Options(
          followRedirects: false,
          responseType: ResponseType.bytes,
          validateStatus: (status) => true,
          headers: headers,
        ),
      );
      var responseJsonB = response.data;
      var convertedResponse = utf8.decode(responseJsonB);
      var responseJson = json.decode(convertedResponse);
      if (kDebugMode) {
        print('formData $formData');
        print('responseJson $responseJson');
      }
      userModel = UserModel.fromJson(responseJson);
      emit(AppLoginSuccessState(userModel!));
    } catch (e) {
      emit(AppLoginErrorState(e.toString()));
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future register({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String birthdate,
    required String nationality,
    required String gender,
    required String age,
    String lang = 'en',
  }) async {
    var headers = {
      'Accept': 'application/json',
      'lang': lang,
    };
    var formData = json.encode({
      'name': name,
      'phone': phone,
      'email': email,
      'password': password,
      'birthrate': birthdate,
      'age': age,
      'gender': gender,
      'nationality': nationality,
    });

    try {
      emit(AppRegisterLoadingState());
      Dio dio = Dio();
      var response = await dio.post(
        registerURL,
        data: formData,
        options: Options(
          followRedirects: false,
          responseType: ResponseType.bytes,
          validateStatus: (status) => true,
          headers: headers,
        ),
      );
      var responseJsonB = response.data;
      var convertedResponse = utf8.decode(responseJsonB);
      var responseJson = json.decode(convertedResponse);
      if (kDebugMode) {
        print('responseJson $responseJson');
      }
      userModel = UserModel.fromJson(responseJson);
      emit(AppRegisterSuccessState(userModel!));
    } catch (e) {
      emit(AppRegisterErrorState(e.toString()));
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future verify({
    required String? phone,
    required String? verification,
    String lang = 'en',
  }) async {
    var headers = {
      'Accept': 'application/json',
      'lang': lang,
    };
    var formData = json.encode({
      'phone': phone,
      'check_code': verification,
    });

    try {
      emit(AppVerificationLoadingState());
      Dio dio = Dio();
      var response = await dio.post(
        verificationURL,
        data: formData,
        options: Options(
          followRedirects: false,
          responseType: ResponseType.bytes,
          validateStatus: (status) => true,
          headers: headers,
        ),
      );
      var responseJsonB = response.data;
      var convertedResponse = utf8.decode(responseJsonB);
      var responseJson = json.decode(convertedResponse);
      if (kDebugMode) {
        print('phone $phone');
        print('verification $verification');
        print('responseJson $responseJson');
      }
      verificationModel = VerificationModel.fromJson(responseJson);
      emit(AppVerificationSuccessState(verificationModel!));
    } catch (e) {
      emit(AppVerificationErrorState(e.toString()));
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future getFavoritesData() async {
    emit(AppGetOffersLoadingState());
    var headers = {
      'Content-Type': 'application/json',
      'lang': 'en',
      'Authorization': token ?? '',
    };
    try {
      Dio dio = Dio();
      var response = await dio.get(
        getOffersURL,
        options: Options(
          followRedirects: false,
          responseType: ResponseType.bytes,
          validateStatus: (status) => true,
          headers: headers,
        ),
      );
      var responseJson = response.data;
      var convertedResponsetoUTF = utf8.decode(responseJson);
      offersModel = offersModelFromJson(convertedResponsetoUTF);
      emit(AppGetOffersSuccessState(offersModel!));
    } catch (error) {
      // print(error.toString());
      emit(AppGetOffersErrorState(error.toString()));
    }
  }

  IconData sufIcon = Icons.visibility_off_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    sufIcon =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(AppChangePasswordVisibilityState());
  }

  bool isLanguage = false;

  String local = 'en';

  dynamic changeLanguage() {
    isLanguage = !isLanguage;
    local = isLanguage ? local = 'ar' : local = 'en';
    emit(AppChangeLanguageState());
  }

  bool rememberMe = false;

  void onRememberMeChanged() {
    rememberMe = !rememberMe;
    if (rememberMe) {
      // TODO: Here goes your functionality that remembers the user.
    } else {
      // TODO: Forget the user
    }
    emit(AppChangeRememberMeState());
  }

  void signOut(context) {
    CacheHelper.removeData(key: 'token').then((value) {
      if (value) {
        navigateAndFinish(
          context,
          const OnboardingScreen(),
        );
      }
      emit(AppLogoutSuccessState());
    });
  }
}

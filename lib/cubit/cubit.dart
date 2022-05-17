import 'dart:convert';
import 'dart:io';

import 'package:dar_altep/cubit/states.dart';
import 'package:dar_altep/models/auth/check_code_model.dart';
import 'package:dar_altep/models/offers_model.dart';
import 'package:dar_altep/models/auth/user_model.dart';
import 'package:dar_altep/models/tests_model.dart';
import 'package:dar_altep/screens/auth/onboarding/onboarding_screen.dart';
import 'package:dar_altep/shared/components/general_components.dart';
import 'package:dar_altep/shared/network/local/cache_helper.dart';
import 'package:dar_altep/shared/network/local/const_shared.dart';
import 'package:dar_altep/shared/network/remote/end_points.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialAppStates());

  static AppCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;
  VerificationModel? verificationModel;
  OffersModel? offersModel;
  TestsModel? testsModel;
  UserModel? userdata;
  int offersCount = 1;

  Future login({
    required String phone,
    required String password,
  }) async {
    var headers = {
      'Accept': 'application/json',
      'lang': lang ?? 'en',
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
      if (kDebugMode) {
        print('user model ${userModel?.data?.idImage}');
      }
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

  Future editProfile({
    required String name,
    required String phone,
    required String email,
    required String image,
  }) async {
    var headers = {
      'Accept': 'application/json',
      'lang': lang ?? 'en',
      'Authorization': 'Bearer $token',
    };
    var formData = FormData.fromMap({
      'name': name,
      'phone': phone,
      'email': email,
      'ID_image': await MultipartFile.fromFile(
        profileImage!.path,
        filename: image,
      ),
    });

    try {
      emit(AppEditProfileLoadingState());
      Dio dio = Dio();
      var response = await dio.post(
        updateProfileURL,
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
        print('form data $formData');
      }
      userModel = UserModel.fromJson(responseJson);
      getProfileData();
      emit(AppEditProfileSuccessState(userModel!));
    } catch (e) {
      emit(AppEditProfileErrorState(e.toString()));
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future getProfileData() async {
    emit(AppGetProfileLoadingState());
    var headers = {
      'Accept': 'application/json',
      'lang': lang ?? 'en',
      'Authorization': 'Bearer $token',
    };
    try {
      Dio dio = Dio();
      var response = await dio.get(
        getProfileURL,
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
      userdata = UserModel.fromJson(responseJson);
      var user = userdata?.data;

      if (kDebugMode) {
        print('user data name is : ${user?.name}');
        print(getProfileURL);
        print(responseJson);
      }
      emit(AppGetProfileSuccessState());
    } catch (error) {
      if (kDebugMode) {
        print('error ${error.toString()}');
      }
      emit(AppGetProfileErrorState(error.toString()));
    }
  }

  Future getOffersData() async {
    emit(AppGetOffersLoadingState());
    var headers = {
      'Accept': 'application/json',
      'lang': lang ?? 'en',
      'Authorization': 'Bearer $token',
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
      var responseJsonB = response.data;
      var convertedResponse = utf8.decode(responseJsonB);
      var responseJson = json.decode(convertedResponse);
      offersModel = OffersModel.fromJson(responseJson);
      if (kDebugMode) {
        print(getOffersURL);
        print(responseJson);
        print('offersModel?.data.length ${offersModel?.data?.length}');
        print('offersModel?.data ${offersModel?.data?[0].name}');
      }
      emit(AppGetOffersSuccessState(offersModel!));
    } catch (error) {
      if (kDebugMode) {
        print('error ${error.toString()}');
      }
      emit(AppGetOffersErrorState(error.toString()));
    }
  }

  Future getTestsData() async {
    emit(AppGetTestsLoadingState());
    var headers = {
      'Accept': 'application/json',
      'lang': lang ?? 'en',
      'Authorization': 'Bearer $token',
    };
    try {
      Dio dio = Dio();
      var response = await dio.get(
        getTestsURL,
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
      testsModel = TestsModel.fromJson(responseJson);
      if (kDebugMode) {
        print('testsModel?.data.length ${testsModel?.data?.length}');
        print('testsModel?.data?[0].id ${testsModel?.data?[0].id}');
      }
      emit(AppGetTestsSuccessState(testsModel!));
    } catch (error) {
      if (kDebugMode) {
        print('error ${error.toString()}');
      }
      emit(AppGetTestsErrorState(error.toString()));
    }
  }

  Future getTestDetailsData() async {
    emit(AppGetTestsLoadingState());
    var headers = {
      'Accept': 'application/json',
      'lang': lang ?? 'en',
      'Authorization': 'Bearer $token',
    };
    try {
      Dio dio = Dio();
      var response = await dio.get(
        getTestsURL,
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
      testsModel = TestsModel.fromJson(responseJson);
      if (kDebugMode) {
        print('testsModel?.data.length ${testsModel?.data?.length}');
        print('testsModel?.data?[0].id ${testsModel?.data?[0].id}');
      }
      emit(AppGetTestsSuccessState(testsModel!));
    } catch (error) {
      if (kDebugMode) {
        print('error ${error.toString()}');
      }
      emit(AppGetTestsErrorState(error.toString()));
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

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    try {
      XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        profileImage = File(pickedImage.path);
        if (kDebugMode) {
          print('dfsdfdfsdf');
          print(profileImage);
          print('${Uri.file(profileImage!.path).pathSegments.last}');
        }
        emit(AppProfileImagePickedSuccessState());
      } else {
        if (kDebugMode) {
          print('no image selected');
          print(profileImage);
        }
        emit(AppProfileImagePickedErrorState());
      }
    } catch (e) {
      if (kDebugMode) {
        print('no');
        print(profileImage);
        print(e.toString());
      }
    }
  }
}

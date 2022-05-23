// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:io';

import 'package:dar_altep/cubit/states.dart';
import 'package:dar_altep/models/appointments_model.dart';
import 'package:dar_altep/models/auth/check_code_model.dart';
import 'package:dar_altep/models/home_reservation_model.dart';
import 'package:dar_altep/models/lab_reservation_model.dart';
import 'package:dar_altep/models/offers_model.dart';
import 'package:dar_altep/models/auth/user_model.dart';
import 'package:dar_altep/models/reservation_model.dart';
import 'package:dar_altep/models/search_model.dart';
import 'package:dar_altep/models/test_name_model.dart';
import 'package:dar_altep/models/test_results_model.dart';
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
// import 'package:http/http.dart' as http;

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialAppStates());

  static AppCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;
  VerificationModel? verificationModel;
  OffersModel? offersModel;
  OffersModel? homeOffersModel;
  OffersModel? labOffersModel;
  TestsModel? testsModel;
  ReservationsModel? reservationModel;
  HomeReservationsModel? homeReservationsModel;
  UserModel? userdata;
  TestResultModel? testResultModel;
  TestNameModel? testNameModel;
  List<TestModelData>? testNames = [];
  List<String> testName = [];
  SearchModel? searchModel;

  AppointmentsModel? appointmentsModel;
  LabReservationModel? labReservationModel;

  int offersCount = 1;

  Future login({
    required String phone,
    required String password,
  }) async {
    var headers = {
      'Accept': 'application/json',
      'lang': local,
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
      // if (kDebugMode) {
      //   print('user model ${userModel?.data?.idImage}');
      // }
      getOffersData();
      getTestsData();
      getProfileData();
      getReservationsData();
      getTestNameData();
      getAppointmentsData();
      getLabOffersData();
      getHomeOffersData();
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
  }) async {
    var headers = {
      'Accept': 'application/json',
      'lang': local,
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
      // if (kDebugMode) {
      //   print('responseJson $responseJson');
      // }
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
  }) async {
    var headers = {
      'Accept': 'application/json',
      'lang': local,
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
      // if (kDebugMode) {
      //   print('phone $phone');
      //   print('verification $verification');
      //   print('responseJson $responseJson');
      // }
      getOffersData();
      getTestsData();
      getProfileData();
      getReservationsData();
      getTestNameData();
      getAppointmentsData();
      getLabOffersData();
      getHomeOffersData();
      verificationModel = VerificationModel.fromJson(responseJson);
      emit(AppVerificationSuccessState(verificationModel!));
    } catch (e) {
      emit(AppVerificationErrorState(e.toString()));
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future cancelReservation({
    required String? reservationId,
  }) async {
    var headers = {
      'Accept': 'application/json',
      'lang': local,
    };
    var formData = json.encode({
      'reservation_id': reservationId,
    });

    try {
      emit(AppCancelReservationsLoadingState());
      Dio dio = Dio();
      var response = await dio.post(
        cancelReservationURL,
        data: formData,
        options: Options(
          followRedirects: false,
          responseType: ResponseType.bytes,
          validateStatus: (status) => true,
          headers: headers,
        ),
      );
      emit(AppCancelReservationsSuccessState());
      getReservationsData();
    } catch (e) {
      emit(AppCancelReservationsErrorState(e.toString()));
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future deleteReservation({
    required String? reservationId,
  }) async {
    var headers = {
      'Accept': 'application/json',
      'lang': local,
    };
    var formData = json.encode({
      'reservation_id': reservationId,
    });

    try {
      emit(AppDeleteReservationsLoadingState());
      Dio dio = Dio();
      var response = await dio.post(
        deleteReservationURL,
        data: formData,
        options: Options(
          followRedirects: false,
          responseType: ResponseType.bytes,
          validateStatus: (status) => true,
          headers: headers,
        ),
      );
      if (kDebugMode) {
        print(reservationId);
        print(response.data);
      }
      emit(AppDeleteReservationsSuccessState());
      getReservationsData();
    } catch (e) {
      emit(AppDeleteReservationsErrorState(e.toString()));
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
      'lang': local,
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
      // if (kDebugMode) {
      //   print('responseJson $responseJson');
      //   print('form data $formData');
      // }
      userModel = UserModel.fromJson(responseJson);
      emit(AppEditProfileSuccessState(userModel!));
      getProfileData();
    } catch (e) {
      emit(AppEditProfileErrorState(e.toString()));
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future addHomeReservation({
    required String name,
    required String phone,
    required String testName,
    required String address,
    required String dateOfVisit,
    required String time,
  }) async {
    var headers = {
      'Accept': 'application/json',
      'lang': local,
      'Authorization': 'Bearer $token',
    };
    var formData = FormData.fromMap({
      'name': name,
      'phone': phone,
      'test_name': testName,
      'Address': address,
      'date': dateOfVisit,
      'time': time,
    });

    try {
      emit(AppHomeReservationsLoadingState());
      Dio dio = Dio();
      var response = await dio.post(
        homeReservationURL,
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
      homeReservationsModel = HomeReservationsModel.fromJson(responseJson);
      emit(AppHomeReservationsSuccessState(homeReservationsModel!));
      getReservationsData();
    } catch (e) {
      emit(AppHomeReservationsErrorState(e.toString()));
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future sendContactUs({
    required String serviceName,
    required String email,
    required String phone,
    required String message,
  }) async {
    var headers = {
      'Accept': 'application/json',
      'lang': local,
      'Authorization': 'Bearer $token',
    };
    var formData = FormData.fromMap({
      'type': serviceName,
      'phone': phone,
      'email': email,
      'message': message,
    });

    try {
      emit(AppSendMessageLoadingState());
      Dio dio = Dio();
      var response = await dio.post(
        contactURL,
        data: formData,
        options: Options(
          followRedirects: false,
          responseType: ResponseType.bytes,
          validateStatus: (status) => true,
          headers: headers,
        ),
      );
      emit(AppSendMessageSuccessState());
    } catch (e) {
      emit(AppSendMessageErrorState(e.toString()));
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future addLabReservation({
    required String serviceName,
    required String name,
    required String phone,
    required String appointmentId,
    required String date,
    required String time,
  }) async {
    var headers = {
      'Accept': 'application/json',
      'lang': local,
      'Authorization': 'Bearer $token',
    };
    var formData = FormData.fromMap({
      'test_name': serviceName,
      'phone': phone,
      'name': name,
      'appointment_id': appointmentId,
      'date': date,
      'time': time,
    });

    try {
      emit(AppLabReservationsLoadingState());
      Dio dio = Dio();
      var response = await dio.post(
        labReservationUrl,
        data: formData,
        options: Options(
          followRedirects: false,
          responseType: ResponseType.bytes,
          validateStatus: (status) => true,
          headers: headers,
        ),
      );
      emit(AppLabReservationsSuccessState());
      getReservationsData();
    } catch (e) {
      emit(AppLabReservationsErrorState(e.toString()));
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future getUserResults({
    String? date,
    String? name,
  }) async {
    var headers = {
      'Accept': 'application/json',
      'lang': local,
      'Authorization': 'Bearer $token',
    };
    var formData = json.encode({
      'date': date,
      'test_name': name,
    });

    try {
      emit(AppGetUserResultsLoadingState());
      Dio dio = Dio();
      var response = await dio.post(
        getAllResultsURL,
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
      searchModel = SearchModel.fromJson(responseJson);
      emit(AppGetUserResultsSuccessState(searchModel!));
    } catch (e) {
      emit(AppGetUserResultsErrorState(e.toString()));
      if (kDebugMode) {
        print('error from getting users results : ${e.toString()}');
      }
    }
  }

  Future getProfileData() async {
    emit(AppGetProfileLoadingState());
    var headers = {
      'Accept': 'application/json',
      'lang': local,
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
      // var user = userdata?.data;
      // if (kDebugMode) {
      //   print('user data name is : ${user?.name}');
      //   print(getProfileURL);
      //   print(responseJson);
      // }
      emit(AppGetProfileSuccessState());
    } catch (error) {
      if (kDebugMode) {
        print('error ${error.toString()}');
      }
      emit(AppGetProfileErrorState(error.toString()));
    }
  }

  Future getAppointmentsData() async {
    emit(AppGetAppointmentsLoadingState());
    var headers = {
      'Accept': 'application/json',
      'lang': local,
      'Authorization': 'Bearer $token',
    };
    try {
      Dio dio = Dio();
      var response = await dio.get(
        getAppointmentsURL,
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
      appointmentsModel = AppointmentsModel.fromJson(responseJson);
      if (kDebugMode) {
        print(
            'appointmentsModel?.data?.length : ${appointmentsModel?.data?.length}');
      }
      emit(AppGetAppointmentsSuccessState(appointmentsModel!));
    } catch (error) {
      if (kDebugMode) {
        print('error ${error.toString()}');
      }
      emit(AppGetAppointmentsErrorState(error.toString()));
    }
  }

  Future getTestNameData() async {
    var headers = {
      'Accept': 'application/json',
      'lang': local,
      'Authorization': 'Bearer $token',
    };
    emit(AppGetTestNameLoadingState());
    try {
      Dio dio = Dio();
      var response = await dio.get(
        getTestNamesURL,
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
      testNameModel = TestNameModel.fromJson(responseJson);
      testNames = testNameModel?.data;
      for (var i = 0; i < testNames!.length; i++) {
        testName.add(testNames?[i].name);
      }
      if (kDebugMode) {
        print ('testNames : $testName');
        // print('responseJson $responseJson');
      }
      emit(AppGetTestNameSuccessState(testNameModel!));
    } catch (error) {
      if (kDebugMode) {
        print('error ${error.toString()}');
      }
      emit(AppGetTestNameErrorState(error.toString()));
    }
    // emit(AppGetTestNameLoadingState());
    // var request = http.Request('GET',Uri.parse(getTestNamesURL));
    // request.headers.addAll(headers);
    // http.StreamedResponse response = await request.send();

    // try {
    //   final http.Response response = await http.get(Uri.parse(getTestNamesURL), headers: headers);
    //   print('jsonDecode ${jsonDecode(response.body)}');
    //   print(getTestNamesURL);
    //   print(response.statusCode);
    //   // var responseString = await response.stream.bytesToString();
    //   // dynamic responseMap = json.decode(responseString);
    //   // print('responseMap $responseMap');
    //   // testNameModel = TestNameModel.fromJson(responseMap);
    //   emit(AppGetTestNameSuccessState(testNameModel!));
    // }catch (e) {
    //   emit(AppGetTestNameErrorState(e.toString()));
    // }
  }

  Future getOffersData() async {
    emit(AppGetOffersLoadingState());
    var headers = {
      'Accept': 'application/json',
      'lang': local,
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
        print('offersModel?.data ${offersModel?.data?[0]}');
      }
      emit(AppGetOffersSuccessState(offersModel!));
    } catch (error) {
      if (kDebugMode) {
        print('error ${error.toString()}');
      }
      emit(AppGetOffersErrorState(error.toString()));
    }
  }

  Future getHomeOffersData() async {
    emit(AppGetHomeOffersLoadingState());
    var headers = {
      'Accept': 'application/json',
      'lang': local,
      'Authorization': 'Bearer $token',
    };
    try {
      Dio dio = Dio();
      var response = await dio.get(
        getHomeOfferURL,
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
      homeOffersModel = OffersModel.fromJson(responseJson);
      emit(AppGetHomeOffersSuccessState(homeOffersModel!));
    } catch (error) {
      if (kDebugMode) {
        print('error ${error.toString()}');
      }
      emit(AppGetHomeOffersErrorState(error.toString()));
    }
  }

  Future getLabOffersData() async {
    emit(AppGetLabOffersLoadingState());
    var headers = {
      'Accept': 'application/json',
      'lang': local,
      'Authorization': 'Bearer $token',
    };
    try {
      Dio dio = Dio();
      var response = await dio.get(
        getLabOfferURL,
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
      labOffersModel = OffersModel.fromJson(responseJson);
      emit(AppGetLabOffersSuccessState(labOffersModel!));
    } catch (error) {
      if (kDebugMode) {
        print('error ${error.toString()}');
      }
      emit(AppGetLabOffersErrorState(error.toString()));
    }
  }

  Future getReservationsData() async {
    emit(AppGetReservationsLoadingState());
    var headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      'lang': local,
      'Authorization': 'Bearer $token',
    };
    try {
      Dio dio = Dio();
      var response = await dio.get(
        userReservationUrl,
        options: Options(
          followRedirects: false,
          responseType: ResponseType.bytes,
          validateStatus: (status) => true,
          headers: headers,
        ),
      );
      // print('ReservationsModel $response');
      var responseJsonB = response.data;
      var convertedResponse = utf8.decode(responseJsonB);
      var responseJson = json.decode(convertedResponse);
      reservationModel = ReservationsModel.fromJson(responseJson);
      emit(AppGetReservationsSuccessState(reservationModel!));
    } catch (error) {
      if (kDebugMode) {
        print('error ${error.toString()}');
      }
      emit(AppGetReservationsErrorState(error.toString()));
    }
  }

  Future getTestsData() async {
    emit(AppGetTestsLoadingState());
    var headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      'lang': local,
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
      emit(AppGetTestsSuccessState(testsModel!));
    } catch (error) {
      if (kDebugMode) {
        print('error ${error.toString()}');
      }
      emit(AppGetTestsErrorState(error.toString()));
    }
  }

  Future getTestResultData({
    required int? reservationId,
  }) async {
    var headers = {
      'Accept': 'application/json',
      'lang': local,
      'Authorization': 'Bearer $token',
    };
    var formData = json.encode({
      'reservation_id': reservationId,
    });

    try {
      emit(AppGetTestResultLoadingState());
      Dio dio = Dio();
      var response = await dio.post(
        getTestResultURL,
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
      testResultModel = TestResultModel.fromJson(responseJson);
      emit(AppGetTestResultSuccessState(testResultModel!));
    } catch (e) {
      emit(AppGetTestResultErrorState(e.toString()));
      if (kDebugMode) {
        print(e.toString());
      }
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

  bool isLanguage = true;

  String local = 'en';

  dynamic changeLanguage() {
    isLanguage = !isLanguage;
    local = isLanguage ? local = 'en' : local = 'ar';
    getOffersData();
    getTestsData();
    getProfileData();
    getReservationsData();
    getTestNameData();
    getAppointmentsData();
    getLabOffersData();
    getHomeOffersData();
    emit(AppChangeLanguageState());
  }

  bool rememberMe = false;

  void onRememberMeChanged() {
    rememberMe = !rememberMe;
    if (rememberMe) {
    } else {}
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
          print(profileImage);
          print(Uri.file(profileImage!.path).pathSegments.last);
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

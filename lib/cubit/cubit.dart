// ignore_for_file: unused_local_variable
import 'dart:convert';
import 'dart:io';
import 'package:dar_altep/cubit/states.dart';
import 'package:dar_altep/models/appointments_model.dart';
import 'package:dar_altep/models/auth/check_code_model.dart';
import 'package:dar_altep/models/cancel_reservation_model.dart';
import 'package:dar_altep/models/change_email_model.dart';
import 'package:dar_altep/models/countriesModel.dart';
import 'package:dar_altep/models/delete_reservation_model.dart';
import 'package:dar_altep/models/change_password_model.dart';
import 'package:dar_altep/models/home_appointments_model.dart';
import 'package:dar_altep/models/home_reservation_model.dart';
import 'package:dar_altep/models/lab_reservation_model.dart';
import 'package:dar_altep/models/notification_model.dart';
import 'package:dar_altep/models/offers_model.dart';
import 'package:dar_altep/models/auth/user_model.dart';
import 'package:dar_altep/models/reservation_model.dart';
import 'package:dar_altep/models/search_model.dart';
import 'package:dar_altep/models/technicalModel.dart';
import 'package:dar_altep/models/test_name_model.dart';
import 'package:dar_altep/models/test_results_model.dart';
import 'package:dar_altep/models/tests_model.dart' as test;
import 'package:dar_altep/screens/auth/login_screen.dart';
import 'package:dar_altep/shared/components/general_components.dart';
import 'package:dar_altep/shared/network/local/cache_helper.dart';
import 'package:dar_altep/shared/network/local/const_shared.dart';
import 'package:dar_altep/shared/network/remote/end_points.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
// import 'package:http/http.dart' as http;

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialAppStates());

  static AppCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;
  VerificationModel? verificationModel;
  OffersModel? offersModel;
  OffersModel? homeOffersModel;
  OffersModel? labOffersModel;
  test.TestsModel? testsModel;
  CountriesModel? countriesModel;
  ReservationsModel? reservationModel;
  HomeReservationsModel? homeReservationsModel;
  TestResultModel? testResultModel;
  TestNameModel? testNameModel;
  SearchModel? searchModel;
  DeleteReservationModel? deleteReservationModel;
  CancelReservationModel? cancelReservationModel;
  AppointmentsModel? appointmentsModel;
  HomeAppointmentsModel? homeAppointmentsModel;
  LabReservationModel? labReservationModel;
  ChangePasswordModel? changePasswordModel;
  SendEmailModel? sendEmailModel;
  ResetPasswordModel? resetPasswordModel;
  NotificationsModel? notificationsModel;
  SeenNotificationsModel? seenNotificationsModel;
  DeleteNotificationsModel? deleteNotificationsModel;
  ConfirmPasswordModel? confirmPasswordModel;
  ResetEmailModel? resetEmailModel;
  SendNewEmailModel? sendNewEmailModel;
  TechnicalModel? technicalModel;
  RateTechnicalModel? rateTechnicalModel;

  // List<NotificationsDataModel>? unSeenNotifications = [];
  // List<int> unSeenNotification = [];

  List<CountriesModelData>? countriesNames = [];
  List<String> countriesName = [];
  List<test.Datum>? testModelData1;
  List<TestModelData>? testNames = [];
  List<String> testName = [];
  Map<String, String>? reservations;
  Map tests = {};

  IconData resetSufIcon = Icons.visibility_off_outlined;
  bool resetIsPassword = true;

  IconData sufIcon = Icons.visibility_off_outlined;
  bool isPassword = true;

  bool isLanguage = true;
  int offersCount = 1;

  String? userAddress;

  Future login({
    required String email,
    required String password,
    required String deviceTokenLogin,
  }) async {
    var headers = {
      'Accept': 'application/json',
      'lang': sharedLanguage,
    };
    var formData = json.encode({
      'email': email,
      'password': password,
      'device_token': deviceTokenLogin,
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
        print(responseJson);
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

  Future changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    var headers = {
      'Accept': 'application/json',
      'lang': sharedLanguage,
      'Authorization': 'Bearer $token',
    };
    var formData = json.encode({
      'oldPassword': oldPassword,
      'newPassword': newPassword,
    });

    try {
      emit(AppChangePasswordLoadingState());
      Dio dio = Dio();
      var response = await dio.post(
        changePasswordURL,
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
      changePasswordModel = ChangePasswordModel.fromJson(responseJson);
      emit(AppChangePasswordSuccessState(changePasswordModel!));
    } catch (e) {
      emit(AppChangePasswordErrorState());
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
    required String deviceTokenLogin,
  }) async {
    var headers = {
      'Accept': 'application/json',
      'lang': sharedLanguage,
    };
    var formData = json.encode({
      'name': name,
      'phone': phone,
      'email': email,
      'password': password,
      'birthrate': birthdate,
      'gender': gender,
      'nationality': nationality,
      'device_token': deviceTokenLogin,
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
        print('formData $formData');
        print(responseJson);
      }
      userModel = UserModel.fromJson(responseJson);
      if (kDebugMode) {
        print('userModel?.message : ${response.data}');
      }
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
      'lang': sharedLanguage,
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
      'lang': sharedLanguage,
      'Authorization': 'Bearer $token',
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
      var responseJsonB = response.data;
      var convertedResponse = utf8.decode(responseJsonB);
      var responseJson = json.decode(convertedResponse);
      cancelReservationModel = CancelReservationModel.fromJson(responseJson);
      if (!cancelReservationModel?.status) {
        showToast(
          msg: cancelReservationModel?.message.toString(),
          state: ToastState.error,
        );
        getReservationsData();
      } else {
        showToast(
          msg: cancelReservationModel?.message.toString(),
          state: ToastState.success,
        );
        getReservationsData();
      }
      emit(AppCancelReservationsSuccessState(cancelReservationModel!));
    } catch (e) {
      showToast(
        msg: cancelReservationModel?.message.toString(),
        state: ToastState.error,
      );
      getReservationsData();
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
      'lang': sharedLanguage,
      'Authorization': 'Bearer $token',
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
      var responseJsonB = response.data;
      var convertedResponse = utf8.decode(responseJsonB);
      var responseJson = json.decode(convertedResponse);
      deleteReservationModel = DeleteReservationModel.fromJson(responseJson);
      if (!deleteReservationModel?.status) {
        showToast(
          msg: deleteReservationModel?.message.toString(),
          state: ToastState.error,
        );
        getReservationsData();
      } else {
        showToast(
          msg: deleteReservationModel?.message.toString(),
          state: ToastState.success,
        );
        getReservationsData();
      }
      emit(AppDeleteReservationsSuccessState(deleteReservationModel!));
    } catch (e) {
      showToast(
        msg: deleteReservationModel?.message.toString(),
        state: ToastState.error,
      );
      getReservationsData();
      emit(AppDeleteReservationsErrorState(e.toString()));
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future sendEmail({
    required String? email,
  }) async {
    var headers = {
      'Accept': 'application/json',
      'lang': sharedLanguage,
      // 'Authorization': 'Bearer $token',
    };
    var formData = json.encode({
      'email': email,
    });

    try {
      emit(AppSendEmailLoadingState());
      Dio dio = Dio();
      var response = await dio.post(
        sendEmailURL,
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
      //   print('responseJson: $responseJson');
      //   print('formData: $formData');
      // }
      sendEmailModel = SendEmailModel.fromJson(responseJson);
      emit(AppSendEmailSuccessState(sendEmailModel!));
    } catch (e) {
      getReservationsData();
      emit(AppSendEmailErrorState(e.toString()));
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future resetPassword({
    required String code,
    required String email,
    required String newPassword,
  }) async {
    var headers = {
      'Accept': 'application/json',
      'lang': sharedLanguage,
      // 'Authorization': 'Bearer $token',
    };
    var formData = FormData.fromMap({
      'code': code,
      'email': email,
      'new_password': newPassword,
    });

    try {
      emit(AppResetPasswordLoadingState());
      Dio dio = Dio();
      var response = await dio.post(
        resetPasswordURL,
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
        print('responseJson : $responseJson');
      }
      resetPasswordModel = ResetPasswordModel.fromJson(responseJson);
      if (kDebugMode) {
        print('resetPasswordModel : $resetPasswordModel');
      }
      emit(AppResetPasswordSuccessState(resetPasswordModel!));
    } catch (e) {
      emit(AppResetPasswordErrorState(e.toString()));
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future confirmPassword({
    required String password,
  }) async {
    var headers = {
      'Accept': 'application/json',
      'lang': sharedLanguage,
      'Authorization': 'Bearer $token',
    };
    var formData = json.encode({
      'password': password,
    });

    try {
      emit(AppConfirmPasswordLoadingState());
      Dio dio = Dio();
      var response = await dio.post(
        confirmPasswordURL,
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
      confirmPasswordModel = ConfirmPasswordModel.fromJson(responseJson);
      emit(AppConfirmPasswordSuccessState(confirmPasswordModel!));
    } catch (e) {
      emit(AppConfirmPasswordErrorState());
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future sendNewEmail({
    required String? newEmail,
  }) async {
    var headers = {
      'Accept': 'application/json',
      'lang': sharedLanguage,
      'Authorization': 'Bearer $token',
    };
    var formData = json.encode({
      'new_email': newEmail,
    });

    try {
      emit(AppSendNewEmailLoadingState());
      Dio dio = Dio();
      var response = await dio.post(
        sendNewEmailURL,
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
        print('responseJson sendNewEmailModel : $responseJson');
      }
      if (kDebugMode) {
        print(formData);
        print('response : $response');
      }
      sendNewEmailModel = SendNewEmailModel.fromJson(responseJson);
      if (kDebugMode) {
        print('sendNewEmailModel : $sendNewEmailModel');
      }
      emit(AppSendNewEmailSuccessState(sendNewEmailModel!));
    } catch (e) {
      getReservationsData();
      emit(AppSendNewEmailErrorState(e.toString()));
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future resetEmail({
    required String code,
    required String email,
  }) async {
    var headers = {
      'Accept': 'application/json',
      'lang': sharedLanguage,
      'Authorization': 'Bearer $token',
    };
    var formData = FormData.fromMap({
      'code': code,
      'email': email,
    });

    try {
      emit(AppResetEmailLoadingState());
      Dio dio = Dio();
      var response = await dio.post(
        resetEmailURL,
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
      resetEmailModel = ResetEmailModel.fromJson(responseJson);
      emit(AppResetEmailSuccessState(resetEmailModel!));
    } catch (e) {
      emit(AppResetEmailErrorState(e.toString()));
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
    required String nationality,
    required String birthdate,
    required String gender,
  }) async {
    var headers = {
      'Accept': 'application/json',
      'lang': sharedLanguage,
      'Authorization': 'Bearer $token',
    };
    var formData = FormData.fromMap({
      'name': name,
      'phone': phone,
      'email': email,
      'birthrate': birthdate,
      'gender': gender,
      'nationality': nationality,
      'ID_image': profileImage == null
          ? userModel?.data?.idImage
          : await MultipartFile.fromFile(
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

  File? homeVisitImage;
  var picker = ImagePicker();

  Future<void> getHomeVisitImage({bool isCamera = false}) async {
    try {
      XFile? pickedImage;
      if (isCamera == true) {
        pickedImage = await picker.pickImage(source: ImageSource.camera);
      } else {
        pickedImage = await picker.pickImage(source: ImageSource.gallery);
      }
      if (pickedImage != null) {
        // homeVisitImage = File(pickedImage.path);
        homeVisitImage = await compressImage(path: pickedImage.path, quality: 35);

        if (kDebugMode) {
          print(homeVisitImage);
          print(Uri.file(homeVisitImage!.path).pathSegments.last);
        }
        emit(AppHomeVisitImagePickedSuccessState());
      } else {
        if (kDebugMode) {
          print('no image selected');
          print(homeVisitImage);
        }
        emit(AppHomeVisitImagePickedErrorState());
      }
    } catch (e) {
      if (kDebugMode) {
        print('no');
        print(homeVisitImage);
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
    required String image,
    required double lat,
    required double long,
  }) async {
    var headers = {
      'Accept': 'application/json',
      'lang': sharedLanguage,
      'Authorization': 'Bearer $token',
    };
    var formData = FormData.fromMap({
      'name': name,
      'phone': phone,
      'test_name': testName,
      'Address': address,
      'date': dateOfVisit,
      'timing': time,
      'lat': lat,
      'long': long,
      'image': homeVisitImage == null
          ? ''
          : await MultipartFile.fromFile(
              homeVisitImage!.path,
              filename: image,
            ),
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
      if (kDebugMode) {
        print('formData homeReservationsModel ${formData.fields}');
      }
      var responseJsonB = response.data;
      var convertedResponse = utf8.decode(responseJsonB);
      var responseJson = json.decode(convertedResponse);
      if (kDebugMode) {
        print('responseJson homeReservationsModel $responseJson');
      }
      homeReservationsModel = HomeReservationsModel.fromJson(responseJson);
      if (kDebugMode) {
        print(
            'homeReservationsModel?.data?.image : ${homeReservationsModel?.data?.image}');
      }
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
      'lang': sharedLanguage,
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

  File? labVisitImage;

  Future<void> getLabVisitImage({bool isCamera = false}) async {
    try {
      XFile? pickedImage;
      if (isCamera == true) {
        pickedImage = await picker.pickImage(source: ImageSource.camera);
      } else {
        pickedImage = await picker.pickImage(source: ImageSource.gallery);
      }
      if (pickedImage != null) {
        // labVisitImage = File(pickedImage.path);
        labVisitImage = await compressImage(path: pickedImage.path, quality: 35);

        if (kDebugMode) {
          print(labVisitImage);
          print(Uri.file(labVisitImage!.path).pathSegments.last);
        }
        emit(AppLabVisitImagePickedSuccessState());
      } else {
        if (kDebugMode) {
          print('no image selected');
          print(labVisitImage);
        }
        emit(AppLabVisitImagePickedErrorState());
      }
    } catch (e) {
      if (kDebugMode) {
        print('no');
        print(labVisitImage);
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
    required String image,
  }) async {
    var headers = {
      'Accept': 'application/json',
      'lang': sharedLanguage,
      'Authorization': 'Bearer $token',
    };
    var formData = FormData.fromMap({
      'test_name': serviceName,
      'phone': phone,
      'name': name,
      'appointment_id': appointmentId,
      'date': date,
      'time': time,
      'image': labVisitImage == null
          ? ''
          : await MultipartFile.fromFile(
              labVisitImage!.path,
              filename: image,
            )
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
      if (kDebugMode) {
        print(formData.fields);
      }
      var responseJsonB = response.data;
      var convertedResponse = utf8.decode(responseJsonB);
      var responseJson = json.decode(convertedResponse);
      if (kDebugMode) {
        print(responseJson);
      }
      labReservationModel = LabReservationModel.fromJson(responseJson);
      if (kDebugMode) {
        print(
            'labReservationModel?.data?.image : ${labReservationModel?.data?.image}');
      }
      emit(AppLabReservationsSuccessState(labReservationModel!));
      getReservationsData();
    } catch (e) {
      emit(AppLabReservationsErrorState(e.toString()));
      if (kDebugMode) {
        print('dddddd');
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
      'lang': sharedLanguage,
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
      'lang': sharedLanguage,
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
      if (kDebugMode) {
        print('get profile : $responseJson');
      }
      userModel = UserModel.fromJson(responseJson);
      emit(AppGetProfileSuccessState());
    } catch (error) {
      if (kDebugMode) {
        print('error ${error.toString()}');
      }
      emit(AppGetProfileErrorState(error.toString()));
    }
  }

  Future getTechnicalProfileData({
    required String technicalId,
  }) async {
    emit(AppGetTechnicalProfileLoadingState());
    var headers = {
      'Accept': 'application/json',
      'lang': sharedLanguage,
      'Authorization': 'Bearer $token',
    };
    var formData = json.encode({
      'tech_id': technicalId,
    });
    try {
      Dio dio = Dio();
      var response = await dio.post(
        getTechnicalProfileURL,
        options: Options(
          followRedirects: false,
          responseType: ResponseType.bytes,
          validateStatus: (status) => true,
          headers: headers,
        ),
        data: formData,
      );
      var responseJsonB = response.data;
      var convertedResponse = utf8.decode(responseJsonB);
      var responseJson = json.decode(convertedResponse);
      if (kDebugMode) {
        print('formData: $formData');
        print('getTechnicalProfileURL: $getTechnicalProfileURL');
        print('get technicalModel : $responseJson');
      }
      technicalModel = TechnicalModel.fromJson(responseJson);
      emit(AppGetTechnicalProfileSuccessState(technicalModel!));
    } catch (error) {
      if (kDebugMode) {
        print('error ${error.toString()}');
      }
      emit(AppGetTechnicalProfileErrorState(error.toString()));
    }
  }

  Future rateTechnicalProfileData({
    required String technicalId,
    required String reservationId,
    required double rate,
    required String message,
  }) async {
    emit(AppRateTechnicalProfileLoadingState());
    var headers = {
      'Accept': 'application/json',
      'lang': sharedLanguage,
      'Authorization': 'Bearer $token',
    };
    var formData = json.encode({
      'tech_id': technicalId,
      'rate': rate,
      'message': message,
      'reservation_id': reservationId,
    });
    try {
      Dio dio = Dio();
      var response = await dio.post(
        rateTechnicalProfileURL,
        options: Options(
          followRedirects: false,
          responseType: ResponseType.bytes,
          validateStatus: (status) => true,
          headers: headers,
        ),
        data: formData,
      );
      var responseJsonB = response.data;
      var convertedResponse = utf8.decode(responseJsonB);
      var responseJson = json.decode(convertedResponse);
      if (kDebugMode) {
        print('formData: $formData');
        print('rateTechnicalProfileURL: $rateTechnicalProfileURL');
        print('rate technicalModel : $responseJson');
      }
      rateTechnicalModel = RateTechnicalModel.fromJson(responseJson);
      emit(AppRateTechnicalProfileSuccessState(rateTechnicalModel!));
    } catch (error) {
      if (kDebugMode) {
        print('error ${error.toString()}');
      }
      emit(AppRateTechnicalProfileErrorState(error.toString()));
    }
  }

  Future getNotifications() async {
    emit(AppGetNotificationsLoadingState());
    var headers = {
      'Accept': 'application/json',
      'lang': sharedLanguage,
      'Authorization': 'Bearer $token',
    };
    try {
      Dio dio = Dio();
      var response = await dio.get(
        userNotificationsURL,
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
        print(headers.entries);
        print('responseJson : $responseJson');
      }
      notificationsModel = NotificationsModel.fromJson(responseJson);
      emit(AppGetNotificationsSuccessState(notificationsModel!));
    } catch (error) {
      if (kDebugMode) {
        print('error ${error.toString()}');
      }
      emit(AppGetNotificationsErrorState(error.toString()));
    }
  }

  Future notificationSeen() async {
    var headers = {
      'Accept': 'application/json',
      'lang': sharedLanguage,
      'Authorization': 'Bearer $token',
    };
    var formData = FormData.fromMap({
      'seen': 1,
    });
    try {
      emit(AppSeenNotificationsLoadingState());
      Dio dio = Dio();
      var response = await dio.post(
        notificationSeenURL,
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
      seenNotificationsModel = SeenNotificationsModel.fromJson(responseJson);
      emit(AppSeenNotificationsSuccessState(seenNotificationsModel!));
    } catch (e) {
      emit(AppSeenNotificationsErrorState(e.toString()));
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future deleteNotifications() async {
    emit(AppDeleteNotificationsLoadingState());
    var headers = {
      'Accept': 'application/json',
      'lang': sharedLanguage,
      'Authorization': 'Bearer $token',
    };
    try {
      Dio dio = Dio();
      var response = await dio.post(
        deleteNotificationURL,
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
      deleteNotificationsModel =
          DeleteNotificationsModel.fromJson(responseJson);
      if (kDebugMode) {
        print(
            'deleteNotificationsModel: ${deleteNotificationsModel?.message.toString()}');
      }
      emit(AppDeleteNotificationsSuccessState(deleteNotificationsModel!));
    } catch (error) {
      if (kDebugMode) {
        print('error ${error.toString()}');
      }
      emit(AppDeleteNotificationsErrorState(error.toString()));
    }
  }

  Future getLabAppointmentsData({
    String? date,
  }) async {
    emit(AppGetLabAppointmentsLoadingState());
    var headers = {
      'Accept': 'application/json',
      'lang': sharedLanguage,
      'Authorization': 'Bearer $token',
    };
    var formData = json.encode({
      'date': date,
    });
    try {
      Dio dio = Dio();
      var response = await dio.post(
        getAppointmentsURL,
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
        print(responseJson);
      }
      appointmentsModel = AppointmentsModel.fromJson(responseJson);
      emit(AppGetLabAppointmentsSuccessState(appointmentsModel!));
    } catch (error) {
      if (kDebugMode) {
        appointmentsModel = null;
        print('error ${error.toString()}');
      }
      emit(AppGetLabAppointmentsErrorState(error.toString()));
    }
  }

  Future getHomeAppointmentsData({
    String? date,
  }) async {
    emit(AppGetHomeAppointmentsLoadingState());
    var headers = {
      'Accept': 'application/json',
      'lang': sharedLanguage,
      'Authorization': 'Bearer $token',
    };
    var formData = json.encode({
      'date': date,
    });
    try {
      Dio dio = Dio();
      var response = await dio.post(
        getHomeAppointmentsURL,
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
        print('homeAppointmentsModel response : ${response.statusCode}');
        print('responseJson homeAppointmentsModel: $responseJson');
      }
      homeAppointmentsModel = HomeAppointmentsModel.fromJson(responseJson);
      if (kDebugMode) {
        print('homeAppointmentsModel: $homeAppointmentsModel');
      }
      emit(AppGetHomeAppointmentsSuccessState(homeAppointmentsModel!));
    } catch (error) {
      if (kDebugMode) {
        homeAppointmentsModel = null;
        print('error ${error.toString()}');
      }
      emit(AppGetHomeAppointmentsErrorState(error.toString()));
    }
  }

  Future getTestNameData() async {
    var headers = {
      'Accept': 'application/json',
      'lang': sharedLanguage,
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
      print(responseJson);
      testNames = testNameModel?.data;
      for (var i = 0; i < testNames!.length; i++) {
        testName.add(testNames?[i].name);
      }
      // if (kDebugMode) {
      //   print('testNames : $testName');
      //   // print('responseJson $responseJson');
      // }
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
      'lang': sharedLanguage,
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
      // if (kDebugMode) {
      //   print(getOffersURL);
      //   print(responseJson);
      //   print('offersModel?.data.length ${offersModel?.data?.length}');
      //   print('offersModel?.data ${offersModel?.data?[0]}');
      // }
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
      'lang': sharedLanguage,
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
      'lang': sharedLanguage,
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
      "Accept": "application/json",
      'lang': sharedLanguage,
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
      var responseJsonB = response.data;
      var convertedResponse = utf8.decode(responseJsonB);
      var responseJson = json.decode(convertedResponse);
      reservationModel = null;
      if (kDebugMode) {
        print(responseJson);
      }
      reservationModel = ReservationsModel.fromJson(responseJson);
      // if (kDebugMode) {
      //   print('reservationModel : ${reservationModel?.data}');
      // }
      // reservationModel?.data?.forEach((element) {
      //   reservations?.addAll({
      //     element.status : element.type
      //   });
      // });
      emit(AppGetReservationsSuccessState(reservationModel!));
    } catch (error) {
      if (kDebugMode) {
        print('error ${error.toString()}');
      }
      emit(AppGetReservationsErrorState(error.toString()));
    }
  }

  Future getTestsData({
    String? testName,
  }) async {
    emit(AppGetTestsLoadingState());
    var headers = {
      "Accept": "application/json",
      'lang': sharedLanguage,
      'Authorization': 'Bearer $token',
    };
    var formData = json.encode({
      'search': testName,
    });
    try {
      Dio dio = Dio();
      var response = await dio.post(
        getTestsURL,
        options: Options(
          followRedirects: false,
          responseType: ResponseType.bytes,
          validateStatus: (status) => true,
          headers: headers,
        ),
        data: formData,
      );
      if (kDebugMode) {
        print(headers.entries);
        print(formData);
      }
      var responseJsonB = response.data;
      var convertedResponse = utf8.decode(responseJsonB);
      var responseJson = json.decode(convertedResponse);
      if (kDebugMode) {
        print('testsModel $responseJson');
      }
      testsModel = test.TestsModel.fromJson(responseJson);
      emit(AppGetTestsSuccessState(testsModel!));
    } catch (error) {
      if (kDebugMode) {
        print('error ${error.toString()}');
      }
      emit(AppGetTestsErrorState(error.toString()));
    }
  }

  Future getCountriesData() async {
    emit(AppGetCountriesLoadingState());
    var headers = {
      "Content-Type": "application/json",
      'lang': sharedLanguage,
    };
    try {
      Dio dio = Dio();
      var response = await dio.get(
        countriesURL,
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
      countriesModel = CountriesModel.fromJson(responseJson);
      countriesNames = countriesModel?.data;
      for (var i = 0; i < countriesNames!.length; i++) {
        countriesName.add(countriesNames?[i].name);
      }
      // if (kDebugMode) {
      //   print(countriesModel?.data?.length);
      //   print('countriesName : $countriesName');
      // }
      emit(AppGetCountriesSuccessState(countriesModel!));
    } catch (error) {
      if (kDebugMode) {
        print('error ${error.toString()}');
      }
      emit(AppGetCountriesErrorState(error.toString()));
    }
  }

  Future getTestResultData({
    required int? reservationId,
  }) async {
    var headers = {
      'Accept': 'application/json',
      'lang': sharedLanguage,
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
      if (kDebugMode) {
        print('responseJson TestResultModel : $responseJson');
      }
      testResultModel = TestResultModel.fromJson(responseJson);
      // searchModel?.data?.checked?.forEach((element) {
      //   // if (kDebugMode) {
      //   //   print(element.id);
      //   // }
      // });
      emit(AppGetTestResultSuccessState(testResultModel!));
    } catch (e) {
      emit(AppGetTestResultErrorState(e.toString()));
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  void resetChangePasswordVisibility() {
    resetIsPassword = !resetIsPassword;
    resetSufIcon = resetIsPassword
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(AppResetChangePasswordVisibilityState());
  }

  void changePasswordVisibility() {
    isPassword = !isPassword;
    sufIcon =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(AppChangePasswordVisibilityState());
  }

  String local = 'en';

  dynamic changeLanguage() {
    isLanguage = !isLanguage;
    local = isLanguage ? local = 'en' : local = 'ar';
    testName = [];
    sharedLanguage = local;
    getOffersData();
    getTestsData();
    getProfileData();
    getReservationsData();
    getTestNameData();
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
          LoginScreen(),
        );
      }
      emit(AppLogoutSuccessState());
    });
  }

  File? profileImage;

  Future<void> getProfileImage() async {
    try {
      XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        profileImage = File(pickedImage.path);
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

Future<File> compressImage({required String path,required int quality}) async {
  final newPath = p.join((await getTemporaryDirectory()).path,p.extension(path));
  final compressedImage = await FlutterImageCompress.compressAndGetFile(
    path,
    newPath,
    quality: quality,
  );
  return compressedImage!;
}

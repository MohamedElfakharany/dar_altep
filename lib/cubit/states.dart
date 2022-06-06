import 'package:dar_altep/models/appointments_model.dart';
import 'package:dar_altep/models/auth/check_code_model.dart';
import 'package:dar_altep/models/cancel_reservation_model.dart';
import 'package:dar_altep/models/delete_reservation_model.dart';
import 'package:dar_altep/models/change_password_model.dart';
import 'package:dar_altep/models/home_reservation_model.dart';
import 'package:dar_altep/models/lab_reservation_model.dart';
import 'package:dar_altep/models/notification_model.dart';
import 'package:dar_altep/models/offers_model.dart';
import 'package:dar_altep/models/auth/user_model.dart';
import 'package:dar_altep/models/reservation_model.dart';
import 'package:dar_altep/models/search_model.dart';
import 'package:dar_altep/models/test_name_model.dart';
import 'package:dar_altep/models/test_results_model.dart';
import 'package:dar_altep/models/tests_model.dart';

abstract class AppStates{}

class InitialAppStates extends AppStates{}

class AppChangePasswordVisibilityState extends AppStates{}

class AppChangeRememberMeState extends AppStates{}

class AppChangeLanguageState extends AppStates{}

class AppLoginLoadingState extends AppStates{}

class AppLoginSuccessState extends AppStates{
  final UserModel userModel;
  AppLoginSuccessState(this.userModel);
}

class AppLoginErrorState extends AppStates{
  final String error;
  AppLoginErrorState(this.error);
}

class AppChangePasswordLoadingState extends AppStates{}

class AppChangePasswordSuccessState extends AppStates{
  final ChangePasswordModel changePasswordModel;
  AppChangePasswordSuccessState(this.changePasswordModel);
}

class AppChangePasswordErrorState extends AppStates{}


class AppGetUserResultsLoadingState extends AppStates{}

class AppGetUserResultsSuccessState extends AppStates{
  final SearchModel searchModel;
  AppGetUserResultsSuccessState(this.searchModel);
}

class AppGetUserResultsErrorState extends AppStates{
  final String error;
  AppGetUserResultsErrorState(this.error);
}

class AppRegisterLoadingState extends AppStates{}

class AppRegisterSuccessState extends AppStates{
  final UserModel userModel;
  AppRegisterSuccessState(this.userModel);
}

class AppRegisterErrorState extends AppStates{
  final String error;
  AppRegisterErrorState(this.error);
}

class AppVerificationLoadingState extends AppStates{}

class AppVerificationSuccessState extends AppStates{
  final VerificationModel verificationModel;
  AppVerificationSuccessState(this.verificationModel);
}

class AppVerificationErrorState extends AppStates{
  final String error;
  AppVerificationErrorState(this.error);
}

class AppLogoutSuccessState extends AppStates{}

class AppProfileImagePickedSuccessState extends AppStates{}

class AppProfileImagePickedErrorState extends AppStates{}

class AppHomeVisitImagePickedSuccessState extends AppStates{}

class AppHomeVisitImagePickedErrorState extends AppStates{}

class AppLabVisitImagePickedSuccessState extends AppStates{}

class AppLabVisitImagePickedErrorState extends AppStates{}


class AppGetOffersLoadingState extends AppStates{}

class AppGetOffersSuccessState extends AppStates{
  final OffersModel offersModel;
  AppGetOffersSuccessState(this.offersModel);
}

class AppGetOffersErrorState extends AppStates{
  final String error;
  AppGetOffersErrorState(this.error);
}

class AppGetHomeOffersLoadingState extends AppStates{}
class AppGetHomeOffersSuccessState extends AppStates{
  final OffersModel homeOffersModel;
  AppGetHomeOffersSuccessState(this.homeOffersModel);
}
class AppGetHomeOffersErrorState extends AppStates{
  final String error;
  AppGetHomeOffersErrorState(this.error);
}

class AppGetLabOffersLoadingState extends AppStates{}

class AppGetLabOffersSuccessState extends AppStates{
  final OffersModel labOffersModel;
  AppGetLabOffersSuccessState(this.labOffersModel);
}

class AppGetLabOffersErrorState extends AppStates{
  final String error;
  AppGetLabOffersErrorState(this.error);
}

class AppGetReservationsLoadingState extends AppStates{}

class AppGetReservationsSuccessState extends AppStates{
  final ReservationsModel reservationModel;
  AppGetReservationsSuccessState(this.reservationModel);
}

class AppGetReservationsErrorState extends AppStates{
  final String error;
  AppGetReservationsErrorState(this.error);
}

class AppGetTestsLoadingState extends AppStates{}

class AppGetTestsSuccessState extends AppStates{
  final TestsModel testsModel;
  AppGetTestsSuccessState(this.testsModel);
}

class AppGetTestsErrorState extends AppStates{
  final String error;
  AppGetTestsErrorState(this.error);
}

class AppGetTestResultLoadingState extends AppStates{}

class AppGetTestResultSuccessState extends AppStates{
  final TestResultModel testResultModel;
  AppGetTestResultSuccessState(this.testResultModel);
}

class AppGetTestResultErrorState extends AppStates{
  final String error;
  AppGetTestResultErrorState(this.error);
}

class AppEditProfileLoadingState extends AppStates{}

class AppEditProfileSuccessState extends AppStates{
  final UserModel userModel;
  AppEditProfileSuccessState(this.userModel);
}

class AppEditProfileErrorState extends AppStates{
  final String error;
  AppEditProfileErrorState(this.error);
}

class AppHomeReservationsLoadingState extends AppStates{}

class AppHomeReservationsSuccessState extends AppStates{
  final HomeReservationsModel homeReservationsModel;
  AppHomeReservationsSuccessState(this.homeReservationsModel);
}

class AppHomeReservationsErrorState extends AppStates{
  final String error;
  AppHomeReservationsErrorState(this.error);
}

class AppSendMessageLoadingState extends AppStates{}

class AppSendMessageSuccessState extends AppStates{}

class AppSendMessageErrorState extends AppStates{
  final String error;
  AppSendMessageErrorState(this.error);
}

class AppLabReservationsLoadingState extends AppStates{}

class AppLabReservationsSuccessState extends AppStates{
  final LabReservationModel labReservationModel;
  AppLabReservationsSuccessState(this.labReservationModel);
}

class AppLabReservationsErrorState extends AppStates{
  final String error;
  AppLabReservationsErrorState(this.error);
}

class AppCancelReservationsLoadingState extends AppStates{}

class AppCancelReservationsSuccessState extends AppStates{
  final CancelReservationModel cancelReservationModel;
  AppCancelReservationsSuccessState(this.cancelReservationModel);
}

class AppCancelReservationsErrorState extends AppStates{
  final String error;
  AppCancelReservationsErrorState(this.error);
}

class AppSendEmailLoadingState extends AppStates{}

class AppSendEmailSuccessState extends AppStates{
  final SendEmailModel sendEmailModel;
  AppSendEmailSuccessState(this.sendEmailModel);
}

class AppSendEmailErrorState extends AppStates{
  final String error;
  AppSendEmailErrorState(this.error);
}

class AppResetPasswordLoadingState extends AppStates{}

class AppResetPasswordSuccessState extends AppStates{
  final ResetPasswordModel resetPasswordModel;
  AppResetPasswordSuccessState(this.resetPasswordModel);
}

class AppResetPasswordErrorState extends AppStates{
  final String error;
  AppResetPasswordErrorState(this.error);
}

class AppDeleteReservationsLoadingState extends AppStates{}

class AppDeleteReservationsSuccessState extends AppStates{
  final DeleteReservationModel deleteReservationModel;
  AppDeleteReservationsSuccessState(this.deleteReservationModel);
}

class AppDeleteReservationsErrorState extends AppStates{
  final String error;
  AppDeleteReservationsErrorState(this.error);
}

class AppGetProfileLoadingState extends AppStates{}

class AppGetProfileSuccessState extends AppStates{}

class AppGetProfileErrorState extends AppStates{
  final String error;
  AppGetProfileErrorState(this.error);
}

class AppGetNotificationsLoadingState extends AppStates{}

class AppGetNotificationsSuccessState extends AppStates{
  final NotificationsModel notificationsModel;
  AppGetNotificationsSuccessState(this.notificationsModel);
}

class AppGetNotificationsErrorState extends AppStates{
  final String error;
  AppGetNotificationsErrorState(this.error);
}

class AppDeleteNotificationsLoadingState extends AppStates{}

class AppDeleteNotificationsSuccessState extends AppStates{
  final DeleteNotificationsModel deleteNotificationsModel;
  AppDeleteNotificationsSuccessState(this.deleteNotificationsModel);
}

class AppDeleteNotificationsErrorState extends AppStates{
  final String error;
  AppDeleteNotificationsErrorState(this.error);
}

class AppGetAppointmentsLoadingState extends AppStates{}

class AppGetAppointmentsSuccessState extends AppStates{
  final AppointmentsModel appointmentsModel;
  AppGetAppointmentsSuccessState(this.appointmentsModel);
}

class AppGetAppointmentsErrorState extends AppStates{
  final String error;
  AppGetAppointmentsErrorState(this.error);
}

class AppGetTestNameLoadingState extends AppStates{}

class AppGetTestNameSuccessState extends AppStates{
  final TestNameModel testNameModel;
  AppGetTestNameSuccessState(this.testNameModel);
}

class AppGetTestNameErrorState extends AppStates{
  final String error;
  AppGetTestNameErrorState(this.error);
}

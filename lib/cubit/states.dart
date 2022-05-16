import 'package:dar_altep/models/auth/check_code_model.dart';
import 'package:dar_altep/models/auth/offers_model.dart';
import 'package:dar_altep/models/auth/user_model.dart';

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

class AppGetOffersLoadingState extends AppStates{}

class AppGetOffersSuccessState extends AppStates{
  final OffersModel offersModel;
  AppGetOffersSuccessState(this.offersModel);
}

class AppGetOffersErrorState extends AppStates{
  final String error;
  AppGetOffersErrorState(this.error);
}



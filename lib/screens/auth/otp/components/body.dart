import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dar_altep/cubit/cubit.dart';
import 'package:dar_altep/cubit/states.dart';
import 'package:dar_altep/screens/auth/login_screen.dart';
import 'package:dar_altep/screens/auth/otp/components/otp_form.dart';
import 'package:dar_altep/screens/auth/otp/otp_screen.dart';
import 'package:dar_altep/shared/components/general_components.dart';
import 'package:dar_altep/shared/constants/colors.dart';
import 'package:dar_altep/shared/constants/generalConstants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Body extends StatelessWidget {
  Body({
    Key? key,
    this.mobile,
    required this.verification,
  }) : super(key: key);
  final String? mobile;
  final String verification;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {
          if (state is AppVerificationSuccessState) {
            if (state.verificationModel.status) {
              Navigator.pushAndRemoveUntil(context, FadeRoute(page: LoginScreen()), (route) => false);
              OtpScreen(mobile: '',verification: '',);
            } else {
              if (kDebugMode) {
                print(state.verificationModel.message);
              }
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Error...!'),
                      content: Text('${state.verificationModel.message}'),
                    );
                  });
            }
          } else if (state is AppVerificationErrorState) {
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
        builder: (context,state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const OtpForm(),
                  verticalLargeSpace,
                  // buildTimer(),
                  verticalLargeSpace,
                  ConditionalBuilder(
                    condition: state is! AppVerificationLoadingState,
                    builder: (context) => GeneralButton(
                        title: 'Verify',
                        onPress: () {
                          AppCubit.get(context).verify(phone: mobile, verification: verification);
                        }),
                    fallback: (context) => const Center(child: CircularProgressIndicator()),
                  ),
                  verticalLargeSpace,
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("This code will expired in "),
        TweenAnimationBuilder(
          tween: Tween(begin: 60.0, end: 0.0),
          duration: const Duration(minutes: 1),
          builder: (_, dynamic value, child) => Text(
            "${value.toInt()}",
            style: const TextStyle(color: blueDark),
          ),
          onEnd: () {
            showToast(msg: 'time\'s up Resend Code', state: ToastState.warning);
          },
        ),
      ],
    );
  }
}

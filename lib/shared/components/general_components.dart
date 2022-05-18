// ignore_for_file: must_be_immutable, body_might_complete_normally_nullable

import 'package:dar_altep/shared/constants/colors.dart';
import 'package:dar_altep/shared/constants/generalConstants.dart';
import 'package:dar_altep/shared/network/local/const_shared.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      FadeRoute(page: widget),
      (Route<dynamic> route) => false,
    );

void showToast({
  required String? msg,
  required ToastState? state,
}) {
  Fluttertoast.showToast(
      msg: msg!,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 2,
      backgroundColor: chooseToastColor(state!),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum ToastState { success, error, warning }

Color chooseToastColor(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.success:
      color = Colors.green;
      break;
    case ToastState.warning:
      color = Colors.amber;
      break;
    case ToastState.error:
      color = Colors.red;
      break;
  }
  return color;
}

Widget myDivider() => Padding(
      padding: const EdgeInsets.only(left: 20, top: 8, bottom: 8, right: 20),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey,
      ),
    );

class GeneralButton extends StatelessWidget {
  double width;
  double height;
  double radius;
  double offSet;
  Color btnBackgroundColor;
  String title;
  Function onPress;
  double fontSize;

  GeneralButton({
    Key? key,
    this.width = double.infinity,
    this.height = 50,
    this.radius = 10,
    this.offSet = 15,
    this.fontSize = 18,
    this.btnBackgroundColor = blueDark,
    required this.title,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        onPress();
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          gradient: const LinearGradient(
            colors: [blueDark, blueLight],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          boxShadow: [
            BoxShadow(
              color: blueDark.withOpacity(0.25),
              spreadRadius: 5,
              blurRadius: 15,
              offset: const Offset(0, 15), // changes position of shadow
            ),
          ],
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: fontSize,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class GeneralUnfilledButton extends StatelessWidget {
  final String title;
  final String? image;
  final Color color;
  final Color borderColor;
  final Function onPress;
  final double width;
  final double height;
  final double btnRadius;
  final double borderWidth;

  const GeneralUnfilledButton({
    Key? key,
    required this.title,
    this.color = blueDark,
    this.borderColor = blueDark,
    required this.onPress,
    this.width = 50,
    this.height = 50,
    this.btnRadius = 15,
    this.borderWidth = 2,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        onPress();
      },
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(btnRadius),
          border: Border.all(color: borderColor, width: borderWidth),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(0, 2),
            ),
          ],
          color: whiteColor,
        ),
        child: Row(
          children: [
            if (image != null) horizontalSmallSpace,
            if (image != null)
              Image.asset(
                '$image',
                fit: BoxFit.cover,
                height: 30,
                width: 30,
              ),
            if (image != null)
              horizontalSmallSpace,
            if (image != null)
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 14,
                    color: color,
                  ),
                ),
              ),
            if (image == null)
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: color,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class GeneralAppBar extends StatelessWidget with PreferredSizeWidget {
  String title;
  double? leadingWidth;
  bool? centerTitle;
  Color? appBarColor;
  Widget? leading;
  List<Widget>? actions;

  double? appbarPreferredSize;
  Color? appbarBackButtonColor;

  GeneralAppBar(
      {Key? key,
      required this.title,
      this.leadingWidth,
      this.centerTitle,
      this.appBarColor,
      this.leading,
      this.actions,
      this.appbarPreferredSize = 60,
      this.appbarBackButtonColor = whiteColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/homeAppbarImage.png'),
            fit: BoxFit.cover,
          ),
        ),
        width: double.infinity,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: whiteColor,
          fontWeight: FontWeight.bold,
          fontFamily: fontFamily,
          fontSize: 20,
        ),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(appbarPreferredSize ?? kToolbarHeight);
}

class DefaultTextButton extends StatelessWidget {
  String title;
  Widget? screen;
  bool isFinish;
  AlignmentDirectional align;
  FontWeight? weight;

  DefaultTextButton(
      {Key? key,
      required this.title,
      this.weight = FontWeight.w400,
      this.screen,
      this.isFinish = false,
      this.align = AlignmentDirectional.centerEnd})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 20.0),
      child: Align(
        alignment: align,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: blueDark,
            fontFamily: fontFamily,
            fontWeight: weight,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}

class DefaultFormField extends StatelessWidget {
  TextEditingController controller;
  TextInputType type;
  Function? onSubmit;
  Function? onChange;
  dynamic onTap;
  bool obscureText = false;
  String label;
  Widget? prefixIcon;
  Function? prefixPressed;
  IconData? suffixIcon;
  Color suffixColor;
  Color prefixColor;
  Function? suffixPressed;
  bool isClickable = true;
  bool readOnly = false;
  bool autoFocus = false;
  bool removeBorder;
  double height;
  EdgeInsetsGeometry? contentPadding;
  String? validatedText;
  String? hintText;

  DefaultFormField(
      {Key? key,
      required this.controller,
      required this.type,
      required this.validatedText,
      this.onSubmit,
      this.onChange,
      this.onTap,
      this.hintText,
      this.removeBorder = true,
      this.obscureText = false,
      this.prefixColor = blueDark,
      required this.label,
      this.prefixIcon,
      this.prefixPressed,
      this.suffixIcon,
      this.suffixColor = blueDark,
      this.suffixPressed,
      this.isClickable = true,
      this.readOnly = false,
      this.contentPadding,
      this.height = 70,
      this.autoFocus = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      // height:  height,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 10,
              offset: const Offset(0, 10), // changes position of shadow
            ),
          ],
        ),
        alignment: AlignmentDirectional.center,
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
        child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'Fill $validatedText';
            }
          },
          autofocus: autoFocus,
          controller: controller,
          keyboardType: type,
          obscureText: obscureText,
          obscuringCharacter: '*',
          readOnly: readOnly,
          enabled: isClickable,
          onFieldSubmitted: (val) {
            onSubmit;
          },
          onChanged: (val) {
            onChange;
          },
          // onTap: onTap != null ? onTap() : () {},
          // validator: (val) {
          //   validate(val);
          // },
          onTap: () {
            onTap();
          },
          cursorColor: blueDark,
          decoration: InputDecoration(
            labelText: label,
            hintText: hintText,
            border: const OutlineInputBorder(
                // borderSide: BorderSide(
                //   width: 2,
                //   color: blueDark,
                // ),
                ),
            prefixIcon: prefixIcon != null
                ? IconButton(
                    icon: prefixIcon!,
                    onPressed: () {
                      prefixPressed;
                    },
                  )
                : null,
            suffixIcon: IconButton(
              onPressed: () {
                suffixPressed!();
              },
              icon: Icon(suffixIcon),
              color: blueDark,
            ),
            hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
            labelStyle: const TextStyle(
                // color: isClickable ? Colors.grey[400] : blueDark,
                color: darkColor,
                fontSize: 14),
            fillColor: Colors.white,
            filled: true,
            errorStyle: const TextStyle(color: Color(0xFF4F4F4F)),
            // floatingLabelBehavior: FloatingLabelBehavior.never,
            contentPadding:
                contentPadding ?? const EdgeInsets.only(left: 20, bottom: 15),
          ),
          style:
              TextStyle(color: blueLight, fontSize: 14, fontFamily: fontFamily),
        ),
      ),
    );
  }
}

final otpInputDecoration = InputDecoration(
  contentPadding: const EdgeInsets.symmetric(vertical: 15),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: const BorderSide(color: blueDark),
  );
}

class FadeRoute extends PageRouteBuilder {
  final Widget page;

  FadeRoute({
    required this.page,
  }) : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}

void showPopUp(BuildContext context, Widget widget) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: widget,
      contentPadding: const EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius))),
    ),
  );
}

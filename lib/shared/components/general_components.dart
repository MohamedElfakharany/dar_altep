// ignore_for_file: must_be_immutable, body_might_complete_normally_nullable, library_private_types_in_public_api

import 'package:dar_altep/cubit/cubit.dart';
import 'package:dar_altep/cubit/states.dart';
import 'package:dar_altep/shared/constants/colors.dart';
import 'package:dar_altep/shared/constants/general_constants.dart';
import 'package:dar_altep/shared/network/local/const_shared.dart';
import 'package:dar_altep/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:table_calendar/table_calendar.dart';

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
        color: Colors.grey.withOpacity(0.5),
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
            textAlign: TextAlign.center,
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
  final double titleSize;

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
    this.titleSize = 14,
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
            if (image != null) horizontalSmallSpace,
            if (image != null)
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: titleSize,
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
                    fontSize: titleSize,
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
        style: const TextStyle(
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
  bool expend;
  bool isConfirm = false;
  String? confirm;

  DefaultFormField({
    Key? key,
    required this.controller,
    required this.type,
    required this.validatedText,
    this.expend = false,
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
    this.autoFocus = false,
    this.isConfirm = false,
    this.confirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
          expands: expend,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Fill $validatedText';
            }
            if (isConfirm == true) {
              if (value != confirm &&
                  validatedText == LocaleKeys.TxtFieldReEnterPassword.tr()) {
                return LocaleKeys.txtPasswordsNotMatch.tr();
              } else if (value != confirm &&
                  validatedText == LocaleKeys.TxtFieldNewPassword.tr()) {
                return LocaleKeys.txtNewOldPasswordsNotMatch.tr();
              }
            }
            if (validatedText == LocaleKeys.txtFieldMobile.tr()) {
              if (value.length < 9) {
                return LocaleKeys.txtMobileLessNine.tr();
              }
            }
            if (validatedText == LocaleKeys.txtFieldPassword.tr() ||
                validatedText == LocaleKeys.TxtFieldNewPassword.tr() ||
                validatedText == LocaleKeys.TxtFieldReEnterPassword.tr() ||
                validatedText == LocaleKeys.TxtFieldOldPassword.tr()) {
              if (value.length < 8) {
                return LocaleKeys.txtPasswordValidate.tr();
              }
            }
          },
          autofocus: autoFocus,
          controller: controller,
          keyboardType: type,
          maxLines: obscureText ? 1 : null,
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
            contentPadding: contentPadding ??
                const EdgeInsetsDirectional.only(
                    start: 20.0, end: 10.0, bottom: 15.0),
          ),
          style:
              const TextStyle(color: blueLight, fontSize: 14, fontFamily: fontFamily),
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

// class DownloadImage extends StatefulWidget {
//   const DownloadImage({Key? key, required this.imageUrl}) : super(key: key);
//   final imageUrl;
//   @override
//   State<DownloadImage> createState() => _DownloadImageState();
// }
//
// class _DownloadImageState extends State<DownloadImage> {
//   final Dio dio = Dio();
//   bool loading = false;
//   double progress = 0;
//
//   Future<bool> saveVideo(String url, String fileName) async {
//     Directory? directory;
//     try {
//       if (Platform.isAndroid) {
//         if (await _requestPermission(Permission.storage)) {
//           directory = await getExternalStorageDirectory();
//           String newPath = "";
//           if (kDebugMode) {
//             print(directory);
//           }
//           List<String> paths = directory!.path.split("/");
//           for (int x = 1; x < paths.length; x++) {
//             String folder = paths[x];
//             if (folder != "Android") {
//               newPath += "/" + folder;
//             } else {
//               break;
//             }
//           }
//           newPath = newPath + "/DarAltepApp";
//           directory = Directory(newPath);
//         } else {
//           return false;
//         }
//       } else {
//         if (await _requestPermission(Permission.photos)) {
//           directory = await getTemporaryDirectory();
//         } else {
//           return false;
//         }
//       }
//       File saveFile = File(directory.path + "/$fileName");
//       if (!await directory.exists()) {
//         await directory.create(recursive: true);
//       }
//       if (await directory.exists()) {
//         await dio.download(url, saveFile.path,
//             onReceiveProgress: (value1, value2) {
//               setState(() {
//                 progress = value1 / value2;
//               });
//             });
//         if (Platform.isIOS) {
//           await GallerySaver.saveFile(saveFile.path);
//         }
//         return true;
//       }
//       return false;
//     } catch (e) {
//       if (kDebugMode) {
//         print(e);
//       }
//       return false;
//     }
//   }
//
//   Future<bool> _requestPermission(Permission permission) async {
//     if (await permission.isGranted) {
//       return true;
//     } else {
//       var result = await permission.request();
//       if (result == PermissionStatus.granted) {
//         return true;
//       }
//     }
//     return false;
//   }
//
//   downloadFile() async {
//     setState(() {
//       loading = true;
//       progress = 0;
//     });
//     bool downloaded = await saveVideo(
//         widget.imageUrl,
//         "DarAltep.jpeg");
//
//     if (downloaded) {
//       if (kDebugMode) {
//         print("File Downloaded");
//       }
//     } else {
//       if (kDebugMode) {
//         print("Problem Downloading File");
//       }
//     }
//     setState(() {
//       loading = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: loading
//           ? Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: LinearProgressIndicator(
//           minHeight: 10,
//           value: progress,
//         ),
//       ):GeneralButton(
//         title: 'Download',
//         radius: 8,
//         btnBackgroundColor: blueLight,
//         onPress: downloadFile,
//       ),
//     );
//   }
// }

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

void printWrapped(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) {
    if (kDebugMode) {
      print(match.group(0));
    }
  });
}

class ScreenHolder extends StatelessWidget {
  final String msg;

  const ScreenHolder(this.msg, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '${LocaleKeys.txtThereIsNo.tr()} $msg ${LocaleKeys.txtYet.tr()}',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline5?.copyWith(color: blueDark),
      ),
    );
  }
}

class CalenderView extends StatefulWidget {
  const CalenderView();

  @override
  _CalenderViewState createState() => _CalenderViewState();
}

class _CalenderViewState extends State<CalenderView> {
  // final DateTime _currentDay = DateTime.now();
  final DateTime _today = DateTime.now();
  DateTime? _selectedDay;

  var day;
  var month;

  final CalendarFormat _calendarFormat = CalendarFormat.month;

  // List<SessionModel> _getEventsForDay(DateTime day) {
  //   return [];
  // }
  // final bool _loadingData = true;
  // final bool _isCurrentMonthChanged = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context, state){
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4), color: whiteColor),
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 5, vertical: 10.0),
                  child: TableCalendar(
                    locale: sharedLanguage,
                    firstDay: kFirstDay,
                    lastDay: kLastDay,
                    focusedDay: _today,
                    calendarFormat: _calendarFormat,
                    startingDayOfWeek: StartingDayOfWeek.sunday,
                    daysOfWeekHeight: 30,
                    rowHeight: 40,
                    // eventLoader: _getEventsForDay,
                    // for badge under day
                    selectedDayPredicate: (day) {
                      // Use `selectedDayPredicate` to determine which day is currently selected.
                      // If this returns true, then `day` will be marked as selected.

                      // Using `isSameDay` is recommended to disregard
                      // the time-part of compared DateTime objects.
                      return isSameDay(_selectedDay, day);
                    },
                    onFormatChanged: (format) {
                      // if (_calendarFormat == CalendarFormat.month) {
                      //   setState(() {
                      //     _calendarFormat = CalendarFormat.twoWeeks;
                      //   });
                      // }
                      // else if ( _calendarFormat == CalendarFormat.twoWeeks){
                      //   setState(() {
                      //     _calendarFormat = CalendarFormat.week;
                      //   });
                      // }
                      // else if (_calendarFormat == CalendarFormat.week){
                      //   setState(() {
                      //     _calendarFormat = CalendarFormat.month;
                      //   });
                      // }
                    },

                    onCalendarCreated: (controller) {
                      // Provider.of<ShiftsProvider>(context,listen: false).fetchCalendarDaysWithOffers(context,startDate: widget.startDate,endDate: widget.endDate,historyType: widget.historyType);
                    },

                    onPageChanged: (DateTime day) {
                      // to save current page in Calendar when page changed .
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      if (!isSameDay(_selectedDay, selectedDay)) {
                        // Call `setState()` when updating the selected day
                        setState(() {
                          _selectedDay = selectedDay;
                        });
                      }
                      if(selectedDay.day <= 9){
                        day = '0${selectedDay.day}';
                      }else {
                        day = selectedDay.day;
                      }

                      if(selectedDay.month <= 9){
                        month = '0${selectedDay.month}';
                      }else {
                        month = selectedDay.month;
                      }

                      AppCubit.get(context).getLabAppointmentsData(date: '${selectedDay.year.toString()}-${month.toString()}-${day.toString()}');
                    },
                    availableCalendarFormats: const {
                      CalendarFormat.month: 'Month',
                    },
                    headerStyle: HeaderStyle(
                      headerPadding: EdgeInsets.symmetric(horizontal: 0.2.sw),
                      // rightChevronIcon: Transform.rotate(
                      //     angle: Provider.of<LocalizationController>(context,
                      //                     listen: false)
                      //                 .locale
                      //                 .languageCode ==
                      //             "ar"
                      //         ? rightRotationAngle
                      //         : leftRotationAngle,
                      //     child: SvgPicture.asset("assets/dropDownArrow.svg",
                      //         color: greenBlue, height: 0.03.sw)),
                      // leftChevronIcon: Transform.rotate(
                      //     angle: Provider.of<LocalizationController>(context,
                      //                     listen: false)
                      //                 .locale
                      //                 .languageCode ==
                      //             "ar"
                      //         ? leftRotationAngle
                      //         : rightRotationAngle,
                      //     child: SvgPicture.asset("assets/dropDownArrow.svg",
                      //         color: greenBlue, height: 0.03.sw)),
                    ),
                    calendarStyle: CalendarStyle(
                      selectedTextStyle: const TextStyle(color: blueDark),
                      todayDecoration: const BoxDecoration(
                          color: blueDark, shape: BoxShape.circle),
                      selectedDecoration: BoxDecoration(
                          color: blueDark.withOpacity(0.2),
                          shape: BoxShape.circle),
                      defaultDecoration: const BoxDecoration(),
                      holidayDecoration:
                      const BoxDecoration(shape: BoxShape.circle),
                      weekendDecoration:
                      const BoxDecoration(shape: BoxShape.circle),
                      rangeEndDecoration:
                      const BoxDecoration(shape: BoxShape.circle),
                      outsideDecoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      disabledDecoration:
                      const BoxDecoration(shape: BoxShape.circle),
                      weekendTextStyle: const TextStyle(
                        color: blueDark,
                      ),
                      markerSize: 15.0,
                      markerDecoration: const BoxDecoration(),
                      isTodayHighlighted: true,
                    ),
                    availableGestures: AvailableGestures.horizontalSwipe,
                    // calendarBuilders: CalendarBuilders<SessionModel>(
                    //   dowBuilder: (context, day) {
                    //     return Center(
                    //       child: ExcludeSemantics(
                    //         child: Text(
                    //           "${DateFormat.E("en").format(day)}",
                    //           style: TextStyle(
                    //               color: !_isCurrentMonthChanged &&
                    //                       DateFormat.E("en_US").format(_today) ==
                    //                           DateFormat.E("en_US").format(day)
                    //                   ? Theme.of(context).primaryColor
                    //                   : dustyTeal,
                    //               fontWeight: FontWeight.w400),
                    //         ),
                    //       ),
                    //     );
                    //   },
                    // ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
            ],
          ),
        );
      },
    );
  }
}

class HomeCalenderView extends StatefulWidget {
  const HomeCalenderView();

  @override
  _HomeCalenderViewState createState() => _HomeCalenderViewState();
}

class _HomeCalenderViewState extends State<HomeCalenderView> {
  // final DateTime _currentDay = DateTime.now();
  final DateTime _today = DateTime.now();
  DateTime? _selectedDay;

  var day;
  var month;

  final CalendarFormat _calendarFormat = CalendarFormat.month;

  // List<SessionModel> _getEventsForDay(DateTime day) {
  //   return [];
  // }
  // final bool _loadingData = true;
  // final bool _isCurrentMonthChanged = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context, state){
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4), color: whiteColor),
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 5, vertical: 10.0),
                  child: TableCalendar(
                    locale: sharedLanguage,
                    firstDay: kFirstDay,
                    lastDay: kLastDay,
                    focusedDay: _today,
                    calendarFormat: _calendarFormat,
                    startingDayOfWeek: StartingDayOfWeek.sunday,
                    daysOfWeekHeight: 30,
                    rowHeight: 40,
                    // eventLoader: _getEventsForDay,
                    // for badge under day
                    selectedDayPredicate: (day) {
                      // Use `selectedDayPredicate` to determine which day is currently selected.
                      // If this returns true, then `day` will be marked as selected.

                      // Using `isSameDay` is recommended to disregard
                      // the time-part of compared DateTime objects.
                      return isSameDay(_selectedDay, day);
                    },
                    onFormatChanged: (format) {
                      // if (_calendarFormat == CalendarFormat.month) {
                      //   setState(() {
                      //     _calendarFormat = CalendarFormat.twoWeeks;
                      //   });
                      // }
                      // else if ( _calendarFormat == CalendarFormat.twoWeeks){
                      //   setState(() {
                      //     _calendarFormat = CalendarFormat.week;
                      //   });
                      // }
                      // else if (_calendarFormat == CalendarFormat.week){
                      //   setState(() {
                      //     _calendarFormat = CalendarFormat.month;
                      //   });
                      // }
                    },

                    onCalendarCreated: (controller) {
                      // Provider.of<ShiftsProvider>(context,listen: false).fetchCalendarDaysWithOffers(context,startDate: widget.startDate,endDate: widget.endDate,historyType: widget.historyType);
                    },

                    onPageChanged: (DateTime day) {
                      // to save current page in Calendar when page changed .
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      if (!isSameDay(_selectedDay, selectedDay)) {
                        // Call `setState()` when updating the selected day
                        setState(() {
                          _selectedDay = selectedDay;
                        });
                      }
                      if(selectedDay.day <= 9){
                        day = '0${selectedDay.day}';
                      }else {
                        day = selectedDay.day;
                      }

                      if(selectedDay.month <= 9){
                        month = '0${selectedDay.month}';
                      }else {
                        month = selectedDay.month;
                      }

                      AppCubit.get(context).getHomeAppointmentsData(date: '${selectedDay.year.toString()}-${month.toString()}-${day.toString()}');
                    },
                    availableCalendarFormats: const {
                      CalendarFormat.month: 'Month',
                    },
                    headerStyle: HeaderStyle(
                      headerPadding: EdgeInsets.symmetric(horizontal: 0.2.sw),
                      // rightChevronIcon: Transform.rotate(
                      //     angle: Provider.of<LocalizationController>(context,
                      //                     listen: false)
                      //                 .locale
                      //                 .languageCode ==
                      //             "ar"
                      //         ? rightRotationAngle
                      //         : leftRotationAngle,
                      //     child: SvgPicture.asset("assets/dropDownArrow.svg",
                      //         color: greenBlue, height: 0.03.sw)),
                      // leftChevronIcon: Transform.rotate(
                      //     angle: Provider.of<LocalizationController>(context,
                      //                     listen: false)
                      //                 .locale
                      //                 .languageCode ==
                      //             "ar"
                      //         ? leftRotationAngle
                      //         : rightRotationAngle,
                      //     child: SvgPicture.asset("assets/dropDownArrow.svg",
                      //         color: greenBlue, height: 0.03.sw)),
                    ),
                    calendarStyle: CalendarStyle(
                      selectedTextStyle: const TextStyle(color: blueDark),
                      todayDecoration: const BoxDecoration(
                          color: blueDark, shape: BoxShape.circle),
                      selectedDecoration: BoxDecoration(
                          color: blueDark.withOpacity(0.2),
                          shape: BoxShape.circle),
                      defaultDecoration: const BoxDecoration(),
                      holidayDecoration:
                      const BoxDecoration(shape: BoxShape.circle),
                      weekendDecoration:
                      const BoxDecoration(shape: BoxShape.circle),
                      rangeEndDecoration:
                      const BoxDecoration(shape: BoxShape.circle),
                      outsideDecoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      disabledDecoration:
                      const BoxDecoration(shape: BoxShape.circle),
                      weekendTextStyle: const TextStyle(
                        color: blueDark,
                      ),
                      markerSize: 15.0,
                      markerDecoration: const BoxDecoration(),
                      isTodayHighlighted: true,
                    ),
                    availableGestures: AvailableGestures.horizontalSwipe,
                    // calendarBuilders: CalendarBuilders<SessionModel>(
                    //   dowBuilder: (context, day) {
                    //     return Center(
                    //       child: ExcludeSemantics(
                    //         child: Text(
                    //           "${DateFormat.E("en").format(day)}",
                    //           style: TextStyle(
                    //               color: !_isCurrentMonthChanged &&
                    //                       DateFormat.E("en_US").format(_today) ==
                    //                           DateFormat.E("en_US").format(day)
                    //                   ? Theme.of(context).primaryColor
                    //                   : dustyTeal,
                    //               fontWeight: FontWeight.w400),
                    //         ),
                    //       ),
                    //     );
                    //   },
                    // ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
            ],
          ),
        );
      },
    );
  }
}

void showCustomBottomSheet(
    BuildContext context, {
      required Widget bottomSheetContent,
      required double bottomSheetHeight,
    }) {
  showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))),
      isScrollControlled: true,
      backgroundColor: Colors.white,
      context: context,
      builder: (context) {
        return ScreenUtilInit(
          builder: (ctx,_) {
            return SizedBox(
              height: bottomSheetHeight.sh,
              child: Stack(
                children: [
                  Positioned(
                    right: 0.4.sw,
                    left: 0.4.sw,
                    top: 10,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: 5,
                      decoration: BoxDecoration(
                          color: blueDark,
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                  bottomSheetContent
                ],
              ),
            );
          },
        );
      });
}
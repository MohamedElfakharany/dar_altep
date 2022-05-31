// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:dar_altep/cubit/cubit.dart';
import 'package:dar_altep/cubit/states.dart';
import 'package:dar_altep/shared/components/cached_network_image.dart';
import 'package:dar_altep/shared/components/general_components.dart';
import 'package:dar_altep/shared/constants/colors.dart';
import 'package:dar_altep/shared/constants/generalConstants.dart';
import 'package:dar_altep/shared/network/local/const_shared.dart';
import 'package:dar_altep/translations/locale_keys.g.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class TestResultScreen extends StatefulWidget {
  TestResultScreen({Key? key, this.testName, required this.testImage})
      : super(key: key);

  final String? testName;
  final String testImage;
  double progress = 0;
  bool loading = false;

  @override
  State<TestResultScreen> createState() => _TestResultScreenState();
}

class _TestResultScreenState extends State<TestResultScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: GeneralAppBar(
              title: LocaleKeys.TxtTestResult.tr(),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              )),
          body: Container(
            padding: const EdgeInsetsDirectional.only(
                start: 10.0, top: 12.0, bottom: 12.0, end: 10.0),
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
              physics: const BouncingScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            LocaleKeys.TxtAccurateResults.tr(),
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: fontFamily,
                              color: blueDark,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          verticalMiniSpace,
                          Text(
                            '${widget.testName}',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.normal,
                              fontFamily: fontFamily,
                              color: darkColor,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      const Spacer(),
                      Image.asset(
                        'assets/images/logo.png',
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
                widget.loading
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: LinearProgressIndicator(
                          minHeight: 10,
                          value: widget.progress,
                        ),
                      )
                    : GeneralButton(
                        title: LocaleKeys.BtnDownload.tr(),
                        radius: 8,
                        btnBackgroundColor: blueLight,
                        onPress: () async {
                          openFile(url: widget.testImage, name: 'file.pdf');
                          // final tempDirc = await getTemporaryDirectory();
                          // final path = '${tempDirc.path}/DarAltep.jpg';
                          // if (kDebugMode) {
                          //   print('imagee : ${widget.testImage}');
                          //   print('path : $path');
                          // }
                          //
                          // await Dio().download(widget.testImage, path,
                          //     onReceiveProgress: (value1, value2) {
                          //   setState(() {
                          //     widget.progress = value1 / value2;
                          //   });
                          // }).then((value) {
                          //   return ImageDownloader.downloadImage(
                          //           widget.testImage)
                          //       .then((value) {
                          //     ScaffoldMessenger.of(context).showSnackBar(
                          //       const SnackBar(
                          //         content: Text('Downloaded to Gallery'),
                          //       ),
                          //     );
                          //   });
                          // });
                          // setState(() {
                          //   widget.loading = false;
                          // });
                          // await GallerySaver.saveImage(testImage!);
                        },
                      ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future openFile({required String url, String? name}) async {
    final file = await downloadFile(url, name!);
    if (file == null) return;
    print('Path ${file.path}');
    OpenFile.open(file.path);
  }

  Future<File?> downloadFile(String url, String name) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File('${appStorage.path}/$name');
    try {
      setState(() {
        widget.loading = true;
        widget.progress = 0;
      });
      final response = await Dio().get(url,
          options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            receiveTimeout: 0,
          ), onReceiveProgress: (value1, value2) {
        setState(() {
          widget.progress = value1 / value2;
        });
      });

      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Downloaded to Successfully'),
        ),
      );
      setState(() {
        widget.loading = false;
      });
      return file;
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      return null;
    }
  }
}

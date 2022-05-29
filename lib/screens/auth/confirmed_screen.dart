import 'package:dar_altep/screens/home/home_screen.dart';
import 'package:dar_altep/shared/components/general_components.dart';
import 'package:dar_altep/shared/constants/generalConstants.dart';
import 'package:dar_altep/shared/network/local/const_shared.dart';
import 'package:flutter/material.dart';

class ConfirmedScreen extends StatelessWidget {
  const ConfirmedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage("assets/images/splashBackGround.png"),
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.15), BlendMode.dstATop),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage(
                'assets/images/Confirmed.png',
              ),
              height: 300,
              width: 300,
            ),
            Text(
              'Completed',
              style: TextStyle(
                fontSize: 24,
                fontFamily: fontFamily,
                fontWeight: FontWeight.bold,
              ),
            ),
            verticalSmallSpace,
            Text(
              'Thank You , you have registered successfully',
              style: TextStyle(
                fontSize: 16,
                fontFamily: fontFamily,
                fontWeight: FontWeight.normal
              ),
            ),
            verticalSmallSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: GeneralButton(title: 'Done', onPress: () {
                navigateAndFinish(context, FadeRoute(page: const HomeScreen()));
              }),
            ),
          ],
        ),
      ),
    );
  }
}

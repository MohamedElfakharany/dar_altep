import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dar_altep/cubit/cubit.dart';
import 'package:dar_altep/cubit/states.dart';
import 'package:dar_altep/screens/home/components/widet_components.dart';
import 'package:dar_altep/shared/components/general_components.dart';
import 'package:dar_altep/shared/constants/colors.dart';
import 'package:dar_altep/shared/constants/generalConstants.dart';
import 'package:dar_altep/shared/network/local/const_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LabVisitAppointmentScreen extends StatelessWidget {
  const LabVisitAppointmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GeneralAppBar(title: 'Appointment'),
      body: BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) => {} ,
        builder: (context, state) {
          return Container(
            padding: const EdgeInsetsDirectional.only(
                start: 10.0, top: 12.0, bottom: 12.0, end: 10.0),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage("assets/images/onboardingbackground.png"),
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.15), BlendMode.dstATop),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Text(
                    'Select Appointment',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: fontFamily,
                      fontWeight: FontWeight.bold,
                      color: blueDark,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  verticalSmallSpace,
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 10.0),
                        decoration: BoxDecoration(
                          color: whiteColor,
                          border: Border.all(color: blueLight),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          'Day',
                          style: TextStyle(
                              fontFamily: fontFamily,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 10.0),
                        decoration: BoxDecoration(
                          color: whiteColor,
                          border: Border.all(color: blueLight),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          'Date',
                          style: TextStyle(
                              fontFamily: fontFamily,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 10.0),
                        decoration: BoxDecoration(
                          color: whiteColor,
                          border: Border.all(color: blueLight),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          'Time',
                          style: TextStyle(
                              fontFamily: fontFamily,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  verticalSmallSpace,
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 10,
                          blurRadius: 10,
                          offset: const Offset(0, 0), // changes position of shadow
                        ),
                      ],
                    ),
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: ConditionalBuilder(
                      condition: state is! AppGetAppointmentsLoadingState,
                      builder: (context) => ListView.separated(
                        itemBuilder: (context,index) => AppointmentCard(index: index,context: context, appointmentsModel: AppCubit.get(context).appointmentsModel),
                        separatorBuilder: (context, index) => Container(color: Colors.grey,height: 1.0,),
                        itemCount: AppCubit.get(context).appointmentsModel!.data!.length,
                      ),
                      fallback: (context) => const Center(child: CircularProgressIndicator()),
                    ),
                  ),
                ],
              ),
            ),
          );
        } ,
      ),
    );
  }
}

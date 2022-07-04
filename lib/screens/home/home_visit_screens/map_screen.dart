// ignore_for_file: must_be_immutable

import 'package:dar_altep/cubit/cubit.dart';
import 'package:dar_altep/cubit/states.dart';
import 'package:dar_altep/screens/home/home_visit_screens/home_visit_appointments_screen.dart';
import 'package:dar_altep/shared/components/general_components.dart';
import 'package:dar_altep/shared/constants/general_constants.dart';
import 'package:dar_altep/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geo;

class MapScreen extends StatefulWidget {
  MapScreen({Key? key, this.testName}) : super(key: key);
  String? testName;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _controller;
  Location currentLocation = Location();
  final Set<Marker> _markers = {};
  var formKey = GlobalKey<FormState>();

  double latitude = 0;
  double longitude = 0;
  geo.Placemark? userAddress;

  final addressController = TextEditingController();
  final markOfPlaceController = TextEditingController();
  final floorController = TextEditingController();
  final buildingController = TextEditingController();

  // void getLocation() async {
  //   if (!await currentLocation.serviceEnabled()) {
  //     if (!await currentLocation.requestService()) {
  //       currentLocation.onLocationChanged.listen((LocationData loc) {
  //         _controller?.animateCamera(
  //           CameraUpdate.newCameraPosition(
  //             CameraPosition(
  //               target: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0),
  //               zoom: 17.0,
  //             ),
  //           ),
  //         );
  //         setState(() {
  //           _markers.add(
  //             Marker(
  //                 markerId: const MarkerId('Home'),
  //                 position: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0)),
  //           );
  //           if (kDebugMode) {
  //             print('loc.latitude ${loc.latitude}');
  //           }
  //           latitude = loc.latitude!;
  //           longitude = loc.longitude!;
  //         });
  //       });
  //     }
  //   }
  //   var permission = await currentLocation.hasPermission();
  //   if (permission == PermissionStatus.denied) {
  //     permission = await currentLocation.requestPermission();
  //     if (permission != PermissionStatus.granted) {
  //       return;
  //     }
  //   } else {
  //     currentLocation.onLocationChanged.listen((LocationData loc) {
  //       _controller?.animateCamera(
  //         CameraUpdate.newCameraPosition(
  //           CameraPosition(
  //             target: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0),
  //             zoom: 17.0,
  //           ),
  //         ),
  //       );
  //       setState(() {
  //         _markers.add(
  //           Marker(
  //               markerId: const MarkerId('Home'),
  //               position: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0)),
  //         );
  //         latitude = loc.latitude!;
  //         longitude = loc.longitude!;
  //       });
  //     });
  //   }
  // }
  Future _getLocation() async {
    Location location = Location();
    LocationData pos = await location.getLocation();
    latitude = pos.latitude!;
    longitude = pos.longitude!;
    if (kDebugMode) {
      print('latitude inside get location $latitude');
    }
    // SharedPrefrence().setLatitude(_pos.latitude);
    // SharedPrefrence().setLongitude(_pos.longitude);
  }

  void getAddressBasedOnLocation() async {
    _getLocation();
    var address = await geo.placemarkFromCoordinates(latitude, longitude);
    setState(() {
      userAddress = address.first;
      if (kDebugMode) {
        print('from getAddressBasedOnLocation userAddress : $userAddress');
      }
      addressController.text =
          '${userAddress?.administrativeArea} ${userAddress?.locality} ${userAddress?.street} ${userAddress?.subThoroughfare}';
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      // getLocation();
      // getAddressBasedOnLocation();
      if (latitude != 0){
        addressController.text =
        '${userAddress?.administrativeArea} ${userAddress?.locality} ${userAddress?.street} ${userAddress?.subThoroughfare}';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (kDebugMode) {
          print('widget.testName from map ${widget.testName}');
        }
        return Scaffold(
          appBar: GeneralAppBar(title: 'Add Address'),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                // GoogleMap(
                //   zoomControlsEnabled: false,
                //   initialCameraPosition: const CameraPosition(
                //     target: LatLng(48.8561, 2.2930),
                //     zoom: 19.0,
                //   ),
                //   onMapCreated: (GoogleMapController controller) {
                //     _controller = controller;
                //   },
                //   markers: _markers,
                // ),
                GoogleMap(
                  zoomControlsEnabled: false,
                  myLocationEnabled: true,
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(30.033333, 31.233334),
                    zoom: 18.0,
                  ),
                  onCameraMove: (CameraPosition displayingLocation){
                    // do operations here
                    setState((){
                      getAddressBasedOnLocation();
                    });
                  },
                  onMapCreated: (controller) {
                    setState ((){
                      _controller = controller;
                    });
                  },
                  markers: _markers,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .5,
                  child: Form(
                    key: formKey,
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        DefaultFormField(
                          suffixIcon: Icons.location_searching,
                          onTap: () {
                            if (kDebugMode) {
                              print(latitude);
                            }
                            setState((){
                              getAddressBasedOnLocation();
                            });
                          },
                          // readOnly: true,
                          controller: addressController,
                          type: TextInputType.text,
                          validatedText: LocaleKeys.txtFieldAddress.tr(),
                          label: LocaleKeys.txtFieldAddress.tr(),
                        ),
                        DefaultFormField(
                          controller: markOfPlaceController,
                          type: TextInputType.text,
                          validatedText: 'Mark of the place',
                          label: 'Mark of the place',
                        ),
                        DefaultFormField(
                          controller: floorController,
                          type: TextInputType.number,
                          validatedText: 'Floor Number',
                          label: 'Floor Number',
                        ),
                        DefaultFormField(
                          controller: buildingController,
                          type: TextInputType.number,
                          validatedText: 'Building Number',
                          label: 'Building Number',
                        ),
                        GeneralButton(
                          title: 'Add Address',
                          onPress: () {
                            if (formKey.currentState!.validate()) {
                              Navigator.push(
                                context,
                                FadeRoute(
                                  page: HomeVisitAppointmentScreen(
                                    testName: widget.testName,
                                    testNames: AppCubit.get(context).testName,
                                    user: AppCubit.get(context).userModel,
                                    address:
                                    '${addressController.text}, Building no: ${buildingController.text},Floor no: ${floorController.text}',
                                    lat: latitude,
                                    long: longitude,
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                        verticalLargeSpace
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          // ConditionalBuilder(
          //   condition: latitude != 0 || longitude != 0,
          //   builder: (context) => SizedBox(
          //     height: MediaQuery.of(context).size.height,
          //     width: MediaQuery.of(context).size.width,
          //     child: Stack(
          //       alignment: Alignment.bottomCenter,
          //       children: [
          //         // GoogleMap(
          //         //   zoomControlsEnabled: false,
          //         //   initialCameraPosition: const CameraPosition(
          //         //     target: LatLng(48.8561, 2.2930),
          //         //     zoom: 19.0,
          //         //   ),
          //         //   onMapCreated: (GoogleMapController controller) {
          //         //     _controller = controller;
          //         //   },
          //         //   markers: _markers,
          //         // ),
          //         GoogleMap(
          //           zoomControlsEnabled: false,
          //           myLocationEnabled: true,
          //           initialCameraPosition: const CameraPosition(
          //             target: LatLng(30.033333, 31.233334),
          //             zoom: 18.0,
          //           ),
          //         onCameraMove: (CameraPosition displayingLocation){
          //           // do operations here
          //           getAddressBasedOnLocation();
          //         },
          //           onMapCreated: (controller) {
          //             _controller = controller;
          //           },
          //           markers: _markers,
          //         ),
          //         SizedBox(
          //           height: MediaQuery.of(context).size.height * .5,
          //           child: Form(
          //             key: formKey,
          //             child: ListView(
          //               physics: const BouncingScrollPhysics(),
          //               children: [
          //                 DefaultFormField(
          //                   suffixIcon: Icons.location_searching,
          //                   onTap: () {
          //                     if (kDebugMode) {
          //                       print(latitude);
          //                     }
          //                     setState((){
          //                       getAddressBasedOnLocation();
          //                     });
          //                   },
          //                   // readOnly: true,
          //                   controller: addressController,
          //                   type: TextInputType.text,
          //                   validatedText: LocaleKeys.txtFieldAddress.tr(),
          //                   label: LocaleKeys.txtFieldAddress.tr(),
          //                 ),
          //                 DefaultFormField(
          //                   controller: markOfPlaceController,
          //                   type: TextInputType.text,
          //                   validatedText: 'Mark of the place',
          //                   label: 'Mark of the place',
          //                 ),
          //                 DefaultFormField(
          //                   controller: floorController,
          //                   type: TextInputType.number,
          //                   validatedText: 'Floor Number',
          //                   label: 'Floor Number',
          //                 ),
          //                 DefaultFormField(
          //                   controller: buildingController,
          //                   type: TextInputType.number,
          //                   validatedText: 'Building Number',
          //                   label: 'Building Number',
          //                 ),
          //                 GeneralButton(
          //                   title: 'Add Address',
          //                   onPress: () {
          //                     if (formKey.currentState!.validate()) {
          //                       Navigator.push(
          //                         context,
          //                         FadeRoute(
          //                           page: HomeVisitAppointmentScreen(
          //                             testName: widget.testName,
          //                             testNames: AppCubit.get(context).testName,
          //                             user: AppCubit.get(context).userModel,
          //                             address:
          //                             '${addressController.text}, Building no: ${buildingController.text},Floor no: ${floorController.text}',
          //                             lat: latitude,
          //                             long: longitude,
          //                           ),
          //                         ),
          //                       );
          //                     }
          //                   },
          //                 ),
          //                 verticalLargeSpace
          //               ],
          //             ),
          //           ),
          //         )
          //       ],
          //     ),
          //   ),
          //   fallback: (context) => const Center(child: CircularProgressIndicator()),
          // ),
          // floatingActionButton: FloatingActionButton(
          //   child: const Icon(
          //     Icons.location_searching,
          //     color: Colors.white,
          //   ),
          //   onPressed: () {
          //     if (kDebugMode) {
          //       print('longitude : $latitude');
          //       print('userAddress : $userAddress ');
          //     }
          //     getLocation();
          //     getAddressBasedOnLocation();
          //     if (kDebugMode) {
          //       print('after getLocation longitude : $longitude');
          //       print('after getLocation userAddress : $userAddress ');
          //     }
          //   },
          // ),
        );
      },
    );
  }
}

import 'package:dar_altep/models/auth/offers_model.dart';
import 'package:dar_altep/shared/components/cached_network_image.dart';
import 'package:dar_altep/shared/components/general_components.dart';
import 'package:dar_altep/shared/constants/colors.dart';
import 'package:dar_altep/shared/constants/generalConstants.dart';
import 'package:dar_altep/shared/network/local/const_shared.dart';
import 'package:flutter/material.dart';

class HomeOffersCard extends StatelessWidget {
  HomeOffersCard({Key? key, required this.offersModel, required this.context, required this.index}) : super(key: key);
  final OffersModel offersModel;
  final BuildContext context;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
          start: 10.0, top: 12.0, bottom: 12.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 4,
              blurRadius: 6,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
          border: Border.all(color: whiteColor),
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        width: 160.0,
        height: 227.0,
        child: Stack(
          children: [
            Positioned.fill(
              top: 0,
              left: 0,
              right: 0,
              bottom: 110,
              child: CachedNetworkImageNormal(
                imageUrl:
                    offersModel.data?[index].image,
                height: 100.0,
              ),
            ),
            Positioned.fill(
              top: 100,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: whiteColor,
                ),
                height: 122,
                padding: const EdgeInsetsDirectional.only(
                    top: 15.0, start: 10.0, end: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      offersModel.data?[index].name,
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    verticalMicroSpace,
                    Text(
                      offersModel.data?[index].description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: fontFamily,
                        color: Colors.grey,
                      ),
                    ),
                    verticalMicroSpace,
                    Positioned.fill(
                      right: 0,
                      bottom: 0,
                      left: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                offersModel.data?[index].type,
                                style: const TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey,
                                ),
                              ),
                              verticalMicroSpace,
                              Container(
                                width: 100,
                                height: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  gradient: const LinearGradient(
                                    colors: [blueDark, blueLight],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: blueDark.withOpacity(0.25),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(
                                          0, 5), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: MaterialButton(
                                  onPressed: () {},
                                  child: const Center(
                                    child: Text(
                                      'Get Offers',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                              ),
                              // GeneralButton(
                              //   title: 'Get Offer',
                              //   width: 60,
                              //   height: 20,
                              //   fontSize: 12,
                              //   onPress: () {},
                              // ),
                            ],
                          ),
                          SizedBox(
                            height: 35,
                            width: 35,
                            child: Image.asset(
                              'assets/images/homeOffer.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TestLibraryCard extends StatefulWidget {
  const TestLibraryCard({Key? key}) : super(key: key);

  @override
  State<TestLibraryCard> createState() => _TestLibraryCardState();
}

class _TestLibraryCardState extends State<TestLibraryCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
          start: 10.0, top: 12.0,end: 10.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 4,
              blurRadius: 6,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          border: Border.all(color: whiteColor),
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        width: double.infinity,
        height: 110.0,
        child: Stack(
          children: [
            Positioned.fill(
              top: 15,
              left: MediaQuery.of(context).size.width * 0.3,
              right: 0,
              bottom: 15,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: whiteColor,
                ),
                height: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sugar Test',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: fontFamily,
                        fontWeight: FontWeight.bold,
                        color: blueDark,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    verticalMicroSpace,
                    Text(
                      'Duration : 2 days',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: fontFamily,
                        color: Colors.grey,
                      ),
                    ),
                    verticalMicroSpace,
                    Text(
                      'Price : 50.00\$',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: fontFamily,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              // right: MediaQuery.of(context).size.width * 0.6,
              child: CachedNetworkImageNormal(
                imageUrl:
                'https://avatars.githubusercontent.com/u/34916493?s=400&u=e7300b829193270fbcd03a813551a3702299cbb1&v=4',
                width: 115.0,
              ),
            ),
            const Positioned(
              top: 10,
              right: 15,
              child: CircleAvatar(
                radius: 15,
                backgroundColor: blueDark,
                child: Icon(
                  Icons.add_rounded,
                  color: whiteColor,
                  size: 25,
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: GeneralUnfilledButton(
                title: 'Precautions',
                height: 35,
                width: 90,
                btnRadius: 8,
                borderColor: blueLight,
                onPress: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

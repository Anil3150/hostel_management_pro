import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../infrastructure/theme/colors.dart';


class Shimmers {
  getListShimmer({count = 10, bgColor = const Color.fromARGB(255, 66, 115, 137), double height = 100.0}) {
    return Shimmer.fromColors(
        baseColor: bgColor.withOpacity(0.6),
        highlightColor: bgColor.withOpacity(0.3),
        child: ListView.builder(
            itemCount: count,
            shrinkWrap: true,
            itemBuilder: (context, index) => Card(
                  elevation: 12.0,
                  shadowColor: bgColor,
                  child: Container(
                    height: height,
                    color: Colors.red,
                    margin: const EdgeInsets.all(16.0),
                  ),
                )));
  }

  getListDealsShimmer({count = 10, bgColor = const Color.fromARGB(255, 66, 115, 137)}) {
    return Shimmer.fromColors(
        baseColor: bgColor.withOpacity(0.6),
        highlightColor: bgColor.withOpacity(0.3),
        child: ListView.builder(
            itemCount: count,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => Card(
                  elevation: 12.0,
                  shadowColor: bgColor,
                  child: Container(
                    height: 100.0,
                    color: Colors.red,
                    margin: const EdgeInsets.all(16.0),
                  ),
                )));
  }

  getBannerShimmer() {
    return Shimmer.fromColors(
        baseColor: primary.withOpacity(0.6),
        highlightColor: primary.withOpacity(0.3),
        child: Card(
          elevation: 12.0,
          shadowColor: primary,
          child: Container(
            height: Get.width,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(16),
              ),
              color: Colors.white.withOpacity(0.1),
            ),
            margin: const EdgeInsets.all(16.0),
          ),
        ));
  }

  machineIndividualTabShimmer({colorOne, colorTwo}) {
    return Shimmer.fromColors(
        baseColor: colorOne,
        highlightColor: colorTwo,
        child: Card(
          elevation: 12.0,
          shadowColor: const Color.fromARGB(255, 66, 115, 137),
          child: Container(
            height: Get.width,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(16),
              ),
              color: Colors.white.withOpacity(0.1),
            ),
          ),
        ));
  }

  getBottomMenuShimmer() {
    return Shimmer.fromColors(
        baseColor: primary.withOpacity(0.6),
        highlightColor: primary.withOpacity(0.3),
        child: Container(
          height: 75.0,
          width: Get.width,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(16),
            ),
            color: Colors.white.withOpacity(0.1),
          ),
          margin: const EdgeInsets.all(16.0),
        ));
  }

  getShimmerItem({
    child,
    height=100.0,
    width=100.0,
    bgColor = const Color.fromARGB(255, 66, 115, 137),
  }) {
    return Shimmer.fromColors(
        child: child ??
            Card(
              elevation: 12.0,
              shadowColor: bgColor,
              child: Container(
                height: height,
                width: width,
                color: Colors.red,
                margin: const EdgeInsets.all(16.0),
              ),
            ),
        baseColor: bgColor.withOpacity(0.6),
        highlightColor: bgColor.withOpacity(0.3));
  }

  // getShimmerForText({width = 100.0, height = 50.0}) {
  //   return Shimmer.fromColors(
  //       baseColor: utilizationCardTwo.withOpacity(0.2),
  //       highlightColor: utilizationCardOne.withOpacity(0.2),
  //       child: Container(
  //         height: height,
  //         width: width,
  //         color: Colors.red,
  //       ));
  // }

  getFavouriteShimm(){
    return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                CupertinoIcons.heart,
                color: Colors.grey[300],
              ),
            ),
          );
  }
}

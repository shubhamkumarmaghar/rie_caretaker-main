import 'package:cached_network_image/cached_network_image.dart';
import 'package:caretaker/theme/custom_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shimmer/shimmer.dart';

class ImageView extends StatelessWidget {
  final String profileUrl;
  ImageView({super.key,required this.profileUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: BackButton(
            color: CustomTheme.black,
          ),),
      body: Container(

          width: Get.width,
          height: Get.height,
          decoration: const BoxDecoration(
            color: Colors.white
          ),
          child: Center(
            child:
              Container(width: Get.width,
                child: CachedNetworkImage(
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey.shade200,
                    highlightColor: Colors.grey.shade400,
                    period: const Duration(milliseconds: 1500),
                    child: Container(
                      height: Get.height * 0.35,
                      color: Color(0xff7AB02A),
                    ),
                  ),
                  imageUrl: profileUrl,
                  width: Get.width,
                  fit: BoxFit.cover,
                ),
              ),
            ) ,
          ),
    );
  }
}

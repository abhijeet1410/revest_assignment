import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
/// Created by Abhijeet on 27th Nov 2023
///
class BreedImage extends StatelessWidget {
  final String image;
  const BreedImage(this.image, {super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(24)),
        child: SizedBox(
            height: 180,
            width: Get.width,
            child: CachedNetworkImage(
              imageUrl: image,
              fit: BoxFit.cover,
              placeholder: (ctx, s) => Container(
                height: 180,
                width: 180,
                decoration: const BoxDecoration(
                    color: Colors.grey
                ),
              ),
            )));
  }
}

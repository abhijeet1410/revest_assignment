import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revest_app/pages/breed_images/breed_images_page.dart';

///
/// Created by Abhijeet on 27th Nov 2023
///
class Dog extends StatelessWidget {
  final String dog;
  const Dog(this.dog, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Get.toNamed(BreedImagesPage.routeName,
            arguments: {'breed': dog});
      },
      title: Text(dog.capitalizeFirst!),
    );
  }
}

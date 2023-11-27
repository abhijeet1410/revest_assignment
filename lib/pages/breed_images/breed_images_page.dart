import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revest_app/pages/breed_images/breed_images_controller.dart';
import 'package:revest_app/pages/breed_images/widgets/breed_image.dart';

///
/// Created by Abhijeet on 27th Nov 2023
///
class BreedImagesPage extends StatefulWidget {
  static const routeName = '/breed-images';

  const BreedImagesPage({super.key});

  @override
  State<BreedImagesPage> createState() => _BreedImagesPageState();
}

class _BreedImagesPageState extends State<BreedImagesPage> {
  late BreedImagesController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.isRegistered<BreedImagesController>()
        ? Get.find<BreedImagesController>()
        : Get.put(BreedImagesController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${controller.breed.capitalizeFirst} Images'),
        centerTitle: true,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
      ),
      body: SafeArea(
        child: controller.obx((state) {
          if (state != null && controller.status.isSuccess) {
            return GridView.builder(
                padding: const EdgeInsets.all(16),
                itemBuilder: (c, i) => BreedImage(state[i]),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: controller.state!.length);
          }
          return const SizedBox.shrink();
        },
            onLoading: const SizedBox(
              height: 600,
              child: Center(
                child: CupertinoActivityIndicator(),
              ),
            )),
      ),
    );
  }
}

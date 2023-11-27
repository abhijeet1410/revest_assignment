import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revest_app/pages/breed_images/breed_images_page.dart';
import 'package:revest_app/pages/dogs_listing/dogs_listing_controller.dart';
import 'package:revest_app/pages/dogs_listing/widgets/dog.dart';

///
/// Created by Abhijeet on 27th Nov 2023
///

class DogsListingPage extends StatefulWidget {
  static const routeName = '/dogs-listing';

  const DogsListingPage({super.key});

  @override
  State<DogsListingPage> createState() => _DogsListingPageState();
}

class _DogsListingPageState extends State<DogsListingPage> {
  late DogsListingController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.isRegistered<DogsListingController>()
        ? Get.find<DogsListingController>()
        : Get.put(DogsListingController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dogs'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: controller.obx((state) {
          if (state != null && controller.status.isSuccess) {
            return ListView.separated(
                itemBuilder: (c, i) => Dog(state[i]),
                separatorBuilder: (c, i) => const Divider(),
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

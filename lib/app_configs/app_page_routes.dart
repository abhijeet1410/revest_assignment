import 'package:get/get.dart';
import 'package:revest_app/pages/breed_images/breed_images_page.dart';
import 'package:revest_app/pages/dogs_listing/dogs_listing_page.dart';
import 'package:revest_app/pages/splash_page.dart';

class AppPages {
  /// NOT TO BE USE NOW
  static final pages = [
    GetPage(name: SplashPage.routeName, page: () => const SplashPage()),
    GetPage(
        name: DogsListingPage.routeName, page: () => const DogsListingPage()),
    GetPage(
        name: BreedImagesPage.routeName, page: () => const BreedImagesPage()),
  ];
}

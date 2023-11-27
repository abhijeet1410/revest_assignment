import 'package:get/get.dart';
import 'package:revest_app/api_services/base_api.dart';
import 'package:revest_app/app_configs/api_routes.dart';
import 'package:revest_app/data_models/breed_images.dart';

class BreedImagesController extends GetxController
    with StateMixin<List<String>> {

  String breed = '';

  @override
  void onInit() {
    super.onInit();
    Map<String, dynamic> args = Get.arguments ?? {};
    breed = args['breed'];
    loadData();
  }

  Future<void> loadData() async {
    try{
      change(null, status: RxStatus.loading());
      final response = await ApiCall.get('${ApiRoutes.breed}/$breed/images');
      final result = BreedImagesResponse.fromJson(response.data);
      change(result.message, status: RxStatus.success());
    } catch (_) {
      change(null, status: RxStatus.error());
    }
  }
}

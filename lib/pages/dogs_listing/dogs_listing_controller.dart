import 'package:get/get.dart';
import 'package:revest_app/api_services/base_api.dart';
import 'package:revest_app/app_configs/api_routes.dart';
import 'package:revest_app/data_models/dog_list.dart';

class DogsListingController extends GetxController
    with StateMixin<List<String>> {

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    change(null, status: RxStatus.loading());
    final response = await ApiCall.get(ApiRoutes.allBreeds);
    final data = DogListingResponse.fromJson(response.data);
    List<String> breedNames = [];
    data.message.forEach((key, value) {
      breedNames.add(key);
    });
    change(breedNames, status: RxStatus.success());
  }
}

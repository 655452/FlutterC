import 'dart:convert';
import '/models/cuisine.dart';
import '/services/api-list.dart';
import '/services/server.dart';
import 'package:get/get.dart';

class CuisineController extends GetxController {
  Server server = Server();
  List<CuisineDataModel> cuisineList = <CuisineDataModel>[];
  bool cuisineLoader = true;

  // get onRefreshScreen => null;

  @override
  void onInit() {
    getAllCuisine();
    super.onInit();
  }
 Future<void> onRefreshScreen() async {
    await getAllCuisine(); // Refresh the cuisine list
  }
  @override
  void onClose() {
    super.onClose();
  }

  getAllCuisine() async {
    server.getRequest(endPoint: APIList.cuisine).then((response) {
      if (response != null && response.statusCode == 200) {
        cuisineLoader = false;
        final jsonResponse = json.decode(response.body);
        print(jsonResponse);
        var cuisineData = CuisineData.fromJson(jsonResponse['data']);
        cuisineList = <CuisineDataModel>[];
        print(cuisineList);

        cuisineList.addAll(cuisineData.cuisineList!);
          // Update the image URLs
      cuisineList = cuisineList.map((cuisine) {
        if (cuisine.image != null) {
          cuisine.image = "https://woich.in"+cuisine.image!;
        }
        return cuisine;
      }).toList();
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      } else {}
    });
  }
}

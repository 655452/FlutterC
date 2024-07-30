import 'dart:convert';
import '/models/restaurabts_by_cuisine.dart';
import '/services/server.dart';
import 'package:get/get.dart';

class CuisineWiseRestaurants extends GetxController {
  Server server = Server();
  var cuisineId;
  bool cuisineWiseRestaurantsLoader = true;
  List<Restaurant> restaurantList = <Restaurant>[];

  CuisineWiseRestaurants(this.cuisineId);
  @override
  void onInit() {
    // this.cuisineId;
    getAllRestaurantsByCuisine(cuisineId);
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getAllRestaurantsByCuisine(var id) async {
    server.getRequestWithParamCuisine(cuisineId: id).then((response) {
      if (response != null && response.statusCode == 200) {
        cuisineWiseRestaurantsLoader = false;
        final jsonResponse = json.decode(response.body);
        print(jsonResponse);
        var cuisineWiseRestaurantData =
            RestaurantByCuisineData.fromJson(jsonResponse['data']);
        print(jsonResponse);
        restaurantList = <Restaurant>[];
        print(cuisineWiseRestaurantData);
        restaurantList.addAll(cuisineWiseRestaurantData.data!.restaurants!);

          // Update the image URLs
      restaurantList = restaurantList.map((cuisine) {
        if (cuisine.image != null) {
          cuisine.image = "https://woich.in"+cuisine.image!;  // changed the image urls
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

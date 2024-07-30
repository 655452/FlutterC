import 'dart:convert';
import '/models/search.dart';
import '/services/api-list.dart';
import '/services/server.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  Server server = Server();
  List<Restaurant> restaurantList = <Restaurant>[];
  bool searchLoader = true;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getSearch(name, expedition) async {
    print(name);
    searchLoader = true;
    Map<String, String> queryParameters = {
      'name': name,
      'expedition': expedition == 'dine-in' ? 'table' : expedition,
    };
    server
        .getRequestParam(endPoint: APIList.search, body: queryParameters)
        .then((response) {
      print(response);
      if (response != null && response.statusCode == 200) {
        searchLoader = false;
        final jsonResponse = json.decode(response.body);
         print("i am getting sorted and searched");
        print(jsonResponse);
        var searchData = Data.fromJson(jsonResponse['data']);
        
        restaurantList = <Restaurant>[];
        restaurantList.addAll(searchData.data!);

// Filter the results to match the name exactly
        restaurantList = restaurantList.where((restaurant) {
          return restaurant.name!.toLowerCase() == name.toLowerCase();
        }).toList();

       // Update the image URLs
      restaurantList = restaurantList.map((restaurant) {
        if (restaurant.image != null && !restaurant.image!.startsWith('http')) {
          restaurant.image = "https://woich.in" + restaurant.image!;
        }
       
       print("restaurant after search");
       print(restaurant.toJson());
        return restaurant;
      }).toList();

        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      } else {}
    });
  }
}

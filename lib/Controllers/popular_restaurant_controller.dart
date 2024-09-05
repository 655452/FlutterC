import 'dart:convert';

import '/models/popular_restaurant.dart';
import '/services/api-list.dart';
import '/services/server.dart';
import '/services/user-service.dart';
import 'package:get/get.dart';

class PopularRestaurantController extends GetxController {
  UserService userService = UserService();
  Server server = Server();

  bool popularRestaurantLoader = true;
  bool hasMoreData = true;
  int currentPage = 1;
  int limit = 2; // Number of items per page

  List<Datum> bestSellingRestaurantList = <Datum>[];

  @override
  void onInit() {
    popularRestaurantLoader = true;
    getPopularRestaurant();
    super.onInit();
  }

  getPopularRestaurant({bool isLoadMore = false}) async {
    if (!hasMoreData && isLoadMore) return;

    if (!isLoadMore) {
      // Clear the list if it's not a load more operation
      bestSellingRestaurantList.clear();
      currentPage = 1;
      hasMoreData = true;
    }

 // Manually construct the URL with query parameters
  final String url = '${APIList.popularRestaurantPaginated}?page=$currentPage&limit=$limit';

    server.getRequest(
      endPoint:url).then((response) {
      if (response != null && response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        var popularRestaurantData = Data.fromJson(jsonResponse['data']);

        if (!isLoadMore) {
          bestSellingRestaurantList.clear();
        }

        bestSellingRestaurantList.addAll(popularRestaurantData.data!);

        // Update the image URLs
        bestSellingRestaurantList = bestSellingRestaurantList.map((restaurant) {
          if (restaurant.image != null && !restaurant.image!.startsWith('http')) {
            restaurant.image = "https://woich.in" + restaurant.image!;
          }
          return restaurant;
        }).toList();

        // Check if there's more data to load
        hasMoreData = popularRestaurantData.data!.length == limit;

        // Increment the page number for the next request
        currentPage++;
        popularRestaurantLoader = false;

        update();
      } else {
        popularRestaurantLoader = false;
        hasMoreData = false;
        update();
      }
    }).catchError((error) {
      popularRestaurantLoader = false;
      hasMoreData = false;
      update();
      print("Error: $error");
    });
  }

  void loadMore() {
    if (hasMoreData) {
      getPopularRestaurant(isLoadMore: true);
    }
  }
}

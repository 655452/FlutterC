import 'dart:convert';

import 'package:flutter/cupertino.dart';
import '/models/add_review_request.dart';
import '/models/restaurant_details.dart';
import '/services/api-list.dart';
import '/services/server.dart';
import 'package:get/get.dart';

import 'cart_controller.dart';
import 'global-controller.dart';
import 'package:html/parser.dart' show parse;

import 'package:http/http.dart' as http;

class RestaurantDetailsController extends GetxController {
  Server server = Server();

  String? userID;
  int? restaurantID;
  bool restaurantDetailsLoader = true;
  bool? orderStatus;
  int? reviewCount;
  int? rating;
  int? tableStatus;

  List<MenuItemData> menuItemList = <MenuItemData>[];
  List<Review> reviewList = <Review>[];
  List<Vouchers> vouchersList = <Vouchers>[];
  String? restaurantName,
      restaurantDeliveryCharge,
      restaurantDescription,
      restaurantAddress,
      restaurantImage,
      restaurantLogo,
      openingTime,
      closingTime,
      lat,
      long,
      cuisines;
  TextEditingController reviewController = TextEditingController();
  var ratingController;
List<Category> categoryList = <Category>[];

  @override
  void onInit() {
    userID = Get.find<GlobalController>().userId;
    super.onInit();
  }

  getRestaurant(int id) {
    server
        .getRequest(endPoint: APIList.restaurant! + id.toString())
        .then((response) {
      if (response != null && response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        print(jsonResponse);
        var restaurantData =
            RestaurantDetailsData.fromJson(jsonResponse['data']);
        if (restaurantData.data!.restaurant!.cuisines!.isNotEmpty) {
          var cuisinesData = '';
          restaurantData.data!.restaurant!.cuisines!.forEach((element) {
            cuisinesData += element['name'].toString() + ', ';
          });
          if (cuisinesData.isNotEmpty && cuisinesData.length > 0) {
            cuisines = cuisinesData.substring(0, cuisinesData.length - 2);
          }
        }

        menuItemList = <MenuItemData>[];
        menuItemList.addAll(restaurantData.data!.menuItems!);
         // Update the image URLs for menu items
      menuItemList = menuItemList.map((menuItem) {
        if (menuItem.image != null ) {
          menuItem.image = "https://woich.in" + menuItem.image!;
        }
        return menuItem;
      }).toList();
      print("menuItem lista");
      print(menuItemList);
        print(restaurantData.data!.menuItems!);
        reviewList = <Review>[];
        reviewList.addAll(restaurantData.data!.reviews!);
        vouchersList = <Vouchers>[];
        vouchersList.addAll(restaurantData.data!.vouchers!);
        reviewCount = restaurantData.data!.countUser;
        rating = restaurantData.data!.avgRating;
        Get.find<CartController>()
            .addRestuarentData(restaurantData.data!.restaurant!);
        restaurantID = restaurantData.data!.restaurant!.id;
        tableStatus = restaurantData.data!.restaurant!.tableStatus;
        restaurantName = restaurantData.data!.restaurant!.name;
        restaurantDeliveryCharge =
            restaurantData.data!.restaurant!.deliveryCharge.toString();
        restaurantDescription = restaurantData.data!.restaurant!.description;
        // here i have updated the code because its not accessing these part of url https://woich.in
        restaurantImage =  "https://woich.in" + (restaurantData.data!.restaurant!.image ?? "");
        restaurantLogo = restaurantData.data!.restaurant!.logo;
        openingTime = restaurantData.data!.restaurant!.openingTime;
        closingTime = restaurantData.data!.restaurant!.closingTime;
        restaurantAddress = restaurantData.data!.restaurant!.address;
        lat = restaurantData.data!.restaurant!.lat;
        
        print(lat);
        long = restaurantData.data!.restaurant!.long!;
        print(
            '==========>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>' +
                long.toString());
        orderStatus = restaurantData.data!.orderStatus!;
        restaurantDetailsLoader = false;

           // Fetch categories after fetching restaurant details
        fetchCategories();
        print("after fectcheing categories");
        print(categoryList);

        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      }
    });
  }
 
 Future<void>  fetchCategories() async {
    final url = 'https://woich.in/restaurant/${restaurantName!
      .toLowerCase()
      .replaceAll(RegExp(r'\s+'), '-') // Replace spaces with hyphens
      .replaceAll(RegExp(r'[^\w\-]'), '') }';
    print(restaurantName!
      .toLowerCase()
      .replaceAll(RegExp(r'\s+'), '-') // Replace spaces with hyphens
      .replaceAll(RegExp(r'[^\w\-]'), ''));
    
    // final response = await server.getRequest(endPoint: url);
     final response = await http.get(Uri.parse(url));

    // print(response.body);

    if (response != null && response.statusCode == 200) {
      final document = parse(response.body);
      extractCategoriesAndItems(document);
    } else {
      print('Failed to fetch HTML: ${response.statusCode}');
    }
  }

 void extractCategoriesAndItems(document) {
  final categories = document.querySelectorAll('.product-category');
  categoryList.clear();

  for (final category in categories) {
    final categoryTitle = category.querySelector('.product-category-title')?.text.trim() ?? 'No Title';
    final items = category.querySelectorAll('.product-card');
    List<MenuItem> menuItems = [];

    for (final item in items) {
      final itemName = item.querySelector('.product-card-title')?.text.trim() ?? 'No Name';
      final itemDescription = item.querySelector('.product-card-description')?.text.trim();
      final itemUnitPrice = double.tryParse(item.querySelector('.product-card-price')?.text.trim() ?? '');
      final itemImage = item.querySelector('.product-card-image')?.attributes['src'];
  // restaurantImage =  "https://woich.in" + (restaurantData.data!.restaurant!.image ?? "");
      menuItems.add(MenuItem(
        name: itemName,
        description: itemDescription,
        unitPrice: itemUnitPrice,
        image: itemImage,
      ));
    }

    categoryList.add(Category(name: categoryTitle, items: menuItems));
    print("category list  is  updated");
    print(categoryList.toString());
  }
updateMenuItems();
  update(); // This will update the UI
}

void updateMenuItems() {
  // Create a map of menu items from menuItemList for quick lookup
  Map<String?, MenuItemData> menuItemListMap = {};
  for (var menuItem in menuItemList) {
    if (menuItem.name != null) {
      menuItemListMap[menuItem.name] = menuItem;
    }
  }

  // Debugging: Print the contents of menuItemListMap
  print("menuItemListMap:");
  menuItemListMap.forEach((key, value) {
    print("Key: $key, Description: ${value.description}, UnitPrice: ${value.unitPrice}, Image: ${value.image}");
  });

  // Update the categoryList with data from the map
  for (var category in categoryList) {
    for (var item in category.items) {
      print("Processing item: ${item.name}");
      if (menuItemListMap.containsKey(item.name)) {
        final matchedMenuItem = menuItemListMap[item.name]!;
        item.description = matchedMenuItem.description;
        item.unitPrice = matchedMenuItem.unitPrice != null ? double.tryParse(matchedMenuItem.unitPrice!) : null;
        item.image = matchedMenuItem.image;
        print("Updated item: ${item.name}, Description: ${item.description}, UnitPrice: ${item.unitPrice}, Image: ${item.image}");
      } else {
        print("No matching item found for: ${item.name}");
      }
    }
  }

  print("Updated categoryList");
  for (var category in categoryList) {
    print('Category: ${category.name}');
    for (var item in category.items) {
      print('  - MenuItem: ${item.name}, Description: ${item.description}, UnitPrice: ${item.unitPrice}, Image: ${item.image}');
    }
  }
}

  void printCategoryList() {
    for (var category in categoryList) {
      print('Category: ${category.name}');
      for (var item in category.items) {
        print('  - MenuItem: ${item.name}');
      }
    }
  }
  addReview({BuildContext? context, addReviewRating, String? review}) async {
    Map body = {
      'rating': addReviewRating,
      'review': review,
      'user_id': int.parse(userID!),
      'restaurant_id': restaurantID
    };
    print(body);
    String jsonBody = json.encode(body);
    server
        .postRequestWithToken(endPoint: APIList.review, body: jsonBody)
        .then((response) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse);
      print(response);
      if (response != null && response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        var addReviewData = AddReviewRequest.fromJson(jsonResponse);
        print(addReviewData.review);
        reviewController.clear();
      } else {
        Get.rawSnackbar(message: 'Please enter valid input');
      }
    });
  }


}


class Category {
  String name;
  List<MenuItem> items;

  Category({required this.name, required this.items});

   @override
  String toString() {
    return 'Category{name: $name, items: $items}';
  }
}

class MenuItem {
  String name;
  String? description;
  double? unitPrice;
  String? image;

  MenuItem({required this.name, this.description, this.unitPrice, this.image});

  @override
  String toString() {
    return 'MenuItem{name: $name, description: $description, unitPrice: $unitPrice, image: $image}';
  }
}

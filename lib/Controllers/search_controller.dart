import 'dart:convert';
import '/models/search.dart'; // Make sure this contains your Restaurant and MenuItem classes
import '/services/api-list.dart';
import '/services/server.dart';
import 'package:get/get.dart';

// import '/models/restaurant_details.dart';

class SearchController extends GetxController {
  Server server = Server();
  List<Restaurant> restaurantList = <Restaurant>[];

  List<String> categories = <String>["All"];
  List<String> cusines = <String>["All"];
  List<MenuItemData> menuItemList =
      <MenuItemData>[]; // Add a list to store menu items
  bool searchLoader = true;
   String searchType = 'restaurant'; // Default to 'restaurant'

  var selectedCategory = "All"; // To store the selected category
  List<MenuItemData> filteredMenuItemList =<MenuItemData>[]; // To store the filtered list of menu items
  var selectCusine = "All"; // To store the selected category
  List<Restaurant> filteredRestaurantsList =<Restaurant>[]; // To store the filtered list of menu items

// for  checking  if duplicate cusines are  added or not
  void addCusines(String newCusines) {
    // Check for duplicate or if any existing cusines is a starting substring
    for (String cusine in cusines) {
      if (cusine == newCusines || newCusines.startsWith(cusine)) {
        print(
            "Cannot add category: '$newCusines' because it's either a duplicate or starts with an existing category.");
        return; // Do not add if the condition fails
      }
    }

    cusines
        .add(newCusines); // Add the cusines if all conditions are satisfied
    print("Category added: '$newCusines'");
  }
// for  checking  if duplicate categories are  added or not
  void addCategory(String newCategory) {
    // Check for duplicate or if any existing category is a starting substring
    for (String category in categories) {
      if (category == newCategory || newCategory.startsWith(category)) {
        print(
            "Cannot add category: '$newCategory' because it's either a duplicate or starts with an existing category.");
        return; // Do not add if the condition fails
      }
    }

    categories
        .add(newCategory); // Add the category if all conditions are satisfied
    print("Category added: '$newCategory'");
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getSearch(name, expedition) async {
    searchLoader = true;
    Map<String, String> queryParameters = {
      'name': name,
      'expedition': expedition == 'dine-in' ? 'table' : expedition,
    };

    server
        .getRequestParam(endPoint: APIList.search, body: queryParameters)
        .then((response) {
      if (response != null && response.statusCode == 200) {
        searchLoader = false;
        final jsonResponse = json.decode(response.body);
        print("i am getting sorted and searched");
        print(jsonResponse);

        // Clear existing lists
        restaurantList = <Restaurant>[];
        menuItemList = <MenuItemData>[];

        if (jsonResponse.containsKey('data')) {
          var data = jsonResponse['data']['data'];
          print("menu item before search");
          print(data['menuitems']);
          // Check if 'data' contains restaurant or menu item information

          if (data['menuitems'] != null) {
              searchType = 'menu'; // Set searchType based on data presence
            // Process menu item data
            var menuItemData = data['menuitems'] as List;
            menuItemList = menuItemData
                .map((item) => MenuItemData.fromJson(item))
                .toList();

            var menuItemDataX = data['menuitemsX'] as List;
            var count = 0;

            // Update image URLs
            // categories=[];
            menuItemList = menuItemList.map((menuItem) {
              print("categories");
              // print(menuItemDataX[count]['categories']);
              // Adding  categories  for  filtering
              var emptyArry = [];
              menuItemDataX[count]['categories'].map((menuitem) {
                print(menuitem['name']);
                print(menuitem['id']);
                addCategory(menuitem['name']);
                emptyArry.add(menuitem['name']);
              }).toList();
              menuItem.category = emptyArry.cast<String>();

              // menuItem.ratings=menuItemDataX[count]["categories"];
              menuItem.ratings = menuItemDataX[count]["average_rating"];
              menuItem.restaurantId = menuItemDataX[count]["restaurant_id"];
              if (menuItem.image != null &&
                  !menuItem.image!.startsWith('http')) {
                menuItem.image = "https://woich.in" + menuItem.image!;
              }
              count++;
              return menuItem;
            }).toList();
            cusines = []; // empty for  restaurants
            cusines.add("All");
            print("menu item after search");

            menuItemList.forEach((menuItem) {
              print(menuItem.toJson());
              print("restaurant menu search");
              print(menuItemList);
            });
          }
          if (data['restaurants'] != null) {
            // Process restaurant data
             searchType = 'restaurant'; // Set searchType based on data presence
            var restaurantData = data['restaurants'] as List;
            restaurantList = restaurantData
                .map((item) => Restaurant.fromJson(item))
                .toList();

            // Update image URLs
            print("restaurantsX");
            print(data['restaurantsX']);
            categories = []; // empty for  restaurants
            categories.add("All");
            var count=0;
            cusines = []; // empty for  restaurants
            cusines.add("All");
            restaurantList = restaurantList.map((restaurant) {
              print(data['restaurantsX'][count]['cuisines']);
              var emptarr=[];
              data['restaurantsX'][count]['cuisines'].map((item){
                  print(item['name']);
                emptarr.add(item['name']);
              addCusines(item['name']);
              }).toList();
              restaurant.cuisines=emptarr.cast<String>();

              if (restaurant.image != null &&
                  !restaurant.image!.startsWith('http')) {
                restaurant.image = "https://woich.in" + restaurant.image!;
              }
              return restaurant;
            }).toList();

            print("restaurant after search");

            restaurantList.forEach((restaurant) {
              print(restaurant.toJson());
            });
          }

          // Update the UI
          Future.delayed(Duration(milliseconds: 10), () {
            update();
          });
        }
      } else {
        searchLoader = false;
        update(); // Update the UI in case of failure
      }
    }).catchError((error) {
      searchLoader = false;
      print('Error fetching search results: $error');
      // Initially set filtered list to the complete list

      update(); // Update the UI in case of error
    });
    //  filteredMenuItemList=menuItemList;
  }

  void selectCusines(String cusineitem) {
    selectCusine = cusineitem;
    filterResaturants();
  }

  void filterResaturants() {
    if (selectCusine == "All") {
      filteredRestaurantsList = restaurantList;
    } else {
      // Filter based on the selected category
      filteredRestaurantsList = restaurantList.where((restaurant) {
        // Check if the selectedCategory is in the menuItem's category list
        bool isCategoryMatch = restaurant.cuisines!= null &&
            restaurant.cuisines!.contains(selectCusine);

        // Return true if all conditions match
        return isCategoryMatch;
      }).toList();
    }

    update();
  }

  void selectCategory(String category) {
    selectedCategory = category;
    filterMenuItems();
  }

  void filterMenuItems() {
    if (selectedCategory == "All") {
      filteredMenuItemList = menuItemList;
    } else {
      // Filter based on the selected category
      filteredMenuItemList = menuItemList.where((menuItem) {
        // Check if the selectedCategory is in the menuItem's category list
        bool isCategoryMatch = menuItem.category != null &&
            menuItem.category!.contains(selectedCategory);

        // Return true if all conditions match
        return isCategoryMatch;
      }).toList();
    }

    update();
  }
}

// data stucture for search explain
class MenuItemData {
  String name;
  String? description;
  String? unitPrice;
  String? ratings;
  List<String>? category;
  String? image; // List of non-nullable strings
  int? restaurantId; // List of non-nullable strings

  MenuItemData({
    required this.name,
    this.description,
    this.category,
    this.unitPrice,
    this.ratings,
    this.restaurantId,
    required this.image, // Ensure this is required if you want to enforce non-null list
  });

  @override
  String toString() {
    return 'MenuItem{name: $name, description: $description, unitPrice: $unitPrice, image: $image}';
  }

  factory MenuItemData.fromJson(Map<String, dynamic> json) => MenuItemData(
        name: json["name"],
        unitPrice: json["unit_price"],
        // image: json["image"],
        category: json["category"] is String
            ? [json["category"]]
            : json["category"] != null
                ? List<String>.from(json["category"])
                : [],
        ratings: json["ratings"],
        image: json["image"],
        description: json["description"],
        restaurantId: json["restaurant_id"], // Add this line
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "unit_price": unitPrice,
        "image": image,
        "category": category,
        "ratings": ratings,
        "description": description,
        "restaurant_id": restaurantId, // Add this line
      };
}

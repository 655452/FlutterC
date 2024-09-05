import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '/models/restaurant_details.dart';
import '/services/api-list.dart';
import '/services/server.dart';
import 'package:http/http.dart' as http;

class CollectionController extends GetxController {
  Server server = Server();
  List<MenuItemData> allMenuItems = <MenuItemData>[];
  List<MenuItemData> filteredMenuItems = <MenuItemData>[];
  List<String> categories = ["All", ];
  String selectedCategory = "All";
  bool isLoading = true;

  // Add properties for filtering
  double minRating = 0.0;
  double maxRating = 5.0;
  double minPrice = 0.0;
  double maxPrice = double.infinity;

  @override
  void onInit() {
    super.onInit();
    fetchStaticMenuItems(); // Fetch static menu items on initialization
  }

// for  checking  if duplicate categories are  added or not
void addCategory( String newCategory) {
  // Check for duplicate or if any existing category is a starting substring
  for (String category in categories) {
    if (category == newCategory || newCategory.startsWith(category)) {
      print("Cannot add category: '$newCategory' because it's either a duplicate or starts with an existing category.");
      return; // Do not add if the condition fails
    }
  }

  categories.add(newCategory); // Add the category if all conditions are satisfied
  print("Category added: '$newCategory'");
}

  // Method to fetch static menu items
  Future<void> fetchStaticMenuItems() async {
    try {
      print(APIList.getStaticMenuItems);
      final response = await server.getRequest(endPoint: APIList.getStaticMenuItems!);

      if (response != null && response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        print("Static menu items: $jsonResponse");

        if (jsonResponse['data']['data']['menuitems'] is List) {
          List<dynamic> menuItemsData = jsonResponse['data']['data']['menuitems'];
          List<dynamic> menuItemsDataX = jsonResponse['data']['data']['menuItemsX'];
          List<dynamic> menuItemsDataY = jsonResponse['data']['data']['menuItems'];

               double calculatedMaxPrice = 0.0;  // Variable to store the maximum price found
          var count = 0;
          allMenuItems.addAll(menuItemsData.map((menuItem) {
            menuItemsDataX[count]['media'];
            var array = [];
            for (var mediaItem in menuItemsDataX[count]['media']) {
              if (mediaItem['original_url'] != null) {
                array.add(mediaItem['original_url']);
              }
            }
            print("\n");
          print("\n unit  price ");
          print(double.parse(menuItemsDataX[count]['unit_price']));
          print("unit  categories ");
          // print(menuItemsDataX[count]['categories']);
          // adding  categories in menu Items for  filtering
          var categoryArray=[];
          menuItemsDataX[count]['categories'].map((items){
            print(items['id']);
            print(items['name']);
            categoryArray.add(items['name']);
           
            addCategory(items['name']);
          }).toList();
          menuItem['category']=categoryArray;
          print("cateegories---------------------------");
          print(menuItem['category']);
          // categoryArray=[]; //free the  temporary array
          
          print("unit  name ");
          print(menuItemsDataX[count]['name']);
          print("unit  categories ");
          print(menuItem['categories']);
            if (menuItemsDataY[count]['average_rating'] != null) {
              menuItem['ratings'] = double.parse(menuItemsDataY[count]['average_rating']);
            }
            menuItem['restaurant_id'] = menuItemsDataX[count]['restaurant_id'];
           
           double itemPrice = double.parse(menuItemsDataX[count]['unit_price']);
           if (itemPrice > calculatedMaxPrice) {
            calculatedMaxPrice = itemPrice;  // Update the maximum price found
          }
            
            menuItem['image'] = array;
            count++;
            return MenuItemData.fromJson(menuItem);
          }).toList());
          print("all Menu Items data");
          print(allMenuItems);
           maxPrice = calculatedMaxPrice;  // Set maxPrice to the highest price found
          filterMenuItems(); // Filter items after fetching
          update();
        } else {
          print('Unexpected data format: ${jsonResponse['data']}');
        }
      } else {
        print('Server returned an error: from static menu items ${response?.statusCode}');
      }
    } catch (e) {
      print('Error fetching static menu items: $e');
    }
  }

  // Keywords can be added manually
  final Map<String, List<String>> categoryKeywords = {
    "Gifting": ["ratings", "hamper", "miniature", "gift", "box", "more"],
    // Add other categories and their keywords as needed
  };

  double? selectedRating;
  double? selectedPriceRange;

  void updateRating(double rating) {
    selectedRating = rating;
    minRating = rating;
    filterMenuItems();
  }

  void updatePriceRange(double price) {
    selectedPriceRange = price;
    maxPrice = price;
    filterMenuItems();
  }

  void filterMenuItems() {
    if (selectedCategory == "All") {
      filteredMenuItems = allMenuItems.where((menuItem) {
        double price = double.parse(menuItem.unitPrice ?? '0');
        return (menuItem.ratings ?? 0) >= minRating &&
               (menuItem.ratings ?? 0) <= maxRating &&
               price >= minPrice &&
               price <= maxPrice;
      }).toList();
    } 
    
     else {
       // Filter based on the selected category
    filteredMenuItems = allMenuItems.where((menuItem) {
      // Check if the selectedCategory is in the menuItem's category list
      bool isCategoryMatch = menuItem.category != null && 
                             menuItem.category!.contains(selectedCategory);

      // Parse price for comparison
      double price = double.parse(menuItem.unitPrice ?? '0');

      // Return true if all conditions match
      return isCategoryMatch &&
             (menuItem.ratings ?? 0) >= minRating &&
             (menuItem.ratings ?? 0) <= maxRating &&
             price >= minPrice &&
             price <= maxPrice;
    }).toList();
    }
    update();
  }

  void selectCategory(String category) {
    selectedCategory = category;
    filterMenuItems();
  }

  // Methods to set filter ranges
  void setMinRating(double rating) {
    minRating = rating;
    filterMenuItems();
  }

  void setMaxRating(double rating) {
    maxRating = rating;
    filterMenuItems();
  }

  void setMinPrice(double price) {
    minPrice = price;
    filterMenuItems();
  }

  void setMaxPrice(double price) {
    maxPrice = price;
    filterMenuItems();
  }
}

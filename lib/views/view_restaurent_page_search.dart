import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_ex/json/home_page_json.dart';
import 'package:food_ex/utils/font_size.dart';
import '/Controllers/search_controller.dart' as search;
import '/views/restaurant_details.dart';
import '/views/search_error_page.dart';
import '/widgets/shimmer/view_restaurant_page_search_shimmer.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '/utils/theme_colors.dart';

class ViewRestaurantPageSearch extends StatefulWidget {
  final type;
  final String restaurantName;  // Add this line
  const ViewRestaurantPageSearch({Key? key, required this.type, required this.restaurantName}) : super(key: key);

  @override
  _ViewRestaurantPageSearchState createState() => _ViewRestaurantPageSearchState();
}

class _ViewRestaurantPageSearchState extends State<ViewRestaurantPageSearch> {
  final searchController = Get.put(search.SearchController());
  String restaurantName ="";
  TextEditingController searchTextController = TextEditingController();
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text(
    'Restaurant',
    style: TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: FontSize.large,
        color: Colors.white),
  );



//  extracting  description from restaurants
  Map<String, String> parseDescription(String description) {
  final instagramRegEx = RegExp(r'instagram=([\w\.]+)');
  final facebookRegEx = RegExp(r'facebook=([\w\s]+) description=');
  final descriptionRegEx = RegExp(r'description=(.+)');

  final instagramMatch = instagramRegEx.firstMatch(description);
  final facebookMatch = facebookRegEx.firstMatch(description);
  final descriptionMatch = descriptionRegEx.firstMatch(description);

  final instagram = instagramMatch?.group(1) ?? '';
  final facebook = facebookMatch?.group(1) ?? '';
  final desc = descriptionMatch?.group(1) ?? '';

  // print('Original description: $description');
  // print('Instagram handle: $instagram');
  // print('Facebook handle: $facebook');
  // print('Description: $desc');
  return {
    'instagram': instagram,
    'facebook': facebook,
    'description': desc,
  };
}
  @override
  void initState() {
    super.initState();
    // searchController.getSearch('', menu[widget.type].toLowerCase());
    searchController.getSearch(widget.restaurantName, menu[widget.type].toLowerCase());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white10,
          child: Column(
            children: [
              
             
//               Container(
//   height: 50,
//   child: GetBuilder<SearchController>(
//     builder: (controller) {
//       return ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: controller.searchType == 'restaurant' ? controller.cuisines.length : controller.categories.length,
//         itemBuilder: (context, index) {
//           final item = controller.searchType == 'restaurant'
//               ? controller.cuisines[index]
//               : controller.categories[index];

//           return GestureDetector(
//             onTap: () {
//               if (controller.searchType == 'restaurant') {
//                 controller.selectCuisine(item);
//               } else {
//                 controller.selectCategory(item);
//               }
//             },
//             child: Container(
//               margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//               padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//               decoration: BoxDecoration(
//                 color: controller.searchType == 'restaurant'
//                     ? (controller.selectedCuisine == item ? ThemeColors.baseThemeColor : Colors.grey)
//                     : (controller.selectedCategory == item ? ThemeColors.baseThemeColor : Colors.grey),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Center(
//                 child: Text(
//                   item,
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       );
//     },
//   ),
// ),

              // filters for  categories
              // Categories Section (Same as before)
                Container(
                                    margin: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
            height: 50,
            child: GetBuilder<search.SearchController>(
              builder: (controller) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  // itemCount: controller.cusines.length,
                   itemCount: controller.searchType == 'restaurant' ? controller.cusines.length : controller.categories.length,
                  itemBuilder: (context, index) {
                    // final category = controller.cusines[index];
                    final category = controller.searchType == 'restaurant'
              ? controller.cusines[index]
              : controller.categories[index];

                    return GestureDetector(
                      onTap: () {
                        if (controller.searchType == 'restaurant') {
                controller.selectCusines(category);
              } else {
                controller.selectCategory(category);
              }
                        // controller.selectCusines(category);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                          // color: controller.selectCusine == category
                          //     ? ThemeColors.baseThemeColor
                          //     : Colors.grey,
                            color: controller.searchType == 'restaurant'
                    ? (controller.selectCusine == category ? ThemeColors.baseThemeColor : Colors.grey)
                    : (controller.selectedCategory == category ? ThemeColors.baseThemeColor : Colors.grey),
                          // borderRadius: BorderRadius.circular(20),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            category,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          
          //    Container(
          //       child:Text("Menu items")
          //     ),
          //     // filters for  categories
          //     // // Categories Section (Same as before)
          // Container(
          //   height: 50,
          //   child: GetBuilder<search.SearchController>(
          //     builder: (controller) {
          //       return ListView.builder(
                  
          //         scrollDirection: Axis.horizontal,
          //         itemCount: controller.categories.length,
          //         itemBuilder: (context, index) {
          //           final category = controller.categories[index];
                    
          //           return GestureDetector(
          //             onTap: () {
          //               controller.selectCategory(category);
          //             },
          //             child: Container(
          //               margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          //               padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          //               decoration: BoxDecoration(
          //                 color: controller.selectedCategory == category
          //                     ? ThemeColors.baseThemeColor
          //                     : Colors.grey,
          //                 // borderRadius: BorderRadius.circular(20),
          //                 borderRadius: BorderRadius.circular(20),
          //               ),
          //               child: Center(
          //                 child: Text(
          //                   category,
          //                   style: TextStyle(
          //                     color: Colors.white,
          //                     fontWeight: FontWeight.bold,
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           );
          //         },
          //       );
          //     },
          //   ),
          // ),
              
              // Search bar
              Container(
                padding: EdgeInsets.only(top: 5, right: 10, left: 10),
                child: Row(
                  children: [
                    SizedBox(
                      height: 22.0,
                      width: 22.0,
                      child: IconButton(
                        padding: EdgeInsets.all(0.0),
                        color: ThemeColors.baseThemeColor,
                        icon: Icon(Icons.arrow_back, size: 25.0),
                        onPressed: () => Get.back(),
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        color: Colors.grey.shade200,
                        child: Container(
                          padding: EdgeInsets.only(left: 14),
                          height: 40,
                          child: TextFormField(
                            controller: searchTextController,
                            textAlignVertical: TextAlignVertical.center,
                            keyboardType: TextInputType.text,
                            autofocus: false,
                            textInputAction: TextInputAction.search,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(top: 5),
                              isCollapsed: true,
                              border: InputBorder.none,
                              fillColor: Colors.white,
                              hintText: "What are you looking for",
                              hintStyle: TextStyle(
                                color: Colors.grey.shade500,
                              ),
                              suffixIcon: Icon(
                                Icons.search,
                                color: Colors.grey.shade500,
                              ),
                            ),
                            onFieldSubmitted: (value) {
                              setState(() {
                                restaurantName = value.toString();
                              });
                              searchController.getSearch(
                                  restaurantName, menu[widget.type].toLowerCase());
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),

              // Display content based on the search results
              Expanded(
                child: GetBuilder<search.SearchController>(
                  init: search.SearchController(),
                  builder: (searchController) {
                    if (searchController.searchLoader) {
                      return ViewRestaurantPageSearchShimmer();
                    }

                    if (searchController.filteredRestaurantsList.isNotEmpty ) {
                      // Display Restaurants
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: searchController.filteredRestaurantsList.length,
                        itemBuilder: (context, index) {
                          final restaurant = searchController.filteredRestaurantsList[index];
                          return Padding(
                            padding: const EdgeInsets.only(
                                bottom: 5, left: 10, right: 10),
                            child: GestureDetector(
                              onTap: () {
                                Get.to(RestaurantDetails(
                                  id: restaurant.id,
                                ));
                              },
                              child: Card(
                                elevation: 1,
                                margin: EdgeInsets.all(2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(2)),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    // Add image
                                    CachedNetworkImage(
                                      imageUrl: restaurant.image!,
                                      imageBuilder: (context, imageProvider) => Container(
                                        padding: EdgeInsets.only(bottom: 15),
                                        height: MediaQuery.of(context).size.height / 4.5,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(2.0),
                                              topRight: Radius.circular(2.0)),
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      placeholder: (context, url) => Shimmer.fromColors(
                                        child: Container(
                                            height: 130,
                                            width: 200,
                                            color: Colors.grey),
                                        baseColor: Colors.grey[300]!,
                                        highlightColor: Colors.grey[400]!,
                                      ),
                                      errorWidget: (context, url, error) => Icon(Icons.error),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                                      child: ListTile(
                                        title: Padding(
                                          padding: const EdgeInsets.only(bottom: 5),
                                          child: Text(
                                            restaurant.name!,
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              // restaurant.description!,
                                              parseDescription(restaurant.description!)['description']??"null",
                                              style: TextStyle(fontSize: 13),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(height: 5),
                                            
                                            Text(
                                              restaurant.address!,
                                              style: TextStyle(fontSize: 13),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(height: 8),
                                            Row(
                                              children: [
                                                RatingBar.builder(
                                                  itemSize: 20,
                                                  initialRating: restaurant.avgRating!.toDouble(),
                                                  minRating: 1,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  itemBuilder: (context, _) => Icon(
                                                    Icons.star,
                                                    color: ThemeColors.baseThemeColor,
                                                  ),
                                                  onRatingUpdate: (rating) {
                                                    print(rating);
                                                  },
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 10.0),
                                                  child: Text(
                                                    "(${restaurant.avgRatingUser!.toInt()}) reviews",
                                                    style: TextStyle(color: Colors.grey),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                    else if (searchController.restaurantList.isNotEmpty ) {
                      // Display Restaurants
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: searchController.restaurantList.length,
                        itemBuilder: (context, index) {
                          final restaurant = searchController.restaurantList[index];
                          return Padding(
                            padding: const EdgeInsets.only(
                                bottom: 5, left: 10, right: 10),
                            child: GestureDetector(
                              onTap: () {
                                Get.to(RestaurantDetails(
                                  id: restaurant.id,
                                ));
                              },
                              child: Card(
                                elevation: 1,
                                margin: EdgeInsets.all(2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(2)),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    // Add image
                                    CachedNetworkImage(
                                      imageUrl: restaurant.image!,
                                      imageBuilder: (context, imageProvider) => Container(
                                        padding: EdgeInsets.only(bottom: 15),
                                        height: MediaQuery.of(context).size.height / 4.5,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(2.0),
                                              topRight: Radius.circular(2.0)),
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      placeholder: (context, url) => Shimmer.fromColors(
                                        child: Container(
                                            height: 130,
                                            width: 200,
                                            color: Colors.grey),
                                        baseColor: Colors.grey[300]!,
                                        highlightColor: Colors.grey[400]!,
                                      ),
                                      errorWidget: (context, url, error) => Icon(Icons.error),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                                      child: ListTile(
                                        title: Padding(
                                          padding: const EdgeInsets.only(bottom: 5),
                                          child: Text(
                                            restaurant.name!,
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                             parseDescription(restaurant.description!)['description']??"null",
                                              
                                              style: TextStyle(fontSize: 13),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(height: 5),
                                            
                                            Text(
                                              restaurant.address!,
                                              style: TextStyle(fontSize: 13),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(height: 8),
                                            Row(
                                              children: [
                                                RatingBar.builder(
                                                  itemSize: 20,
                                                  initialRating: restaurant.avgRating!.toDouble(),
                                                  minRating: 1,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  itemBuilder: (context, _) => Icon(
                                                    Icons.star,
                                                    color: ThemeColors.baseThemeColor,
                                                  ),
                                                  onRatingUpdate: (rating) {
                                                    print(rating);
                                                  },
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 10.0),
                                                  child: Text(
                                                    "(${restaurant.avgRatingUser!.toInt()}) reviews",
                                                    style: TextStyle(color: Colors.grey),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                     else if (searchController.filteredMenuItemList.isNotEmpty) {
                      // Display Menu Items
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: searchController.filteredMenuItemList.length,
                        itemBuilder: (context, index) {
                          final menuItem = searchController.filteredMenuItemList[index];
                          return Padding(
                            padding: const EdgeInsets.only(
                                bottom: 5, left: 10, right: 10),
                    child:GestureDetector(
                      onTap: () {
                                Get.to(RestaurantDetails(
                                  id: menuItem.restaurantId
                                ));
                              },
                           child:Container(
                          
                            margin: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.01),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: Offset(0, 1), // Shadow offset
                                  ),
                                ],
                              ),
                              child: Card(
                                  elevation: 10, // Increased elevation for a more pronounced shadow
                                
                              // margin: EdgeInsets.all(20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(20)),
                              ),
                              child: Column(
                                
                                children: <Widget>[
                                  
                                  // Add image
                                  CachedNetworkImage(
                                    imageUrl: menuItem.image!,
                                    imageBuilder: (context, imageProvider) => Container(
                                      padding: EdgeInsets.only(bottom: 15),
                                      height: MediaQuery.of(context).size.height / 4.5,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20.0),
                                            topRight: Radius.circular(20.0)),
                         
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.fitWidth,
                                        ),
                                      ),
                                    ),
                                    placeholder: (context, url) => Shimmer.fromColors(
                                      child: Container(
                                          height: 130,
                                          width: 200,
                                          color: Colors.grey),
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[400]!,
                                    ),
                                    errorWidget: (context, url, error) => Icon(Icons.error),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                                    child: ListTile(
                                      title: Padding(
                                        padding: const EdgeInsets.only(bottom: 5),
                                        child: Text(
                                          menuItem.name!,
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            menuItem.description!,
                                           
                                            style: TextStyle(fontSize: 13),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 5),
                                          _buildRatingStars(double.parse(menuItem.ratings??"0")),
                                         
                                            SizedBox(height: 5),
                                          Text(
                                            "Price: ${menuItem.unitPrice!}",
                                            style: TextStyle(fontSize: 13),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 8),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                         
                           ),
                           ),

                            );
                        },
                      );
                    } 
                    else if (searchController.menuItemList.isNotEmpty) {
                      // Display Menu Items
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: searchController.menuItemList.length,
                        itemBuilder: (context, index) {
                          final menuItem = searchController.menuItemList[index];
                          return Padding(
                            padding: const EdgeInsets.only(
                                bottom: 5, left: 10, right: 10),
                    child:GestureDetector(
                      onTap: () {
                                Get.to(RestaurantDetails(
                                  id: menuItem.restaurantId
                                ));
                              },
                           child:Container(
                          
                            margin: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.01),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: Offset(0, 1), // Shadow offset
                                  ),
                                ],
                              ),
                              child: Card(
                                  elevation: 10, // Increased elevation for a more pronounced shadow
                                
                              // margin: EdgeInsets.all(20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(20)),
                              ),
                              child: Column(
                                
                                children: <Widget>[
                                  
                                  // Add image
                                  CachedNetworkImage(
                                    imageUrl: menuItem.image!,
                                    imageBuilder: (context, imageProvider) => Container(
                                      padding: EdgeInsets.only(bottom: 15),
                                      height: MediaQuery.of(context).size.height / 4.5,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20.0),
                                            topRight: Radius.circular(20.0)),
                         
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.fitWidth,
                                        ),
                                      ),
                                    ),
                                    placeholder: (context, url) => Shimmer.fromColors(
                                      child: Container(
                                          height: 130,
                                          width: 200,
                                          color: Colors.grey),
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[400]!,
                                    ),
                                    errorWidget: (context, url, error) => Icon(Icons.error),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                                    child: ListTile(
                                      title: Padding(
                                        padding: const EdgeInsets.only(bottom: 5),
                                        child: Text(
                                          menuItem.name!,
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            menuItem.description!,
                                           
                                            style: TextStyle(fontSize: 13),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 5),
                                          _buildRatingStars(double.parse(menuItem.ratings??"0")),
                                         
                                            SizedBox(height: 5),
                                          Text(
                                            "Price: ${menuItem.unitPrice!}",
                                            style: TextStyle(fontSize: 13),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 8),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                         
                           ),
                           ),

                            );
                        },
                      );
                    }
                    else {
                      // No results found
                      return SearchErrorPage();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}

  Widget _buildRatingStars(double? rating) {
    // Default to 5 stars
    int totalStars = 5;
    int fullStars = 0;
    int halfStars = 0;
    int emptyStars = totalStars;

    if (rating != null) {
      fullStars = rating.floor();
      halfStars = (rating - fullStars >= 0.5) ? 1 : 0;
      emptyStars = totalStars - fullStars - halfStars;
    }

    return Row(
      children: List.generate(totalStars, (index) {
        if (index < fullStars) {
          return Icon(Icons.star, color: Colors.orange, size: 16);
        } else if (index < fullStars + halfStars) {
          return Icon(Icons.star_half, color: Colors.orange, size: 16);
        } else {
          return Icon(Icons.star_border, color: Colors.grey, size: 16);
        }
      }),
    );
  }

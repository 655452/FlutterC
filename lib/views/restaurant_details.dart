import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_ex/views/product_detail_page.dart';
import 'package:food_ex/views/promo_voucer_widget.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../Controllers/global-controller.dart';
import '/Controllers/cart_controller.dart';
import '/Controllers/restaurant_details_controller.dart';
import '/utils/theme_colors.dart';
import '/views/cart.dart';
import '/widgets/description_container.dart';
import '/widgets/img_container_res_details.dart';
import 'book_table.dart';

import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

class RestaurantDetails extends StatefulWidget {
  final int? id;

  RestaurantDetails({required this.id});
  


  @override
  State<StatefulWidget> createState() => _RestaurantDetailsState();
}

class _RestaurantDetailsState extends State<RestaurantDetails> {
  var mainHeight, mainWidth;
  final restaurantDetailsController = Get.put(RestaurantDetailsController());
  final cartController = Get.put(CartController());

// search bar4 // Step 1: Add a TextEditingController
  // final TextEditingController _searchController = TextEditingController();
ScrollController _scrollController = ScrollController(); // search bar
Map<String?, GlobalKey> menuKeys = {};

// to extract all the  categories

Future<void> ALLCategories() async {
  var restaurantName=restaurantDetailsController.restaurantName;
 
  print(restaurantName);
  final url = 'https://woich.in/restaurant/sugar-twooth';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final document = parse(response.body);
    extractCategoriesAndItems(document);
  } else {
    print('Failed to fetch HTML: ${response.statusCode}');
  }
}

void extractCategoriesAndItems(document) {
  final categories = document.querySelectorAll('.product-category');

  for (final category in categories) {
    // Get the category title
    final categoryTitle = category.querySelector('.product-category-title')?.text.trim() ?? 'No Title';
    // print('Category: $categoryTitle');

    // Get all product items within this category
    final items = category.querySelectorAll('.product-card');
    for (final item in items) {
      // Get the item name
      final itemName = item.querySelector('.product-card-title')?.text.trim() ?? 'No Name';
      // print('  Item: $itemName');
    }
    print('');  // Add a blank line for readability
  }
}


  

  Future<Null> _refresh() async {
    restaurantDetailsController.getRestaurant(widget.id!);
    await Future.delayed(new Duration(seconds: 3));
  }

  @override
  void initState() {
    restaurantDetailsController.getRestaurant(widget.id!);
    print('getting all Categories');
                                      // ALLCategories();



 // Clean up the controller when the widget is disposed.
    super.initState();
  }


  
  @override
  Widget build(BuildContext context) {
    mainHeight = MediaQuery.of(context).size.height;
    mainWidth = MediaQuery.of(context).size.width;

// Step 2: Initialize GlobalKeys for each menu item
  var menuItemList = restaurantDetailsController.menuItemList;
    for (var menuItem in menuItemList) {
      menuKeys[menuItem.name] = GlobalKey();
      // print(menuKeys[menuItem.name]);
    }

    return GetBuilder<RestaurantDetailsController>(
        init: RestaurantDetailsController(),
        builder: (restaurant) => RefreshIndicator(
              onRefresh: _refresh,
              child: Scaffold(
                floatingActionButton: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                          padding: const EdgeInsets.only(top: 60),
                          child: GetBuilder<CartController>(
                            init: CartController(),
                            builder: (cart) => Stack(children: [
                              SizedBox(
                                  height: 45,
                                  width: 45,
                                  child: FittedBox(
                                      child: FloatingActionButton(
                                    heroTag: "cart",
                                    onPressed: () {
                                      Get.to(() => CartPage());
                                    },
                                    child: Icon(
                                      Icons.shopping_cart,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                    backgroundColor: ThemeColors.baseThemeColor,
                                  ))),
                              new Positioned(
                                  child: new Stack(
                                children: <Widget>[
                                  new Icon(Icons.brightness_1,
                                      size: 20.0, color: Colors.orange),
                                  new Positioned(
                                      top: 4.0,
                                      right: 5.5,
                                      child: new Center(
                                        child: new Text(
                                          cart.totalQunty.toString(),
                                          style: new TextStyle(
                                              color: Colors.white,
                                              fontSize: 11.0,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      )),
                                ],
                              )),
                            ]),
                          )),
                    ),
                    restaurant.tableStatus == 5
                        ? Align(
                            alignment: Alignment.bottomRight,
                            child: FloatingActionButton.extended(
                              heroTag: 'BookTable',
                              backgroundColor: ThemeColors.baseThemeColor,
                              onPressed: () {
                                Get.to(
                                  () => BookTable(
                                    restaurantId: widget.id!,
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.library_books_outlined,
                                color: Colors.white,
                              ),
                              label: Text("Book table"),
                            ),
                          )
                        : SizedBox(
                            height: 0,
                          ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 60, left: 30),
                        child: SizedBox(
                          height: 45,
                          width: 45,
                          child: FittedBox(
                            child: FloatingActionButton(
                              heroTag: "backButton",
                              elevation: 5,
                              backgroundColor: ThemeColors.baseThemeColor,
                              onPressed: () {
                                Get.back();
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 32,
                        width: mainWidth,
                        color: ThemeColors.baseThemeColor,
                      ),
                      //Image_container
                      Container(
                        height: mainHeight / 4,
                        width: mainWidth,
                        child: restaurant.restaurantDetailsLoader
                            ? Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[400]!,
                                child: Container(
                                  padding: EdgeInsets.only(bottom: 15),
                                  height: mainHeight / 3.5,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(2.0),
                                        topRight: Radius.circular(2.0)),
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/farmhouse.jpg"),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              )
                            : ImageContainer(img: restaurant.restaurantImage),
                      ),
                      //description container
                      DescriptionContainer(),
                      restaurant.vouchersList.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: PromoText(
                                  voucher: restaurant.vouchersList[0]),
                            )
                          : Container(),
                      Column(
                        children: [
                          // adding search bar
                          Padding(
                                  padding: const EdgeInsets.only(left:30,right: 30,top:30,bottom: 0),
                                  child: Container(
                                    height:44,
                                    child:TextField(
                                    // controller: _searchController,
                                    decoration: InputDecoration(
                                      labelText: 'Search Menu items',
                                      labelStyle: TextStyle(
                                        color:Colors.black,
                                        ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                        borderSide: BorderSide(color: Colors.grey, width: 2.0),
                                      ),
                                      suffixIcon: Icon(
                                          Icons.search,
                                          color: Color.fromARGB(255, 230, 32, 32), // This sets the color of the search icon
                                        ),
                                      
                                    ),
                                    // Step 3: Add the onChanged callback
                                    onSubmitted: (value) {
                                      print("Search input: $restaurant $value");
                                      print(restaurant.menuItemList);
                                       // Assuming restaurant is an instance of RestaurantDetailsController and has a menuItemList
                                       var menuItemList = restaurant.menuItemList;
                                      //  for (var menuItem in restaurant.menuItemList) {
                                      //         menuKeys[menuItem.name] = GlobalKey();
                                      //       }
                                      // print('getting all Categories');
                                      // ALLCategories();
                                       // Loop over the menuItemList and check if the entered value matches any menu item's name
                                        for (var category in restaurant.categoryList) {
                                            for (var item in category.items) {
                                              print("Processing item: ${item.name}");
                                            if (item.name!.toLowerCase().contains(value.toLowerCase())) {
                                               var context = menuKeys[item.name]?.currentContext;
                                              print(context);
                                              if (context != null) {
                                                Scrollable.ensureVisible(
                                                  context,
                                                  duration: Duration(seconds: 1),
                                                  curve: Curves.easeInOut,
                                                );
                                              }
                                              } else {
                                                print("No matching item found for: ${item.name}");
                                              }
                                            }
                                          }
                                      
                                    },
                                  ),
                                )
                                  ),
                                

                          ListView.builder(
  physics: NeverScrollableScrollPhysics(),
  shrinkWrap: true,
  controller: _scrollController,
  itemCount: restaurant.categoryList.length,
  itemBuilder: (context, categoryIndex) {
    final category = restaurant.categoryList[categoryIndex];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            category.name,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: category.items.length,
          itemBuilder: (context, itemIndex) {
            final menuItem = category.items[itemIndex];
            return Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 10),
              child: InkWell(
                
                onTap: () {
                  // Navigation or any other action
                },
                child: Container(
                  width: mainWidth,
                  
                  child: Card(
                    key: menuKeys[menuItem.name], // Assign GlobalKey
                    elevation: 1,
                    shadowColor: Colors.blueGrey,
                    margin: EdgeInsets.only(bottom: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Row(
                      children: [
                        if (menuItem.image != null)
                          CachedNetworkImage(
                            imageUrl: menuItem.image!,
                            imageBuilder: (context, imageProvider) => Container(
                              width: mainWidth / 3.8,
                              height: mainHeight / 8,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    bottomLeft: Radius.circular(10.0)),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[400]!,
                              child: Container(
                                width: mainWidth / 3.8,
                                height: mainHeight / 8.5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: AssetImage("assets/images/farmhouse.jpg"),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                        Expanded(
                          child: Container(
                            key: menuKeys[menuItem.name], // Assign GlobalKey
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        menuItem.name,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    if (menuItem.unitPrice != null)
                                      Text(
                                        "₹ ${menuItem.unitPrice}",
                                        style: TextStyle(fontSize: 13),
                                      ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                if (menuItem.description != null)
                                  Text(
                                    menuItem.description!,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  },
),
   ],
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}



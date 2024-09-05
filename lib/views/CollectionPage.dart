import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../Controllers/CollectionController.dart';
import '/utils/theme_colors.dart';
import '/views/restaurant_details.dart'; // Ensure this import points to the correct file
import 'package:carousel_slider/carousel_slider.dart';
class CollectionPage extends StatelessWidget {
  final collectionController = Get.put(CollectionController());
  final ScrollController _scrollController = ScrollController();

  CollectionPage() {
    // Add scroll listener to the controller
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // No need to trigger load more since we are only using static data
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu Items Collection'),
        backgroundColor: ThemeColors.baseThemeColor,
      ),
      body: Column(
        children: [
          // Filters Section
          Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          // Filters Section
          Expanded(
            flex: 4,
            child: Row(
              children: [
                // Filter Button
                
                // Rating Dropdown
                Expanded(
                  child: DropdownButton<double>(
                    value: collectionController.selectedRating,
                    items: [0.0, 1.0, 2.0, 3.0, 4.0, 5.0].map((rating) {
                      return DropdownMenuItem<double>(
                        value: rating,
                        child: Text('$rating stars'),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        collectionController.updateRating(value);
                      }
                    },
                    hint: Text('Rating'),
                    isExpanded: true, // Ensures dropdown occupies available space
                  ),
                ),
                SizedBox(width: 10),
                // Price Range Dropdown
                Expanded(
                  child: DropdownButton<double>(
                    value: collectionController.selectedPriceRange,
                    items: [0.0, 100.0, 200.0, 300.0, 400.0, 500.0, collectionController.maxPrice].map((price) {
                      return DropdownMenuItem<double>(
                        value: price,
                        child: Text('Up to ₹$price'),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        collectionController.updatePriceRange(value);
                      }
                    },
                    hint: Text('Price '),
                    isExpanded: true, // Ensures dropdown occupies available space
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 10), // Space between filters and categories
          // Categories Section
          Expanded(
            flex: 6,
            child: Container(
              height: 50,
              child: GetBuilder<CollectionController>(
                builder: (controller) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.categories.length,
                    itemBuilder: (context, index) {
                      final category = controller.categories[index];
                      return GestureDetector(
                        onTap: () {
                          controller.selectCategory(category);
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                          
                          
                          child: Center(
                            child:Chip(
          label: Text(category,
          selectionColor: Colors.white,),
          backgroundColor:  controller.selectedCategory == category
                                ? ThemeColors.baseThemeColor
                                : Colors.grey,
          labelStyle: TextStyle(color: Colors.white, fontSize: 12),
        ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
            
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceAround,
          //     children: [
          //       // Container(
          //       //   margin: EdgeInsets.symmetric(horizontal: 0),
          //       // padding: EdgeInsets.symmetric(horizontal:10 , vertical: 0),
          //       // decoration: BoxDecoration(
          //       //   color: Colors.grey, // Same color as category button
          //       //   borderRadius: BorderRadius.circular(20),
          //       // ),
                
          //       //   child: DropdownButton<double>(
          //       //   value: collectionController.selectedRating,
          //       //   items: [0.0, 1.0, 2.0, 3.0, 4.0, 5.0].map((rating) {
          //       //     return DropdownMenuItem<double>(
          //       //       value: rating,
          //       //       child: Text('$rating stars'),
          //       //     );
          //       //   }).toList(),
          //       //   onChanged: (value) {
          //       //     if (value != null) {
          //       //       collectionController.updateRating(value);
          //       //     }
          //       //   },
          //       //   hint: Text('Select Rating',
          //       //    style: TextStyle(
          //       //       color: Colors.white,
          //       //       fontWeight: FontWeight.bold,
          //       //     ),),
          //       // ),
          //       // ),
          //       // // Rating Dropdown
               
          //       // Price Range Dropdown
          //       // Container(
          //       //     margin: EdgeInsets.symmetric(horizontal: 0),
          //       // padding: EdgeInsets.symmetric(horizontal:10 , vertical: 0),
          //       // decoration: BoxDecoration(
          //       //   color: Colors.grey, // Same color as category button
          //       //   borderRadius: BorderRadius.circular(20),
          //       // ),
                
          //       //   child:DropdownButton<double>(
          //       //   value: collectionController.selectedPriceRange,
          //       //   items: [0.0, 100.0, 200.0, 300.0, 400.0, 500.0, collectionController.maxPrice].map((price) {
          //       //     return DropdownMenuItem<double>(
          //       //       value: price,
          //       //       child: Text('Up to ₹$price'),
          //       //     );
          //       //   }).toList(),
          //       //   onChanged: (value) {
          //       //     if (value != null) {
          //       //       collectionController.updatePriceRange(value);
          //       //     }
          //       //   },
          //       //   hint: Text('Select Price Range',
          //       //    style: TextStyle(
          //       //       color: Colors.white,
          //       //       fontWeight: FontWeight.bold,
          //       //     ),),
          //       // ),
          //       // ),

                
          //     ],
          //   ),
          // ),
          // // Categories Section (Same as before)
          // Container(
          //   height: 50,
          //   child: GetBuilder<CollectionController>(
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
          // // Menu Items Grid
          Expanded(
            child: GetBuilder<CollectionController>(
              builder: (controller) {
                if (controller.isLoading && controller.filteredMenuItems.isEmpty) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  final menuItemList = controller.filteredMenuItems;
                  return GridView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(10.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Number of columns in the grid
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 5.0,
                      childAspectRatio: 3 / 4, // Adjust to fit image and text
                    ),
                    itemCount: menuItemList.length,
                    itemBuilder: (context, index) {
                      final menuItem = menuItemList[index];
                      return GestureDetector(
                        onTap: () {
                          // Ensure `menuItem.restaurantId` is not null
                          if (menuItem.restaurantId != null) {
                            Get.to(() => RestaurantDetails(id: menuItem.restaurantId!));
                          }
                        },
                        
                        child: Card(
                          
                          elevation: 1,
                          shadowColor: Colors.blueGrey,
                          margin: EdgeInsets.only(bottom: 5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Column(
                            
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              
                              if (menuItem.image != null)
                                Expanded(
                                  child: MenuItemImageCarousel(
                                    images: menuItem.image!,  // Ensure this is not null
                                    mainWidth: 100,
                                    mainHeight: 1000,
                                  ),
                                ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      menuItem.name ?? 'Unknown',  // Provide a default value
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 5),
                                    if (menuItem.unitPrice != null)
                                      Text(
                                        "₹ ${menuItem.unitPrice}",
                                        style: TextStyle(fontSize: 13),
                                      ),
                                    SizedBox(height: 5),
                                    _buildRatingStars(menuItem.ratings),
                                    SizedBox(height: 10),
                                    // New widget to display categories
                                  // if (menuItem.category != null && menuItem.category!.isNotEmpty)
                                  //   MenuItemCategories(categories2: menuItem.category!),
                                  //   SizedBox(height: 10),
                                    if (menuItem.description != null)
                                      GestureDetector(
                                        onTap: () {
                                          _showDescriptionDialog(context, menuItem.description!,menuItem.name!);
                                        },
                                        child: Text(
                                          menuItem.description!,
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    
                                  ],
                                ),
                              ),
                              
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MenuItemCategories extends StatelessWidget {
  final List<String> categories2;

  const MenuItemCategories({Key? key, required this.categories2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,  // Horizontal space between categories
      children: categories2.map((category) {
        return Chip(
          label: Text(category,
          selectionColor: Colors.black,),
          backgroundColor: Colors.blueGrey.shade100,
          labelStyle: TextStyle(color: Colors.black, fontSize: 12),
        );
      }).toList(),
    );
  }
}
// start ratings
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


  void _showDescriptionDialog(BuildContext context, String description,String name) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(name),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(description),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }




class MenuItemImageCarousel extends StatelessWidget {
  final List<String> images;
  final double mainWidth;
  final double mainHeight;

  MenuItemImageCarousel({
    required this.images,
    required this.mainWidth,
    required this.mainHeight,
  });

  @override
  Widget build(BuildContext context) {
    // Check if there's only one image
    if (images.length == 1) {
      return CachedNetworkImage(
  imageUrl: "https://woich.in/" + images[0],
  imageBuilder: (context, imageProvider) => Stack(
    fit: StackFit.expand,
    children: [
      // Image part
      Container(
        width: mainWidth / 3.8,
        height: mainHeight / 8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      // Gradient overlay part
      Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
          height: mainHeight / 8 /3, // Adjust height of the gradient overlay
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.transparent, Colors.black54],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
          ),
        ),
      ),
    ],
  ),
  placeholder: (context, url) => Center(child: CircularProgressIndicator()),
  errorWidget: (context, url, error) => Icon(Icons.error),
);

    } else {
      // If there are more than one image, display the carousel
      return SizedBox(
        
        width: mainWidth / 3.8,
        height: mainHeight / 8,
        child: CarouselSlider(
          
          options: CarouselOptions(
            
            height: mainHeight / 8,
            viewportFraction: 1.0,
            enlargeCenterPage: true,
            enableInfiniteScroll: true,  // Enable circular, infinite scrolling
            autoPlay: true,  // Enable auto-play for smoother transitions
            autoPlayInterval: Duration(seconds: 3),  // Duration for auto-play
            autoPlayCurve: Curves.fastOutSlowIn,  // Smooth curve effect
            scrollDirection: Axis.horizontal,  // Scroll direction
          ),
          items: images.map((imageUrl) {
            
            return CachedNetworkImage(
                  imageUrl: "https://woich.in/" +imageUrl,
                  imageBuilder: (context, imageProvider) => Stack(
                    fit: StackFit.expand,
                    children: [
                      // Image part
                      Container(
                        width: mainWidth / 3.8,
                        height: mainHeight / 8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all( Radius.circular(10)),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // Gradient overlay part
                     
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: mainHeight / 8 / 3, // Adjust height of the gradient overlay
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.transparent, Colors.black54],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
                          ),
                        ),
                      ),
                       
                    ],
                    
                  ),
                  
                  placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                );

          }).toList(),
          
        ),
        
      );
    }
  }
}

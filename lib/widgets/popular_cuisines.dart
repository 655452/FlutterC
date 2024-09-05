// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import '/Controllers/cuisine_controller.dart';
// import '/theme/styles.dart';
// import '/views/cuisine_all_restaurants.dart';
// import 'package:get/get.dart';
// import 'package:shimmer/shimmer.dart';

// class Cuisines extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _CuisinesState();
//   }
// }

// class _CuisinesState extends State<Cuisines> {
//   var mainWidth, mainHeight;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     mainHeight = MediaQuery.of(context).size.height;
//     mainWidth = MediaQuery.of(context).size.width;

//     // Calculate grid height based on screen width
//     final gridHeight = (mainWidth / 4) * 2 + 10;

//     return GetBuilder<CuisineController>(
//       init: CuisineController(),
//       builder: (cuisines) => RefreshIndicator(
//         onRefresh: cuisines.onRefreshScreen,
//         child: Container(
//           margin: EdgeInsets.only(top: 10, right: 10, bottom: 0, left: 10),
//           height: gridHeight, // Set the height of the GridView
//           child: GridView.builder(
//             physics: AlwaysScrollableScrollPhysics(), // Enables scrolling
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 3, // Number of items in a row
//               crossAxisSpacing: 10.0, // Horizontal space between grid items
//               mainAxisSpacing: 20.0, // Vertical space between grid items
//               childAspectRatio: 1.8, // Adjust the card's aspect ratio
//             ),
//             itemCount: cuisines.cuisineList.length > 6 ? 6 : cuisines.cuisineList.length, // Limit to top 6 cuisines
//             itemBuilder: (context, index) {
//               return InkWell(
//                 onTap: (() {
//                   Get.to(() => CuisineAllRestaurents(
//                         cuisineId: cuisines.cuisineList[index].id,
//                         cuisineTitle: cuisines.cuisineList[index].name,
//                       ));
//                 }),
//                 child: Stack(
//                   clipBehavior: Clip.none, // Allow the image to overflow the card
//                   children: [
//                     Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(20.0),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.2),
//                             spreadRadius: 2,
//                             blurRadius: 10,
//                             offset: Offset(0, 5),
//                           ),
//                         ],
//                       ),
//                       child: Padding(
//                         padding: EdgeInsets.only(top: mainWidth / 14), // Adjust padding to position the image correctly
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             Text(
//                               "${cuisines.cuisineList[index].name}",
//                               style: customParagraph,
//                               textAlign: TextAlign.center,
//                             ),
//                             SizedBox(height: 10),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                       top: -mainWidth / 14, // Position the image to overlap the card
//                       left: (mainWidth / 4 - mainWidth / 7) / 2, // Center the image horizontally
//                       child: Container(
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle, // Circular shape
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.2), // Shadow color
//                               spreadRadius: 2, // Spread radius
//                               blurRadius: 10, // Blur radius for a soft shadow
//                               offset: Offset(0, 5), // Position the shadow slightly below the image
//                             ),
//                           ],
//                         ),
//                         child: ClipOval(
//                           child: CachedNetworkImage(
//                             imageUrl: cuisines.cuisineList[index].image!,
//                             imageBuilder: (context, imageProvider) => Image(
//                               image: imageProvider,
//                               height: mainWidth / 7, // Adjust the image size as needed
//                               width: mainWidth / 7, // Adjust the image size as needed
//                               fit: BoxFit.cover, // Ensure the image covers the entire circle
//                             ),
//                             placeholder: (context, url) => Shimmer.fromColors(
//                               child: Container(
//                                 height: mainWidth / 7,
//                                 width: mainWidth / 7,
//                                 decoration: BoxDecoration(
//                                   color: Colors.grey,
//                                   shape: BoxShape.circle, // Placeholder should also be circular
//                                 ),
//                               ),
//                               baseColor: Colors.grey[300]!,
//                               highlightColor: Colors.grey[400]!,
//                             ),
//                             errorWidget: (context, url, error) => Container(
//                               height: mainWidth / 7,
//                               width: mainWidth / 7,
//                               decoration: BoxDecoration(
//                                 color: Colors.grey,
//                                 shape: BoxShape.circle,
//                               ),
//                               child: Icon(Icons.error),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

//  previous Structure of categories /cuisines
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '/Controllers/cuisine_controller.dart';
import '/utils/theme_colors.dart';
import '/views/cuisine_all_restaurants.dart';
import '/widgets/shimmer/popular_cuisines_shimmer.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class Cuisines extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CuisineState();
}

class _CuisineState extends State<Cuisines> {
  var mainHeight, mainWidth;

  @override
  Widget build(BuildContext context) {
    mainHeight = MediaQuery.of(context).size.height;
    mainWidth = MediaQuery.of(context).size.width;

    return GetBuilder<CuisineController>(
        init: CuisineController(),
        builder: (cuisine) => cuisine.cuisineLoader
            ? CuisineShimmer()
            : Container(
                height: mainHeight / 5.5,
                //width: mainWidth/3,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: cuisine.cuisineList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (() {
                        Get.to(() => CuisineAllRestaurents(
                            cuisineId: cuisine.cuisineList[index].id,
                            cuisineTitle: cuisine.cuisineList[index].name));
                      }),
                      child: Container(
                          // padding: EdgeInsets.only(left: 15),
                                          padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                          width: mainWidth / 2,
                          child: Stack(children: [
                         CachedNetworkImage(
  imageUrl: cuisine.cuisineList[index].image!,
  imageBuilder: (context, imageProvider) => Container(
    height: 130, // You can adjust the height as needed
    width: 200, // You can adjust the width as needed
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15), // Rounded corners
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2), // Shadow color
          spreadRadius: 2, // Spread radius
          blurRadius: 10, // Blur radius for a soft shadow
          offset: Offset(0, 5), // Position the shadow slightly below the image
        ),
      ],
      image: DecorationImage(
        image: imageProvider,
        fit: BoxFit.cover, // Ensuring the image covers the entire container
      ),
    ),
  ),
  placeholder: (context, url) => Shimmer.fromColors(
    child: Container(
      height: 130,
      width: 200,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(15), // Rounded corners for placeholder
      ),
    ),
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[400]!,
  ),
  errorWidget: (context, url, error) => Container(
    height: 130,
    width: 200,
    decoration: BoxDecoration(
      color: Colors.grey,
      borderRadius: BorderRadius.circular(15), // Rounded corners for error widget
    ),
    child: Icon(Icons.error),
  ),
),

                           Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: ThemeColors.baseThemeColor,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10))),
                                padding: EdgeInsets.all(5.0),
                                margin: EdgeInsets.only(top: 10.0),
                                child: Text(
                                  '${cuisine.cuisineList[index].name}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ])),
                    );
                  },
                ),
              ));
  }
}

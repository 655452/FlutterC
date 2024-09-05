import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '/Controllers/category_Controller.dart';
import '/theme/styles.dart';
import '/views/category_all_restaurants.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class CategoriesList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CategoriesListState();
  }
}

class _CategoriesListState extends State<CategoriesList> {
  var mainWidth, mainHeight;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mainHeight = MediaQuery.of(context).size.height;
    mainWidth = MediaQuery.of(context).size.width;

    final gridHeight = (mainWidth / 4) * 2 + 10.0;

    return GetBuilder<CategoryController>(
      init: CategoryController(),
      builder: (categories) => RefreshIndicator(
        onRefresh: categories.onRefreshScreen,
        child: Container(
          margin: EdgeInsets.only(top: 10, right: 10, bottom: 0),
          height: gridHeight,
          child: GridView.builder(
            physics: AlwaysScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: 0.8, // Adjusted aspect ratio for card layout
            ),
            itemCount: categories.categoriesList.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: (() {
                  Get.to(() => CateegoryAllRestaurents(
                        categoryId: categories.categoriesList[index].id,
                        categoryTitle: categories.categoriesList[index].title,
                      ));
                }),
                child: Stack(
                  clipBehavior: Clip.none, // Allow overflow of image
                  children: [
                    // Card containing the category title
                    Container(
                      padding: EdgeInsets.only(top: mainWidth / 14), // Add space for image above
                      margin: EdgeInsets.only(top: mainWidth / 14), // Adjust card position to fit image
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "${categories.categoriesList[index].title}",
                            style: customParagraph,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    // Positioned image, half outside the card
                    Positioned(
                      top: mainWidth / 200, // Moves image 50% outside the card
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: categories.categoriesList[index].image!,
                              imageBuilder: (context, imageProvider) => Image(
                                image: imageProvider,
                                height: mainWidth / 5,
                                width: mainWidth / 5,
                                fit: BoxFit.cover,
                              ),
                              placeholder: (context, url) => Shimmer.fromColors(
                                child: Container(
                                  height: mainWidth / 7,
                                  width: mainWidth / 7,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[400]!,
                              ),
                              errorWidget: (context, url, error) => Container(
                                height: mainWidth / 7,
                                width: mainWidth / 7,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.error),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

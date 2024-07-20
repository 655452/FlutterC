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

  Future<Null> _refresh() async {
    restaurantDetailsController.getRestaurant(widget.id!);
    await Future.delayed(new Duration(seconds: 3));
  }

  @override
  void initState() {
    restaurantDetailsController.getRestaurant(widget.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mainHeight = MediaQuery.of(context).size.height;
    mainWidth = MediaQuery.of(context).size.width;

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
                          ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: restaurant.menuItemList.length,
                              itemBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10, bottom: 10),
                                    child: InkWell(
                                      onTap: () {
                                        // Get.to(() => ProductsDetails(
                                        //     restaurantID:
                                        //         restaurant.restaurantID,
                                        //     deliveryCharge: restaurant
                                        //         .restaurantDeliveryCharge,
                                        //     menuItemID: restaurant
                                        //         .menuItemList[index].id));
                                      },
                                      child: Container(
                                          width: mainWidth,
                                          child: Card(
                                            elevation: 1,
                                            shadowColor: Colors.blueGrey,
                                            margin: EdgeInsets.only(bottom: 5),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                            ),
                                            child: Row(
                                              children: [
                                                CachedNetworkImage(
                                                  imageUrl: restaurant
                                                      .menuItemList[index]
                                                      .image!,
                                                  imageBuilder: (context,
                                                          imageProvider) =>
                                                      Container(
                                                    width: mainWidth / 3.8,
                                                    height: mainHeight / 8,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                      10.0),
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      10.0)),
                                                      image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.fill,
                                                        //alignment: Alignment.topCenter,
                                                      ),
                                                    ),
                                                  ),
                                                  placeholder: (context, url) =>
                                                      Shimmer.fromColors(
                                                    baseColor:
                                                        Colors.grey[300]!,
                                                    highlightColor:
                                                        Colors.grey[400]!,
                                                    child: Container(
                                                      width: mainWidth / 3.8,
                                                      height: mainHeight / 8.5,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        image: DecorationImage(
                                                          image: AssetImage(
                                                              "assets/images/farmhouse.jpg"),
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(Icons.error),
                                                ),

                                                //menu_description section
                                                Expanded(
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10,
                                                            vertical: 5),
                                                    child: Column(
                                                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              child: Flexible(
                                                                child: Text(
                                                                  '${restaurant.menuItemList[index].name}',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                // "${Get.find<GlobalController>().currencyCode}${restaurant.menuItemList[index].unitPrice}",
                                                                "₹ ${restaurant.menuItemList[index].unitPrice}",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 13,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(height: 20),
                                                        Text(
                                                          "${restaurant.menuItemList[index].description}",
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                            color: Colors.grey,
                                                          ),
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )),
                                    ),
                                  )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}

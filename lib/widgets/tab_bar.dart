import 'package:flutter/material.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import '/Controllers/restaurant_details_controller.dart';
import '/utils/theme_colors.dart';
import '/views/add_review.dart';
import '/views/location_view_page.dart';
import '/views/overview.dart';
import '/views/review_page.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class TabBarDemo extends StatelessWidget {
  TabBarDemo({Key? key}) : super(key: key);
  final restaurantDetailsController = Get.put(RestaurantDetailsController());

  @override
  Widget build(BuildContext context) {
    var mainHeight = MediaQuery.of(context).size.height;
    var mainWidth = MediaQuery.of(context).size.width;

    return GetBuilder<RestaurantDetailsController>(
        init: RestaurantDetailsController(),
        builder: (restaurant) => Container(
              padding: EdgeInsets.only(top: 100),
              width: mainWidth,
              height: mainHeight * 1.0,
              child: ContainedTabBarView(
                tabBarProperties: TabBarProperties(
                  isScrollable: true,
                  labelColor: ThemeColors.baseThemeColor,
                  unselectedLabelColor: Colors.grey,
                ),
                tabs: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 2.5),
                    child: Text(
                      'Review',
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 2.5),
                    child: Text(
                      'Overview',
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 2.5),
                    child: Text(
                      'Location',
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 2.5),
                    child: Text(
                      'Add Review',
                    ),
                  ),
                ],
                views: [
                  ReviewPage(),
                  OverViewPage(),
                  LocationViewPage(restaurant.lat, restaurant.long),
                  AddReviewPage(),
                ],
                onChange: (index) => print(index),
              ),
            ));
  }
}

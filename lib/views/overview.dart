import 'package:flutter/material.dart';
import '/Controllers/restaurant_details_controller.dart';
import '/views/no_overview_found_page.dart';
import 'package:get/get.dart';
import '/views/home_screen.dart';

class OverViewPage extends StatelessWidget {
  OverViewPage({Key? key}) : super(key: key);
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

  final restaurantDetailsController = Get.put(RestaurantDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<RestaurantDetailsController>(
            init: RestaurantDetailsController(),
            builder: (overview) => overview.restaurantDescription == null
                ? NoOverviewFoundPage()
                : Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Text(
                      // '${overview.restaurantDescription}',
                      parseDescription(overview.restaurantDescription!)['description']??"null",
                      style: TextStyle(fontSize: 15),
                    ),
                  )));
  }
}

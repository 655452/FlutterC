import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../utils/theme_colors.dart';
import '../views/restaurant_info.dart';
import '/Controllers/restaurant_details_controller.dart';
import '/utils/font_size.dart';
import '/widgets/shimmer/description_container_shimmer.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import 'package:url_launcher/url_launcher.dart';

class DescriptionContainer extends StatefulWidget {

  
  @override
  State<StatefulWidget> createState() {
    return _DescriptionContainerState();
  }
}

class _DescriptionContainerState extends State<DescriptionContainer> {
  var mainHeight, mainWidth;
  final restaurantDetailsController = Get.put(RestaurantDetailsController());

// taking  out instagram  facebook and  decsription from the  description text
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

  print('Original description: $description');
  print('Instagram handle: $instagram');
  print('Facebook handle: $facebook');
  print('Description: $desc');
  return {
    'instagram': instagram,
    'facebook': facebook,
    'description': desc,
  };
}
// for whatsapp these funxtion is  integrated
void launchWhatsApp({required String phone}) async {
  // final url = 'https://wa.me/$phone';
  final Uri url = Uri.parse('whatsapp://send?phone=$phone');
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}
//  latest Added
void launchInstagram({required String username}) async {
  final Uri urlApp = Uri.parse('instagram://user?username=$username');
  if (await canLaunchUrl(urlApp)) {
    await launchUrl(urlApp);
  } else {
    throw 'Could not launch $urlApp';
  }
}
//  updated
void launchFacebook({required String profileId}) async {
  final Uri urlApp = Uri.parse('fb://profile/$profileId');
  if (await canLaunchUrl(urlApp)) {
    await launchUrl(urlApp);
  } else {
    throw 'Could not launch $urlApp';
  }
}


  @override
  Widget build(BuildContext context) {
    mainHeight = MediaQuery.of(context).size.height;
    mainWidth = MediaQuery.of(context).size.width;
    return GetBuilder<RestaurantDetailsController>(
      init: RestaurantDetailsController(),
      builder: (des) => des.restaurantDetailsLoader
          ? DescriptionContainerShimmer()
          : Container(
              //height: 300,
              
    // final parsedData = parseDescription("${des.restaurantDescription}");
              width: mainWidth,
              child: Column(
                children: [
                  ListTile(
                    leading: CachedNetworkImage(
                      imageUrl: des.restaurantLogo!,
                      imageBuilder: (context, imageProvider) => Container(
                        height: 120,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.fill),
                        ),
                      ),
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[400]!,
                        child: Container(
                          height: 120,
                          width: 60,
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
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            "${des.restaurantName}",
                            maxLines: 2,
                            style: TextStyle(
                                fontSize: FontSize.xLarge,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                          SizedBox(width: 100), // Add space between icons
                        InkWell(
                          onTap: () {
                           launchWhatsApp(phone: "9833891281");
                          },
                          // child: Icon(
                          //   Icons.info_outline,
                          //   color: ThemeColors.baseThemeColor,
                          //   size: 30,
                          // ),
                          child: Image.network(
                                'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/WhatsApp_icon.png/598px-WhatsApp_icon.png', // WhatsApp icon URL
                                // color: ThemeColors.baseThemeColor,
                                width: 30,
                                height: 30,
                          ),
                        ),
                        SizedBox(width: 10),
                        InkWell(
                          onTap: () {
                           launchInstagram(username: parseDescription("${des.restaurantDescription}")["instagram"]??"null");
                          },
                          // child: Icon(
                          //   Icons.info_outline,
                          //   color: ThemeColors.baseThemeColor,
                          //   size: 30,
                          // ),
                          child: Image.network(
                                'https://cdn-icons-png.flaticon.com/128/15707/15707749.png', // Insta icon URL
                                // color: ThemeColors.baseThemeColor,
                                width: 27,
                                height: 27,
                          ),
                        ),
                                                SizedBox(width: 10),
                        InkWell(
                          onTap: () {
                          //  launchWhatsApp(phone: "9833891281");
                           launchFacebook(profileId: parseDescription("${des.restaurantDescription}")["facebook"]??"null");
                          },
                          // child: Icon(
                          //   Icons.info_outline,
                          //   color: ThemeColors.baseThemeColor,
                          //   size: 30,
                          // ),
                          child: Image.network(
                                'https://cdn-icons-png.flaticon.com/128/145/145802.png', // Facebook icon URL
                                // color: ThemeColors.baseThemeColor,
                                width: 27,
                                height: 27,
                          ),
                        ),
                                                SizedBox(width: 10),
                        
                         InkWell(
                          onTap: () {
                            Get.to(RestaurantInfo(
                              id: des.restaurantID,
                            ));
                          },
                          // child: Icon(
                          //   Icons.info_outline,
                          //   color: ThemeColors.baseThemeColor,
                          //   size: 30,
                          // ),
                          child: Image.network(
                                'https://cdn-icons-png.flaticon.com/128/4926/4926592.png', // WhatsApp icon URL
                                // color: ThemeColors.baseThemeColor,
                                width: 27,
                                height: 27,
                          ),
                        ),

                      ],
                    ),
                    subtitle: Row(
                      children: [
                        Flexible(
                          child: Text(
                            "${des.cuisines == null ? '' : des.cuisines.toString()}",
                            style: TextStyle(),
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Row(
                      children: [
                        Text(
                          'Open: ',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          '${des.openingTime}-${des.closingTime}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.amber),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.orange,
                          size: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 3.0),
                          child: Text(
                            "${des.rating}",
                            style: TextStyle(
                                //fontSize: FontSize.xLarge,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "(${des.reviewCount}) reviews",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          color: Colors.orange,
                          size: 20,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 3.0),
                            child: Text(
                              des.restaurantAddress.toString(),
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

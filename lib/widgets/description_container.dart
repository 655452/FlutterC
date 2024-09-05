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
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
                  // New Container to display the restaurant name

                  SizedBox(height: 10), // Space between name and ListTile
                  ListTile(
                    leading: Container(
                      width: 33.0, // Width of the button
                      height: 33.0,
                      // backgroundColor: ThemeColors.baseThemeColor,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ThemeColors
                            .baseThemeColor, // Ensures the button background is circular
                      ),
                      child: IconButton(
                        icon: Image.network(
                          'https://cdn-icons-png.flaticon.com/128/9674/9674456.png', // URL to your catalog icon
                          width: 40.0,
                          height: 40.0,
                          color: ThemeColors
                              .whiteTextColor, // Apply theme color if needed
                        ), // PDF icon

                        onPressed: () {
                          _showImageAndTextDialog(
                              context, des.restaurantImage!);
                        },
                        //  onPressed: () {
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(builder: (context) => PdfWebViewPage(urls: des.restaurantLogo)),
                        //   );
                        // },
                      ),
                    ),
                    // leading: CachedNetworkImage(
                    //   imageUrl: des.restaurantLogo!,
                    //   imageBuilder: (context, imageProvider) => Container(
                    //     height: 120,
                    //     width: 60,
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(10),
                    //       image: DecorationImage(
                    //           image: imageProvider, fit: BoxFit.fill),
                    //     ),
                    //   ),

                    //   placeholder: (context, url) => Shimmer.fromColors(
                    //     baseColor: Colors.grey[300]!,
                    //     highlightColor: Colors.grey[400]!,
                    //     child: Container(
                    //       height: 120,
                    //       width: 60,
                    //       decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(10),
                    //         image: DecorationImage(
                    //           image: AssetImage("assets/images/farmhouse.jpg"),
                    //           fit: BoxFit.fill,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    //   errorWidget: (context, url, error) => Icon(Icons.error),
                    // ),

                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //  Flexible(
                        //     child: Text(
                        //       "${des.restaurantName}",
                        //       maxLines: 2,
                        //       style: TextStyle(
                        //           fontSize: FontSize.xLarge,
                        //           fontWeight: FontWeight.bold),
                        //     ),
                        //   ),
                        SizedBox(width: 110), // Add space between icons
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
                            launchInstagram(
                                username: parseDescription(
                                            "${des.restaurantDescription}")[
                                        "instagram"] ??
                                    "null");
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
                            launchFacebook(
                                profileId: parseDescription(
                                            "${des.restaurantDescription}")[
                                        "facebook"] ??
                                    "null");
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
                            // opening the reviews page
                            // Get.to(RestaurantInfo(
                            //   id: des.restaurantID,
                            // ));
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
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // First row for restaurant name
                        Text(
                          "${des.restaurantName}",
                          maxLines: 2,
                          style: TextStyle(
                            fontSize:
                                FontSize.xLarge, // Adjust font size as needed
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                            height:
                                5), // Space between restaurant name and cuisines
                        // Second row for cuisines
                        Text(
                          "${des.cuisines == null ? '' : des.cuisines.toString()}",
                          style: TextStyle(),
                          maxLines: 2,
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
                    child: GestureDetector(
                      onTap: () {
                        _showDescriptionDialog(
                            context,
                            parseDescription(des.restaurantDescription!)[
                                    'description'] ??
                                "null");
                      },
                      child: Text(
                        parseDescription(
                                des.restaurantDescription!)['description'] ??
                            "null",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      Get.to(RestaurantInfo(
                        id: des.restaurantID,
                      ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Row(
                        children: [
                          // Icon(
                          //   Icons.star,
                          //   color: Colors.orange,
                          //   size: 20,
                          // ),
                          Padding(
                            padding: const EdgeInsets.only(left: 3.0),
                            child: _buildRatingStars(des.rating as int?),
                            // child: Text(

                            //   // "${des.rating}",
                            //   style: TextStyle(
                            //       //fontSize: FontSize.xLarge,
                            //       fontWeight: FontWeight.bold),
                            // ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              "(${des.reviewCount}) reviews",
                              // parseDescription(des.restaurantDescription!)['description']??"null"
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
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
                        // catlog button

                        //  previously Catalog button  is  here
                        //      Align(
                        //   alignment: Alignment.bottomRight,
                        //   child: Container(
                        //     width:45,
                        //     height: 45,
                        //     padding: EdgeInsets.only(right: 5.0), // Add padding from the right
                        //     child: FloatingActionButton(
                        //       onPressed: () {
                        //         Navigator.push(
                        //           context,
                        //           MaterialPageRoute(
                        //             builder: (context) => PdfWebViewPage(urls: des.restaurantLogo!),
                        //           ),
                        //         );
                        //       },

                        //       backgroundColor: ThemeColors.baseThemeColor,
                        //       child: Container(
                        //         width: 30.0, // Width of the button
                        //         height: 30.0, // Height of the button
                        //         decoration: BoxDecoration(
                        //           shape: BoxShape.circle,
                        //           // color: ThemeColors.baseThemeColor, // Ensures the button background is circular
                        //         ),
                        //         child: Center(
                        //           child: Image.network(
                        //             'https://img.icons8.com/?size=64&id=SLyEErG3AwF8&format=png', // URL to your catalog icon
                        //             width: 30.0,
                        //             height: 30.0,
                        //             // color: Colors.white, // Icon color, change if needed
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

void _showDescriptionDialog(BuildContext context, String description) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Description'),
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

// start ratings
Widget _buildRatingStars(int? rating) {
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

void _showImageAndTextDialog(BuildContext context, String url) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(16.0), // Adjust the radius as needed
        ),
        title: Text('Contact'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: double
                  .infinity, // Makes the image cover the width of the container
              height: 150.0, // Fixed height for the image
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(8.0), // Optional: for rounded corners
                image: DecorationImage(
                  image: NetworkImage(url),
                  fit: BoxFit.cover, // Ensures the image covers the box
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              children: <Widget>[
                Icon(Icons.phone, color: ThemeColors.darkFont), // Phone icon
                SizedBox(width: 8.0), // Space between icon and text
                Expanded(
                  child: Text('Woicher’s contact - 9833891281'),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              children: <Widget>[
                Image.network(
                  'https://img.icons8.com/?size=30&id=14oX0z9ydOeX&format=png', // URL to your
                  width: 23.0,
                  height: 23.0,
                ), // Clock icon
                SizedBox(width: 8.0), // Space between icon and text
                Expanded(
                  child: Text('Usual Delivery time - 2-3 days'),
                ),
              ],
            ),
          ],
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

class PdfWebViewPage extends StatelessWidget {
  final List<String> urls;

  PdfWebViewPage({required this.urls});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Catalog"),

        backgroundColor: ThemeColors.baseThemeColor, // Set AppBar color
      ),
      body: PageView.builder(
        itemCount: urls.length,
        itemBuilder: (context, index) {
          final url = urls[index];
          final isPdf = url.toLowerCase().endsWith('.pdf');
          final googleDocsUrl =
              'https://docs.google.com/viewer?url=$url&embedded=true';

          return isPdf
              ? WebView(
                  initialUrl: googleDocsUrl,
                  javascriptMode: JavascriptMode.unrestricted,
                )
              : Center(
                  child: Image.network(
                    url,
                    fit: BoxFit.contain,
                  ),
                );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '/Controllers/restaurant_details_controller.dart';
import '/utils/theme_colors.dart';
import '/views/not_found.dart';
import 'package:get/get.dart';

class AddReviewPage extends StatefulWidget {
  const AddReviewPage({Key? key}) : super(key: key);

  @override
  _AddReviewPageState createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  var mainHeight, mainWidth;
  var ratings = 1;

  @override
  Widget build(BuildContext context) {
    mainHeight = MediaQuery.of(context).size.height;
    mainWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: GetBuilder<RestaurantDetailsController>(
          init: RestaurantDetailsController(),
          //  I have done these true so that user can add review if he has not ordered then also you can make it  false
          builder: (rev) => rev.orderStatus == true
              ? NotFoundPage()
              : Container(
                  width: mainWidth,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _ratingBar(0),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          controller: rev.reviewController,
                          minLines: 2,
                          maxLines: 5,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            hintText: 'Give us a feedback',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                        ),
                      ),
                      ElevatedButton(
  onPressed: () {
    _ratingBar(0);
    setState(() {
      rev.addReview(
        context: context,
        addReviewRating: ratings,
        review: rev.reviewController.text.trim(),
      );
    });
  },
  style: ElevatedButton.styleFrom(
    backgroundColor:ThemeColors.baseThemeColor, // Set the background color to orange
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(40), // Apply border radius
    ),
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0), // Adjust padding
  ),
  child: Text('Submit', style: TextStyle(color: Colors.white)), // Text color set to white
),

                    ],
                  ),
                ),
        ),
      ),
    );
  }

  _ratingBar(initRating) => RatingBar.builder(
        initialRating: initRating == null ? 0 : initRating.toDouble(),
        allowHalfRating: true,
        direction: Axis.horizontal,
        itemCount: 5,
        itemSize: 30,
        itemBuilder: (context, _) => Icon(
          Icons.star,
          color: ThemeColors.baseThemeColor,
        ),
        onRatingUpdate: (rating) {
          setState(() {
            ratings = rating.toInt();
          });
        },
      );
}

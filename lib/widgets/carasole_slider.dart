import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class StaticCarouselWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          'How To Order', // Your heading text
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      GridView.count(
         
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          childAspectRatio: 0.8, // Adjust aspect ratio for the grid items
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          padding: EdgeInsets.all(10.0),
          children: [
            // SingleChildScrollView(
              _buildFeaturedItem(
              context: context,
              imageUrl: 'https://cdn-icons-png.flaticon.com/128/11552/11552033.png',
              heading: 'Discover products',
              description: 'They are pure, unique & handcrafted ',
            ),
            // ),
           
              _buildFeaturedItem(
              context: context,
              imageUrl: 'https://cdn-icons-png.flaticon.com/128/2449/2449714.png',
              heading: ' View Contact ',
              description: 'Click view contact to see Woicher’s contact or click whatsapp icon to send a message to the woicher',
            ),
            
           
            _buildFeaturedItem(
              context: context,
              imageUrl: 'https://cdn-icons-png.flaticon.com/128/3014/3014736.png',
              heading: ' Call the Woicher   ',
              description: 'Call the woicher to place an order or wait for couple of working hours to get a call back',
            ),
            
          ],
        ),

        //  Collection Slider Section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Text(
            "Handpicked for you",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        CarouselSlider(
          options: CarouselOptions(
            height: 200.0,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            viewportFraction: 1.0,
          ),
          items: [
            Container(
              margin: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
                image: DecorationImage(
                  image: NetworkImage('https://img.freepik.com/premium-vector/rating-happy-customer-feedback-client-feedback_941802-2289.jpg?size=626&ext=jpg&ga=GA1.1.661603384.1719301178&semt=ais_hybrid'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
                image: DecorationImage(
                  image: NetworkImage('https://img.freepik.com/premium-psd/customer-feedback-rating-review-testimonial-social-media-post-web-banner-template_169307-2686.jpg?size=626&ext=jpg&ga=GA1.1.661603384.1719301178&semt=ais_hybrid'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
                image: DecorationImage(
                  image: NetworkImage('https://img.freepik.com/free-vector/customer-review-with-photo-blog-banner-template_742173-6295.jpg?size=626&ext=jpg&ga=GA1.1.661603384.1719301178&semt=ais_hybrid'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Add more static widgets as needed
          ],
        ),
        
        //  Reviews  Section
           Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Text(
            "Reviews",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        CarouselSlider(
          options: CarouselOptions(
            height: 200.0,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            viewportFraction: 1.0,
          ),
          items: [
            // First Review Card
            Container(
              margin: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        // User Image at top left
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                              'https://img.freepik.com/free-photo/portrait-white-man-isolated_53876-40306.jpg?size=338&ext=jpg&ga=GA1.2.661603384.1719301178'),
                        ),
                        // Verified Icon or Badge at the bottom right of user image
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.green,
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    // Review Text inside the card
                    Text(
                      'This is an amazing app with great features. The UI is clean and simple. Highly recommend using this service!',
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ],
                ),
              ),
            ),

            // Second Review Card
            Container(
              margin: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        // User Image at top left
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                              'https://img.freepik.com/free-photo/successful-smiling-young-woman-with-arms-crossed-standing-white-background_176420-20419.jpg?size=338&ext=jpg&ga=GA1.2.661603384.1719301178'),
                        ),
                        // Verified Icon or Badge at the bottom right of user image
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.green,
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    // Review Text inside the card
                    Text(
                      'I had a great experience with this app. It made ordering food really easy and convenient. The service is quick too!',
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ],
                ),
              ),
            ),

            // Third Review Card
            Container(
              margin: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        // User Image at top left
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                              'https://img.freepik.com/free-photo/cheerful-young-man-wearing-casual-clothes-smiling-isolated-yellow-wall_171337-15658.jpg?size=338&ext=jpg&ga=GA1.2.661603384.1719301178'),
                        ),
                        // Verified Icon or Badge at the bottom right of user image
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.green,
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    // Review Text inside the card
                    Text(
                      'Fantastic experience using this app! The interface is user-friendly, and the customer service is excellent.',
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        ],
      ),
     ],
    );
  }
}



Widget _buildFeaturedItem({
  required BuildContext context,
  required String imageUrl,
  required String heading,
  required String description,
}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10.0), // Add margin to separate cards
    padding: EdgeInsets.all(10.0), // Add padding inside the card
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15.0),
      gradient: LinearGradient(
        colors: [Colors.white, Colors.grey[200]!], // Gradient from white to light grey
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1), // Soft shadow effect
          blurRadius: 10.0,
          spreadRadius: 2.0,
          offset: Offset(0, 5), // Slight vertical offset for shadow
        ),
      ],
    ),
    child:GestureDetector(
          onTap: () {
            _showDescriptionDialog(context, description, heading);
          },
    child: Wrap(
      runSpacing: 3,
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      // mainAxisSize: MainAxisSize.min, // Minimize the size based on content
      children: [
         SizedBox(height: 10.0),
        // Image container
        Container(
          width: double.infinity,
          height: 40,
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                imageUrl,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SizedBox(height: 10.0),
        // Heading text
        Text(
          heading,
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 5.0),
        // Description text with GestureDetector
        
         Text(
            description,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.grey[700],
            ),
            maxLines: 1, // Limit description to 1 line
            overflow: TextOverflow.ellipsis, // Use ellipsis for overflow
          ),
        
      ],
    ),
  ),
  );
}





void _showDescriptionDialog(BuildContext context, String description, String heading) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(heading),
        content: Text(description),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close'),
          ),
        ],
      );
    },
  );
}
  // void _showDescriptionDialog(BuildContext context, String description) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text("Item Description"),
  //         content: SingleChildScrollView(
  //           child: Text(description),
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: Text("Close"),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

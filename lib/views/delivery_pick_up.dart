import 'package:flutter/material.dart';
import '/utils/font_size.dart';
import '/utils/theme_colors.dart';
import 'package:get/get.dart';

import 'cart.dart';

class DeliveryPickUp extends StatefulWidget {
  const DeliveryPickUp({Key? key}) : super(key: key);

  @override
  _DeliveryPickUpState createState() => _DeliveryPickUpState();
}

class _DeliveryPickUpState extends State<DeliveryPickUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: ThemeColors.baseThemeColor,
            )),
        title: Text(
          "Delivery or Pickup",
          style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: FontSize.xLarge,
              color: ThemeColors.baseThemeColor),
        ),
        backgroundColor: Colors.white54,
        centerTitle: true,
        elevation: 0.0,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.shopping_cart,
              color: ThemeColors.baseThemeColor,
            ),
            tooltip: 'Open shopping cart',
            onPressed: () {
              Get.to(CartPage());
              // handle the press
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: ListTile(
              leading: Image.asset(
                "assets/images/pickup.png",
                fit: BoxFit.fill,
              ),
              title: Text("Pickup"),
              subtitle: Text("Pickup your Product from market"),
            ),
          ),
          Container(
            color: Colors.white,
            child: Card(
              child: ListTile(
                trailing: IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios_sharp,
                    color: ThemeColors.baseThemeColor,
                  ),
                  onPressed: () {},
                ),
                leading: Image.asset(
                  "assets/images/credit_card.png",
                  fit: BoxFit.fill,
                ),
                title: Text("Pay on pickup"),
                subtitle: Text("Click to pay on pickup"),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: ListTile(
              leading: Image.asset("assets/images/Delivery_address.png",
                  fit: BoxFit.fill),
              title: Text("Delivery adress"),
              subtitle: Text("Confirm your delivery address"),
            ),
          ),
          Container(
            color: Colors.white,
            child: Card(
              child: ListTile(
                trailing: IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios_sharp,
                    color: ThemeColors.baseThemeColor,
                  ),
                  onPressed: () {},
                ),
                leading: Image.asset("assets/images/delivery_Address.png"),
                title: Text("Mirpur-2,Dhaka-1216"),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            height: 60,
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ThemeColors.baseThemeColor, // background
                foregroundColor: Colors.white, // foreground
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // <-- Radius
                ),
              ),
              onPressed: () async {
                // Get.to(Order_confirmation());
              },
              child: Text(
                'Place Order',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

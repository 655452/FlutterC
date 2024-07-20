import 'package:flutter/material.dart';

class TableReservationConfirmation extends StatefulWidget {
  const TableReservationConfirmation({Key? key}) : super(key: key);

  @override
  _TableReservationConfirmationState createState() =>
      _TableReservationConfirmationState();
}

class _TableReservationConfirmationState
    extends State<TableReservationConfirmation> {
  var mainHeight, mainWidth;
  @override
  Widget build(BuildContext context) {
    mainHeight = MediaQuery.of(context).size.height;
    mainWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 50),
        height: mainHeight,
        width: mainWidth,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/images/table_reservation_icon.png",
                  color: Colors.amber,
                  height: mainHeight / 3,
                  width: mainWidth / 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Thanks for ",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Reservations",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                "we are an international chain serving you since 2010.We are delighted to have you in our hotel.We hope to see you again.We wish you have a good time",
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // <-- Radius
                    ),
                    backgroundColor: Colors.amber,
                    textStyle: TextStyle(fontWeight: FontWeight.bold)),
                onPressed: () {
                  print('Received click');
                },
                child: Center(
                  child: const Text('Book more table.',
                      style: TextStyle(
                          // fontSize: FontSize.medium,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // <-- Radius
                    ),
                    backgroundColor: Colors.white,
                    textStyle: TextStyle(fontWeight: FontWeight.bold)),
                onPressed: () {
                  print('Received click');
                },
                child: Center(
                  child: const Text('Book more table.',
                      style: TextStyle(
                          // fontSize: FontSize.medium,
                          color: Colors.amber,
                          fontWeight: FontWeight.bold)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

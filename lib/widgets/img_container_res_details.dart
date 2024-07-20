import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ImageContainer extends StatefulWidget {
  final img;
  ImageContainer({required this.img});
  @override
  State<StatefulWidget> createState() {
    return _ImageContainerState();
  }
}

class _ImageContainerState extends State<ImageContainer> {
  var mainHeight, mainWidth;
  @override
  Widget build(BuildContext context) {
    mainHeight = MediaQuery.of(context).size.height;
    mainWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: CachedNetworkImage(
        imageUrl: widget.img,
        imageBuilder: (context, imageProvider) => Container(
          padding: EdgeInsets.only(bottom: 15),
          height: mainHeight / 3.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(2.0), topRight: Radius.circular(2.0)),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.fill,
            ),
          ),
        ),
        placeholder: (context, url) => Shimmer.fromColors(
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
                image: AssetImage("assets/images/farmhouse.jpg"),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }
}

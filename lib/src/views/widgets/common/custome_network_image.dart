import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:footballscoreapp/src/constants/constants.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage({
    Key? key,
    required this.url,
    required this.placeholder,
    required this.width,
  }) : super(key: key);
  final String url;
  final String placeholder;
  final double width;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) => Container(
        width: width,
        height: width,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(image: imageProvider)),
      ),
      placeholder: (context, url) => Image.asset(
        placeholder,
        width: width,
      ),
      errorWidget: (context, url, err) => Image.asset(
        placeholder,
        width: width,
      ),
    );
  }
}

class ContactNetworkImage extends StatelessWidget {
  const ContactNetworkImage({
    Key? key,
    required this.url,
    required this.width,
  }) : super(key: key);
  final String url;
  final double width;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) => Container(
        width: width,
        height: width,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(image: imageProvider)),
      ),
      placeholder: (context, url) => Container(
        decoration:
            const BoxDecoration(color: kWhiteColor, shape: BoxShape.circle),
        child: Icon(
          Icons.person,
          size: width,
          color: kgreyColor,
        ),
      ),
      errorWidget: (context, url, err) => Container(
        decoration:
            const BoxDecoration(color: kWhiteColor, shape: BoxShape.circle),
        child: Icon(
          Icons.person,
          size: width,
          color: kgreyColor,
        ),
      ),
    );
  }
}

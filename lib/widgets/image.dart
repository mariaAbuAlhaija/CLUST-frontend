import 'package:clust/controllers/api_helper.dart';
import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  ImageView({this.event, this.image, Key? key}) : super(key: key);

  final dynamic? image;
  final dynamic? event;

  @override
  Widget build(BuildContext context) {
    String imageUrl;
    if (image != null) {
      try {
        imageUrl = "http://${ApiHelper().domain}/${image}";
      } catch (e) {
        imageUrl = "http://${ApiHelper().domain}/images/placeholder.png";
      }
    } else {
      try {
        imageUrl = "http://${ApiHelper().domain}/${event.images[0]}";
      } catch (e) {
        imageUrl = "http://${ApiHelper().domain}/images/placeholder.png";
      }
    }

    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
    );
  }
}

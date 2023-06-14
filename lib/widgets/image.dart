import 'package:clust/controllers/api_helper.dart';
import 'package:clust/models/user_model.dart';
import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  ImageView(this.event, {Key? key}) : super(key: key);

  final dynamic event;

  @override
  Widget build(BuildContext context) {
    String imageUrl;

    if (event is User) {
      try {
        imageUrl = "http://" + ApiHelper().domain + "/${event.image}";
      } catch (e) {
        imageUrl = "http://" + ApiHelper().domain + "/images/placeholder.png";
      }
    } else {
      try {
        imageUrl = "http://" + ApiHelper().domain + "/${event.images[0]}";
      } catch (e) {
        imageUrl = "http://" + ApiHelper().domain + "/images/placeholder.png";
      }
    }

    return Image.network(
      imageUrl,
      fit: BoxFit.fill,
    );
  }
}

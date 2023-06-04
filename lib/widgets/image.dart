import 'package:clust/controllers/api_helper.dart';
import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  ImageView(this.event, {super.key});
  var event;
  @override
  Widget build(BuildContext context) {
    try {
      return Image.network(
        "http://" + ApiHelper().domain + "/${event.images[0]}",
        fit: BoxFit.cover,
      );
    } catch (e) {
      return Image.network(
        "http://" + ApiHelper().domain + "/images/placeholder.png",
        fit: BoxFit.cover,
      );
    }
  }
}

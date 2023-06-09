import 'package:clust/styles/palate.dart';
import 'package:flutter/material.dart';

class loading extends StatelessWidget {
  const loading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: Palate.black,
      ),
    );
  }
}

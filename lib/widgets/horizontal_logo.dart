import 'package:clust/widgets/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HorizontalLogo extends StatelessWidget {
  const HorizontalLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 150.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          logoBox(),
          Sized_Box().sizedBoxW(context, 15.w),
          clust(),
        ],
      ),
    );
  }

  Container logoBox() {
    return Container(
      height: 50,
      width: 50,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/logo.png'),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Padding clust() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        width: 130,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/clust.png'),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}

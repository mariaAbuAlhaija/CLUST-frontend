import 'package:clust/styles/palate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

var largestTextSize = 27.0.sp;
var mediumestTextSize = 21.0.sp;
var mediumerTextSize = 17.0.sp;
var mediumTextSize = 15.0.sp;
var smallTextSize = 13.0.sp;
var smallestTextSize = 12.0.sp;
displayLarge({color = Palate.white, weight = FontWeight.normal}) => TextStyle(
      fontWeight: weight,
      fontSize: largestTextSize,
      color: color,
    );

headlineLarge({color = Palate.white, weight = FontWeight.normal}) => TextStyle(
      fontWeight: weight,
      fontSize: mediumestTextSize,
      color: color,
    );
headlineMedium({color = Palate.white, weight = FontWeight.normal}) => TextStyle(
      fontWeight: weight,
      fontSize: mediumerTextSize,
      color: color,
    );

headlineSmall({color = Palate.white, weight = FontWeight.normal}) => TextStyle(
      fontWeight: weight,
      fontSize: mediumTextSize,
      color: color,
    );

bodySmall({color = Palate.white, weight = FontWeight.normal}) => TextStyle(
      fontWeight: weight,
      fontSize: smallTextSize,
      color: color,
    );

labelSmall({color = Palate.white, weight = FontWeight.normal}) => TextStyle(
      fontWeight: weight,
      fontSize: smallestTextSize,
      color: color,
    );

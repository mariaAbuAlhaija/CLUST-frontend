import 'package:clust/styles/palate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

var largestTextSize = 27.0;
var mediumestTextSize = 21.0;
var mediumerTextSize = 17.0;
var mediumTextSize = 15.0;
var smallTextSize = 13.0;
var smallestTextSize = 12.0;
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

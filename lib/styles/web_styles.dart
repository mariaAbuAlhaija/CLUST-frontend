import 'package:clust/styles/palate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

var largestTextSize = 70.0;
var largerTextSize = 50.0;
var largeTextSize = 45.0;
var mediumestTextSize = 33.0;
var mediumerTextSize = 27.0;
var mediumTextSize = 23.0;
var smallTextSize = 21.0;
var smallerTextSize = 19.0;
var smallestTextSize = 17.0;

displayLarge({color = Palate.white, weight = FontWeight.normal}) => TextStyle(
      fontWeight: weight,
      fontSize: largestTextSize,
      color: color,
    );

displayMedium({color = Palate.white, weight = FontWeight.normal}) => TextStyle(
      fontWeight: weight,
      fontSize: largerTextSize,
      color: color,
    );

headlineLarge({color = Palate.white, weight = FontWeight.normal}) => TextStyle(
      fontWeight: weight,
      fontSize: largeTextSize,
      color: color,
    );
headlineMedium({color = Palate.white, weight = FontWeight.normal}) => TextStyle(
      fontWeight: weight,
      fontSize: mediumerTextSize,
      color: color,
    );

headlineSmall({color = Palate.white, weight = FontWeight.normal}) => TextStyle(
      fontWeight: weight,
      fontSize: mediumestTextSize,
      color: color,
    );

bodySmall({color = Palate.white, weight = FontWeight.normal}) => TextStyle(
      fontWeight: weight,
      fontSize: mediumTextSize,
      color: color,
    );

labelLarge({color = Palate.white, weight = FontWeight.normal}) => TextStyle(
      fontWeight: weight,
      fontSize: smallTextSize,
      color: color,
    );

labelMedium({color = Palate.white, weight = FontWeight.normal}) => TextStyle(
      fontWeight: weight,
      fontSize: smallerTextSize,
      color: color,
    );

labelSmall({color = Palate.white, weight = FontWeight.normal}) => TextStyle(
      fontWeight: weight,
      fontSize: smallestTextSize,
      color: color,
    );

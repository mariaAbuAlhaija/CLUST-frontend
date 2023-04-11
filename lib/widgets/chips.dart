import 'package:clust/models/user_model.dart';
import 'package:clust/screens/signup.dart';
import 'package:clust/styles/palate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Chips extends StatefulWidget {
  Chips({super.key, required this.selected});
  var selected;
  @override
  State<Chips> createState() => _ChipsState();
}

class _ChipsState extends State<Chips> {
  @override
  Widget build(BuildContext context) {
    Color lableColor = Palate.white;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        lable(context),
        SizedBox(
          height: 15.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: ['Female', 'Male', 'Other']
              .map((gender) => chip(gender, lableColor, context))
              .toList(growable: false),
        ),
      ],
    );
  }

  RawChip chip(String gender, Color lableColor, BuildContext context) {
    return RawChip(
      showCheckmark: false,
      label: Text(
        gender,
        style: TextStyle(color: lableColor),
      ),
      labelStyle: kIsWeb
          ? Theme.of(context).textTheme.labelMedium
          : Theme.of(context).textTheme.bodySmall,
      selected: widget.selected == gender,
      onSelected: (selected) {
        if (selected) {
          setState(() {
            widget.selected = gender;
            settingGender(gender);
          });
        }
      },
      selectedColor: Palate.lighterBlack,
      backgroundColor: Palate.black,
      padding:
          EdgeInsets.fromLTRB(kIsWeb ? 40 : 25.w, 15, kIsWeb ? 40 : 25.w, 15),
    );
  }

  void settingGender(String gender) {
    gender == Gender.female.toString()
        ? genderController = Gender.female
        : gender == Gender.male.toString()
            ? genderController = Gender.male
            : genderController = Gender.other;
  }

  Text lable(BuildContext context) => Text("Gender",
      style: kIsWeb
          ? Theme.of(context).textTheme.labelLarge
          : Theme.of(context).textTheme.headlineSmall);
}

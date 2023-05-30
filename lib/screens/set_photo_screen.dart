import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../styles/palate.dart';
import '../widgets/sized_box.dart';

// ignore: must_be_immutable
class SetPhotoScreen extends StatefulWidget {
  const SetPhotoScreen({super.key});

  static const id = 'set_photo_screen';

  @override
  State<SetPhotoScreen> createState() => _SetPhotoScreenState();
}

class _SetPhotoScreenState extends State<SetPhotoScreen> {
  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      this.image = imageTemporary;
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print(e);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: image != null
          ? Image.file(
              image!,
              width: 120,
              height: 120,
            )
          : TextButton(
              child: DottedBorder(
                color: Palate.sand,
                strokeWidth: 1,
                borderType: BorderType.Circle,
                child: Container(
                  height: 120,
                  width: 120,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(FontAwesomeIcons.camera,
                          color: Palate.white, size: 50.w),
                      Sized_Box().sizedBoxH(context, 10.0.h),
                      Text(
                        "Upload",
                        style: kIsWeb
                            ? Theme.of(context).textTheme.labelLarge
                            : Theme.of(context).textTheme.headlineLarge,
                      )
                    ],
                  ),
                ),
              ),
              onPressed: pickImage,
            ),
    );
  }
}

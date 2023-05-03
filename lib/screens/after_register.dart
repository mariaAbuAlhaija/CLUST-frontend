import 'package:clust/styles/palate.dart';
import 'package:clust/widgets/horizontal_logo.dart';
import 'package:clust/widgets/sized_box.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:easy_stepper/easy_stepper.dart' as stepper;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Steps extends StatefulWidget {
  const Steps({super.key});

  @override
  State<Steps> createState() => _StepsState();
}

class _StepsState extends State<Steps> {
  var activeStep = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const HorizontalLogo()),
      body: Row(
        children: [
          Column(
            children: [
              stepper.EasyStepper(
                activeStep: activeStep,
                lineLength: 115.h,
                lineSpace: 2.h,
                lineType: stepper.LineType.dotted,
                defaultLineColor: Palate.white,
                activeStepTextColor: Palate.black,
                unreachedStepBackgroundColor: Palate.white.withOpacity(0.5),
                finishedStepBackgroundColor: Palate.darker,
                finishedStepIconColor: Palate.white,
                internalPadding: 0,
                showLoadingAnimation: false,
                stepRadius: 45,
                showStepBorder: false,
                lineDotRadius: 1.5,
                steps: [
                  stepper.EasyStep(
                    customStep: CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.white,
                      child: activeStep >= 0 ? Text("1") : Icon(Icons.check),
                    ),
                    title: 'Upload image',
                  ),
                  stepper.EasyStep(
                    customStep: CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.white,
                      child: activeStep >= 0 ? Text("2") : Icon(Icons.check),
                    ),
                    title: 'Write about',
                  ),
                  // EasyStep(
                  //   customStep: CircleAvatar(
                  //     radius: 45,
                  //     backgroundColor: Colors.white,
                  //     child: activeStep >= 0 ? Text("3") : Icon(Icons.check),
                  //   ),
                  //   title: 'Verify email',
                  // ),
                ],
                onStepReached: (index) => setState(() => activeStep = index),
              ),
              //!!!!!!!!!!!!!!!!!!
              InkWell(
                onTap: () {},
                child: Text(
                  "Skip",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              )
            ],
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            color: Palate.darker,
            child: Center(
                child: Column(children: [
              Text(
                "Set up your account",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              content(activeStep),
            ])),
          )
        ],
      ),
    );
  }

  Widget content(int index) {
    switch (index) {
      case 0:
        return Column(
          children: [
            Sized_Box().sizedBoxH(context, 91.0.h),
            Text(
              "Smile for the camera!!",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            DottedBorder(
              color: Palate.sand,
              strokeWidth: 1,
              borderType: BorderType.Circle,
              child: Container(
                height: 220,
                width: 120,
                color: Palate.darker.withOpacity(0.5),
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: Column(
                  children: [
                    Icon(Icons.camera),
                    Text(
                      "Upload",
                      style: Theme.of(context).textTheme.bodySmall,
                    )
                  ],
                ),
              ),
            ),
            //!!!!!!!!!!!
            MaterialButton(
              onPressed: () {},
              color: Palate.sand,
              child: Text("Next"),
            )
          ],
        );
      case 1:
        return Column(
          children: [
            Sized_Box().sizedBoxH(context, 91.0.h),
            Text(
              "Tell us about you",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Form(
                child: Column(
              children: [
                DottedBorder(
                    color: Palate.sand,
                    strokeWidth: 1,
                    borderType: BorderType.Circle,
                    child: TextFormField(
                      decoration: InputDecoration(
                          counterText: "250", hintText: "Write about yourself"),
                    )),
                //!!!!!!!!!!!
                MaterialButton(
                  onPressed: () {},
                  color: Palate.sand,
                  child: Text("Next"),
                ),
                //!!!!!!!!!!!
                MaterialButton(
                  onPressed: () {},
                  color: Colors.transparent,
                  child: Text("Previous"),
                ),
              ],
            ))
          ],
        );
      default:
        return Text("");
    }
  }
}

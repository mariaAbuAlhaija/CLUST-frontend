import 'package:clust/styles/palate.dart';
import 'package:clust/styles/responsive.dart';
import 'package:clust/widgets/horizontal_logo.dart';
import 'package:clust/widgets/sized_box.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:easy_stepper/easy_stepper.dart' as stepper;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Steps extends StatefulWidget {
  const Steps({super.key});

  @override
  State<Steps> createState() => _StepsState();
}

class _StepsState extends State<Steps> {
  var activeStep = 0;
  var aboutController = TextEditingController();
  @override
  void initState() {
    super.initState();
    aboutController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Palate.black,
        appBar: AppBar(
          backgroundColor: Palate.black,
          leadingWidth: 350,
          leading: kIsWeb ? const HorizontalLogo() : null,
        ),
        body: Responsive(
          mobile: Center(
            child: Container(
              padding: kIsWeb
                  ? EdgeInsets.fromLTRB(300.w, 150.h, 100.w, 100.h)
                  : EdgeInsets.fromLTRB(60.w, 100.h, 60.w, 50.h),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Text("Set up your account",
                          textAlign: TextAlign.center,
                          style: kIsWeb
                              ? Theme.of(context).textTheme.headlineMedium
                              : Theme.of(context).textTheme.displayLarge),
                      Sized_Box().sizedBoxH(context, 50.0.h),
                      mobileContent(context, activeStep),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        skipButton(context),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          desktop: webLayout(context),
        ));
  }

  Widget mobileContent(BuildContext context, int index) {
    switch (index) {
      case 0:
        return Column(
          children: [
            Text(
              "Smile for the camera!!",
              style: kIsWeb
                  ? Theme.of(context).textTheme.labelLarge
                  : Theme.of(context).textTheme.headlineLarge,
            ),
            Sized_Box().sizedBoxH(context, 50.0.h),
            uploadImage(),
            Sized_Box().sizedBoxH(context, 50.0.h),
            nextButton(),
            Sized_Box().sizedBoxH(context, 30.0.h),
          ],
        );
      case 1:
        return Column(
          children: [
            Column(
              children: [
                Text(
                  "Tell us about you",
                  style: kIsWeb
                      ? Theme.of(context).textTheme.labelLarge
                      : Theme.of(context).textTheme.headlineLarge,
                ),
                Sized_Box().sizedBoxH(context, 50.0.h),
                form()
              ],
            ),
          ],
        );
      default:
        return const Text("");
    }
  }

  Padding webLayout(BuildContext context) {
    return Padding(
      padding: padding(),
      child: Wrap(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [steps(), skipButton(context)],
              ),
              stepContent(context)
            ],
          ),
        ],
      ),
    );
  }

  Container stepContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(150.w, 50.h, 150.w, 20.h),
      height: 700.h,
      width: 830.01.w,
      decoration: BoxDecoration(
          color: Palate.white.withOpacity(0.1),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Center(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Text(
          "Set up your account",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        content(activeStep),
      ])),
    );
  }

  stepper.EasyStepper steps() {
    return stepper.EasyStepper(
      direction: Axis.vertical,
      activeStep: activeStep,
      lineLength: 115.h,
      lineSpace: 0.h,
      lineType: stepper.LineType.dotted,
      defaultLineColor: Palate.white,
      unreachedStepBackgroundColor: Palate.white.withOpacity(0.5),
      finishedStepBackgroundColor: Palate.darker,
      finishedStepIconColor: Palate.white,
      finishedStepTextColor: Palate.white,
      unreachedStepTextColor: Palate.white,
      activeStepTextColor: Palate.white,
      showTitle: true,
      textDirection: TextDirection.ltr,
      enableStepTapping: true,
      internalPadding: 0,
      showLoadingAnimation: false,
      stepRadius: 45,
      showStepBorder: false,
      lineDotRadius: 1.5,
      steps: [
        stepper.EasyStep(
          customStep: CircleAvatar(
            radius: 45,
            backgroundColor:
                activeStep > 0 ? Palate.white.withOpacity(0.1) : Palate.white,
            child: activeStep > 0
                ? const Icon(
                    Icons.check,
                    color: Palate.white,
                  )
                : const Text("1"),
          ),
          title: 'Upload image',
        ),
        stepper.EasyStep(
          customStep: CircleAvatar(
            radius: 45,
            backgroundColor:
                activeStep < 1 ? Palate.white.withOpacity(0.8) : Palate.white,
            child: const Text("2"),
          ),
          title: 'Write about',
        ),
      ],
      onStepReached: (index) {
        setState(() => activeStep = index);
        print("active $activeStep");
      },
    );
  }

  InkWell skipButton(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushReplacementNamed(context, '/home');
      },
      child: Text(
        "Skip",
        style: kIsWeb
            ? Theme.of(context).textTheme.labelMedium
            : Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }

  EdgeInsets padding() => EdgeInsets.fromLTRB(180.w, 100.h, 500.w, 150.h);

  Widget content(int index) {
    switch (index) {
      case 0:
        return Column(
          children: [
            Sized_Box().sizedBoxH(context, 60.0.w),
            Text(
              "Smile!!",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Sized_Box().sizedBoxH(context, 40.0.w),
            uploadImage(),
            Sized_Box().sizedBoxH(context, 40.0.h),
            nextButton()
          ],
        );
      case 1:
        return Column(
          children: [
            Sized_Box().sizedBoxH(context, 70.0.h),
            Text(
              "Tell us about you",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Sized_Box().sizedBoxH(context, 10.0.h),
            form()
          ],
        );
      default:
        return const Text("");
    }
  }

  Form form() {
    return Form(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        DottedBorder(
          color: Palate.sand,
          strokeWidth: 1,
          borderType: BorderType.Rect,
          child: Stack(
            children: [
              TextFormField(
                keyboardType: TextInputType.multiline,
                controller: aboutController,
                minLines: 3,
                maxLines: 9,
                maxLength: 250,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Palate.white.withOpacity(0.8),
                    counterText: "",
                    hintText: "Write about yourself"),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Text("${aboutController.text.length}/250"),
              )
            ],
          ),
        ),
        Sized_Box().sizedBoxH(context, 20.0.h),
        prevNextButtons(),
      ],
    ));
  }

  InkWell uploadImage() {
    return InkWell(
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
              Icon(FontAwesomeIcons.camera, color: Palate.white, size: 50.w),
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
    );
  }

  Row prevNextButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        MaterialButton(
          onPressed: () {
            setState(() {
              activeStep = 0;
            });
          },
          child: Text(
            "Previous",
            style: kIsWeb
                ? Theme.of(context).textTheme.labelMedium
                : Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        MaterialButton(
          //!!!!!!!!!!!
          onPressed: () {},
          color: Palate.sand,
          child: const Text("Next"),
        ),
      ],
    );
  }

  Row nextButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: kIsWeb
              ? const EdgeInsets.only(right: 62)
              : const EdgeInsets.only(right: 0),
          child: MaterialButton(
            onPressed: () {
              setState(() {
                activeStep = 1;
              });
            },
            color: Palate.sand,
            child: const Text("Next"),
          ),
        ),
      ],
    );
  }
}

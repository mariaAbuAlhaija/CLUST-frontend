import 'package:clust/controllers/event_controller.dart';
import 'package:clust/models/event_model.dart';
import 'package:clust/screens/set_photo_screen.dart';
import 'package:clust/styles/palate.dart';
import 'package:clust/styles/responsive.dart';
import 'package:clust/widgets/categorySelect.dart';
import 'package:clust/widgets/horizontal_logo.dart';
import 'package:clust/widgets/sized_box.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:easy_stepper/easy_stepper.dart' as stepper;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../controllers/category_contoller.dart';
import '../widgets/date_picker.dart';
import '../widgets/datetimepicker.dart';

class EventSteps extends StatefulWidget {
  const EventSteps({super.key});

  @override
  State<EventSteps> createState() => _EventStepsState();
}

class _EventStepsState extends State<EventSteps> {
  var activeStep = 0;
  var eventNameController = TextEditingController();
  var eventDiscriptionController = TextEditingController();
  var eventThankController = TextEditingController();
  var eventNumController = TextEditingController();
  var startDateController = TextEditingController();
  var endDateController = TextEditingController();
  var categoryController = TextEditingController();

  DateTime dateTime = DateTime(2023, 6, 23, 3, 30);
  @override
  void initState() {
    super.initState();
    eventNameController.addListener(() {
      setState(() {});
    });
    eventDiscriptionController.addListener(() {
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
                      Text("Set up your Event",
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        prevNextButtons(),
                        nextButton(),
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
    String selectedCategoryName = '';

    switch (index) {
      case 0:
        return Column(
          children: [
            Sized_Box().sizedBoxH(context, 2.0.h),
            Text(
              "Give your event a name",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            formname(),
            Sized_Box().sizedBoxH(context, 2.0.h),
            Text(
              "Tell us about your event",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Sized_Box().sizedBoxH(context, 2.0.h),
            formdis(),
            Sized_Box().sizedBoxH(context, 2.0.h),
            Row(
              children: [
                Expanded(
                    child: DateTimePicker(
                  dateTimeController: startDateController,
                )),
                SizedBox(width: 10.0.w),
                Expanded(
                    child: DateTimePicker(
                  dateTimeController: endDateController,
                )),
              ],
            ),
            Text(
              "Select a Category",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Sized_Box().sizedBoxH(context, 2.0.h),
            CategorySelector(categoryController: categoryController)
          ],
        );
      case 1:
        return Column(
          children: [
            Sized_Box().sizedBoxH(context, 60.0.w),
            Text(
              "Lets have a photo of your event!",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Sized_Box().sizedBoxH(context, 40.0.w),
            SetPhotoScreen(),
            Sized_Box().sizedBoxH(context, 40.0.h),
          ],
        );

      case 2:
        return Column(
          children: [
            Text(
              "Additional information",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Sized_Box().sizedBoxH(context, 10.0.h),
            formthank(),
            Sized_Box().sizedBoxH(context, 10.0.h),
            formnum(),
            Sized_Box().sizedBoxH(context, 10.0.h),
            submitButton(context),
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
                children: [eventsteps(), skipButton(context)],
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
          "Set up your Event",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        content(activeStep),
      ])),
    );
  }

  stepper.EasyStepper eventsteps() {
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
          title: 'Basic Info',
        ),
        stepper.EasyStep(
          customStep: CircleAvatar(
            radius: 45,
            backgroundColor:
                activeStep > 1 ? Palate.white.withOpacity(0.1) : Palate.white,
            child: activeStep > 1
                ? const Icon(
                    Icons.check,
                    color: Palate.white,
                  )
                : const Text("2"),
          ),
          title: 'Set Event Photo',
        ),
        stepper.EasyStep(
          customStep: CircleAvatar(
            radius: 45,
            backgroundColor:
                activeStep < 2 ? Palate.white.withOpacity(0.8) : Palate.white,
            child: const Text("3"),
          ),
          title: 'Additional Info',
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
            Sized_Box().sizedBoxH(context, 2.0.h),
            Text(
              "Give your event a name",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Sized_Box().sizedBoxH(context, 2.0.h),
            formname(),
            Sized_Box().sizedBoxH(context, 2.0.h),
            Text(
              "Tell us about your event",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Sized_Box().sizedBoxH(context, 3.0.h),
            formdis(),
            Sized_Box().sizedBoxH(context, 10.0.h),
            Sized_Box().sizedBoxH(context, 10.0.h),
          ],
        );
      case 1:
        return Column(
          children: [
            Sized_Box().sizedBoxH(context, 60.0.w),
            Text(
              "Lets have a photo of your event!",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Sized_Box().sizedBoxH(context, 40.0.w),
            uploadImage(),
            Sized_Box().sizedBoxH(context, 40.0.h),
          ],
        );

      case 2:
        return Column(
          children: [
            Text(
              "Additional information",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Sized_Box().sizedBoxH(context, 10.0.h),
            formthank(),
            Sized_Box().sizedBoxH(context, 70.0.h),
            Text(
              "give your event a capacity",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Sized_Box().sizedBoxH(context, 10.0.h),
            formnum(),
          ],
        );
      default:
        return const Text("");
    }
  }

  Form formname() {
    return Form(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          children: [
            TextFormField(
              keyboardType: TextInputType.name,
              controller: eventNameController,
              minLines: 1,
              maxLines: 3,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Palate.white.withOpacity(0.8),
                  hintText: "Pick a Catchy & Interesting name"),
            ),
          ],
        ),
        Sized_Box().sizedBoxH(context, 20.0.h),
      ],
    ));
  }

  Form formnum() {
    return Form(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          children: [
            SizedBox(
              width: 100.0.w,
              child: TextFormField(
                keyboardType: TextInputType.name,
                controller: eventNumController,
                minLines: 1,
                maxLines: 1,
                maxLength: 4,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Palate.white.withOpacity(0.8),
                ),
              ),
            ),
          ],
        ),
        Sized_Box().sizedBoxH(context, 20.0.h),
      ],
    ));
  }

  Form formdis() {
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
                controller: eventDiscriptionController,
                minLines: 3,
                maxLines: 9,
                maxLength: 250,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Palate.white.withOpacity(0.8),
                    counterText: "",
                    hintText: "tell us about your event"),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Text("${eventDiscriptionController.text.length}/250"),
              ),
            ],
          ),
        ),
        Sized_Box().sizedBoxH(context, 20.0.h),
      ],
    ));
  }

  Form formthank() {
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
                controller: eventThankController,
                minLines: 3,
                maxLines: 9,
                maxLength: 250,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Palate.white.withOpacity(0.8),
                    counterText: "",
                    hintText:
                        "Express your gratitude for those who attended the event"),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Text("${eventThankController.text.length}/250"),
              ),
            ],
          ),
        ),
        Sized_Box().sizedBoxH(context, 20.0.h),
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
      ],
    );
  }

  Future<DateTime?> pickDate() => showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime(2023),
        lastDate: DateTime(2100),
      );
  Future<TimeOfDay?> pickTime() => showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute));

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
                switch (activeStep) {
                  case 0:
                    activeStep++;
                    break;
                  case 1:
                    activeStep++;
                    break;
                  default:
                    break;
                }
              });
            },
            color: Palate.sand,
            child: const Text("Next"),
          ),
        ),
      ],
    );
  }

  Padding submitButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 70),
      child: Container(
        height: 60,
        width: 460,
        child: ElevatedButton(
          onPressed: () {
            print("pressed");
            if (true) {
              print("inside");
              Event _user = Event(
                  eventNameController.text,
                  eventDiscriptionController.text,
                  int.parse(categoryController.text),
                  1,
                  dateFormat.parse(startDateController.text),
                  DateTime.parse(endDateController.text),
                  [],
                  [],
                  //!!!!!!!!!!!!!!!!
                  organizer: null,
                  status: Status.available);
              print("before");
              EventController().create(_user).then((value) {
                print("during");
                Navigator.pushReplacementNamed(context, "/afterRegister");
              }).catchError((ex, stacktrace) {
                print("error");
                print(ex.toString());
                print(stacktrace);
              });
            }
          },
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )),
              backgroundColor: MaterialStateProperty.all(
                  Palate.lighterBlack.withOpacity(0.48))),
          child: Text(
            "Sign Up",
            style: kIsWeb
                ? Theme.of(context).textTheme.bodySmall
                : Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      ),
    );
  }
}

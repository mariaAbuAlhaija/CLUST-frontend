import 'dart:io';

import 'package:clust/controllers/event_controller.dart';
import 'package:clust/controllers/image_controller.dart';
import 'package:clust/controllers/interaction_controller.dart';
import 'package:clust/controllers/user_controller.dart';
import 'package:clust/globals.dart';
import 'package:clust/models/event_model.dart';
import 'package:clust/models/image_model.dart' as image_model;
import 'package:clust/models/interaction_model.dart';
import 'package:clust/models/user_model.dart';
import 'package:clust/providers/event_spot_provider.dart';
import 'package:clust/providers/user_provider.dart';
import 'package:clust/styles/palate.dart';
import 'package:clust/widgets/categorySelect.dart';
import 'package:clust/widgets/datetimepicker.dart';
import 'package:clust/widgets/image.dart';
import 'package:clust/widgets/loading.dart';
import 'package:clust/widgets/sized_box.dart';
import 'package:clust/widgets/text_field.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:intl/intl.dart';
import 'package:clust/styles/mobile_styles.dart' as mobile;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CreateEvent extends StatefulWidget {
  CreateEvent({super.key});
  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  final PageController _controller = PageController(initialPage: 0);
  File? _file;
  final _formKey = GlobalKey<FormBuilderState>();
  final _formKey2 = GlobalKey<FormBuilderState>();
  var addressController = TextEditingController();
  var eventNameController = TextEditingController();
  var eventDescriptionController = TextEditingController();
  var eventThankController = TextEditingController();
  var eventCapacityController = TextEditingController();
  var startDateController = TextEditingController();
  var endDateController = TextEditingController();
  var categoryController = TextEditingController();
  var countryController = TextEditingController();
  var questionController = TextEditingController();
  DateTime dateTime = DateTime(2023, 6, 23, 3, 30);
  int _pageIndex = 0;
  var uploaded = false;
  String? uploadedImage;
  var validated = false;
  var validated2 = false;
  var scroll = true;
  bool visible = false;

  @override
  void initState() {
    super.initState();
    eventNameController.addListener(() {
      setState(() {});
    });
    eventDescriptionController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      (BuildContext context, eventSpotProvider provider, Widget? child) {
        return Consumer(
          builder:
              (BuildContext context, UserProvider userProvider, Widget? child) {
            if (userProvider.user == null)
              return loading();
            else {
              return Scaffold(
                resizeToAvoidBottomInset: false,
                body: Container(
                  padding: EdgeInsets.only(top: 100.h, right: 30.w, left: 30.w),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xffF4E7CA), Palate.sand]),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Create Event",
                        style: GoogleFonts.kameron(
                            textStyle:
                                mobile.displayLarge(color: Palate.black)),
                      ),
                      Expanded(
                        child: PageView(
                          scrollDirection: Axis.horizontal,
                          physics:
                              scroll ? null : NeverScrollableScrollPhysics(),
                          controller: _controller,
                          onPageChanged: (value) {
                            print(categoryController.text);
                            setState(() {
                              _pageIndex = value;
                            });
                            if ((value == 1 || value == 2) &&
                                (!validated || !validated2)) {
                              setState(() {
                                scroll = false;
                              });
                            }
                            if (value == 3) {
                              setState(() {
                                visible = true;
                              });
                            } else {
                              setState(() {
                                visible = false;
                              });
                            }
                          },
                          children: <Widget>[
                            firstPage(),
                            secondPage(),
                            thirdPage(),
                            imageScreen(),
                            // fourthPage(),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            right: 20.w, left: 20.w, bottom: 20),
                        height: 60.h,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                children: List.generate(
                                    4,
                                    (index) =>
                                        dotsIndicator(_pageIndex == index)),
                              ),
                            ),
                            arrow(provider, userProvider)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }

  Center firstPage() {
    return Center(
        child: Container(
      width: 300.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Create your own event, gather with people you share intrests with, and don't forget to enjoy your time",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(
            height: 15.h,
          ),
        ],
      ),
    ));
  }

  Center imageScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Sized_Box().sizedBoxH(context, 60.0.w),
          Text(
            "Upload event image (optional)",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Sized_Box().sizedBoxH(context, 40.0.w),
          uploadImage(),
          Sized_Box().sizedBoxH(context, 40.0.h),
        ],
      ),
    );
  }

  Center secondPage() {
    return Center(
      child: FormBuilder(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: eventNameController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: FormBuilderValidators.required(),
                onChanged: (value) {
                  setState(() {
                    validated = _formKey.currentState!.validate();
                    scroll = validated;
                  });
                },
                decoration: InputDecoration(
                    hintText: "Event Name", labelText: "Event Name"),
              ),
              Sized_Box().sizedBoxH(context, 15.h),
              TextFormField(
                controller: eventDescriptionController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                minLines: 1,
                maxLines: 3,
                maxLength: 250,
                keyboardType: TextInputType.multiline,
                onChanged: (value) {
                  setState(() {
                    validated = _formKey.currentState!.validate();
                    scroll = validated;
                  });
                },
                validator: FormBuilderValidators.required(),
                decoration: InputDecoration(
                  hintText: "About Event",
                  labelText: "About Event",
                ),
              ),
              Sized_Box().sizedBoxH(context, 15.h),
              TextFormField(
                controller: eventCapacityController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.number,
                validator: FormBuilderValidators.required(),
                onChanged: (value) {
                  setState(() {
                    validated = _formKey.currentState!.validate();
                    scroll = validated;
                  });
                },
                maxLength: 3,
                decoration: InputDecoration(
                    hintText: "Capacity", labelText: "Capacity"),
              ),
              Sized_Box().sizedBoxH(context, 15.h),
              CategorySelector(
                controller: categoryController,
                isCategory: true,
              ),
              SizedBox(height: 15.h),
              Row(
                children: [
                  Expanded(
                      child: DateTimePicker(
                    "Start Date",
                    dateTimeController: startDateController,
                  )),
                  SizedBox(width: 10.0.w),
                  Expanded(
                      child: DateTimePicker(
                    "End Date",
                    dateTimeController: endDateController,
                    startDateTimeController: startDateController,
                  )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  InkWell uploadImage() {
    return InkWell(
      onTap: () {
        handleGetImageAction();
      },
      child: DottedBorder(
        color: Palate.black,
        strokeWidth: 1,
        borderType: BorderType.Circle,
        child: AnimatedContainer(
          clipBehavior: Clip.hardEdge,
          height: uploaded ? 250.h : 120.h,
          width: uploaded ? 250.w : 120.w,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          duration: const Duration(milliseconds: 200),
          child: uploadWidget(),
        ),
      ),
    );
  }

  Widget uploadWidget() {
    return uploaded
        ? ImageView(image: uploadedImage)
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(FontAwesomeIcons.camera, color: Palate.black, size: 50.w),
              Sized_Box().sizedBoxH(context, 10.0.h),
              Text(
                "Upload",
              )
            ],
          );
  }

  Stack arrow(eventSpotProvider provider, UserProvider userProvider) {
    return Stack(
      children: [
        Visibility(
          visible: !visible,
          child: IconButton(
              onPressed: ((_pageIndex == 1 || _pageIndex == 2) &&
                      (!validated || !validated2))
                  ? null
                  : () {
                      // if (_pageIndex == 2) {

                      //   User _user = _global!.user;

                      //   // UserController().update(user)
                      // }
                      validated = false;
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    },
              icon: Icon(
                Icons.play_arrow_rounded,
                size: 40,
                color: ((_pageIndex == 1 || _pageIndex == 2) &&
                        (!validated || !validated2))
                    ? Palate.lighterBlack
                    : Palate.black,
              )),
        ),
        Visibility(
            visible: visible,
            child: MaterialButton(
              color: Palate.wine,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              onPressed: () async {
                Event event = Event(
                    eventNameController.text,
                    eventDescriptionController.text,
                    int.parse(categoryController.text),
                    userProvider.user!.id,
                    DateFormat("yyyy-MM-dd HH:mm")
                        .parse(startDateController.text),
                    DateFormat("yyyy-MM-dd HH:mm")
                        .parse(endDateController.text),
                    [],
                    [],
                    addressController.text,
                    int.parse(countryController.text),
                    id: 0,
                    capacity: int.parse(eventCapacityController.text),
                    views: 0);

                Event createdEvent = await provider.addEvent(event);
                image_model.Image eventImage = image_model.Image(
                    0, uploadedImage!, createdEvent.id ?? 0, false);
                ImageController().create(eventImage).then((value) {
                  EasyLoading.showSuccess("Event request sent",
                      duration: Duration(seconds: 3));
                  if (questionController.text.isNotEmpty) {
                    Interaction interaction =
                        Interaction(0, questionController.text, event!.id);
                    InteractionController().create(interaction);
                  }
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    "/navigator",
                    (Route<dynamic> route) => false,
                  );
                }).onError((error, stackTrace) {
                  print(error);
                  print(stackTrace);
                });
              },
              child: Text(
                "Send Request",
                style: TextStyle(color: Palate.white),
              ),
            ))
      ],
    );
  }

  AnimatedContainer dotsIndicator(isActive) {
    return AnimatedContainer(
      decoration: BoxDecoration(
          color: isActive ? Color.fromRGBO(30, 28, 28, 1) : Palate.lighterBlack,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      margin: EdgeInsets.all(2),
      height: isActive ? 20 : 10.h,
      width: 3.w,
      duration: Duration(milliseconds: 200),
    );
  }

  handleGetImageAction() async {
    if (Platform.isAndroid || Platform.isIOS) {
      ImagePicker picker = ImagePicker();
      final image = await picker.pickImage(source: ImageSource.gallery);
      print("picked");
      if (image != null) {
        setState(() {
          _file = File(image.path);
        });
      }
      EasyLoading.show(status: "Loading");
      print("load");
      ImageController().Upload(File(_file!.path)).then((value) {
        print("create");
        EasyLoading.dismiss();
        setState(() {
          uploadedImage = value;
          uploaded = true;
        });
      }).catchError((ex) {
        EasyLoading.dismiss();
        EasyLoading.showError(ex.toString());
      });
    } else {
      EasyLoading.showError("Not Supported");
    }
  }

  thirdPage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CategorySelector(
            controller: countryController,
            isCategory: false,
          ),
          SizedBox(
            height: 25.h,
          ),
          FormBuilder(
            key: _formKey2,
            child: Column(
              children: [
                TextFormField(
                  controller: addressController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  minLines: 1,
                  maxLines: 3,
                  maxLength: 100,
                  keyboardType: TextInputType.multiline,
                  onChanged: (value) {
                    setState(() {
                      validated2 = _formKey2.currentState!.validate();
                      scroll = validated2;
                    });
                  },
                  validator: FormBuilderValidators.required(),
                  decoration: InputDecoration(
                    hintText: "Event Address",
                    labelText: "Event Address",
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                TextFormField(
                  controller: questionController,
                  minLines: 1,
                  maxLines: 3,
                  maxLength: 100,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    hintText: "Add during events questions(optional)",
                    labelText: "Add during events questions",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:io';

import 'package:clust/controllers/image_controller.dart';
import 'package:clust/controllers/user_controller.dart';
import 'package:clust/globals.dart';
import 'package:clust/models/user_model.dart';
import 'package:clust/providers/user_provider.dart';
import 'package:clust/styles/palate.dart';
import 'package:clust/widgets/categorySelect.dart';
import 'package:clust/widgets/datetimepicker.dart';
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
  var eventNameController = TextEditingController();
  var eventDiscriptionController = TextEditingController();
  var eventThankController = TextEditingController();
  var eventCapacityController = TextEditingController();
  var startDateController = TextEditingController();
  var endDateController = TextEditingController();
  var categoryController = TextEditingController();
  DateTime dateTime = DateTime(2023, 6, 23, 3, 30);
  int _pageIndex = 0;
  var validated = false;
  var scroll = true;
  bool visible = false;

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
    return Consumer(
      builder: (BuildContext context, UserProvider provider, Widget? child) {
        if (provider.user == null)
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
                        textStyle: mobile.displayLarge(color: Palate.black)),
                  ),
                  Expanded(
                    child: PageView(
                      scrollDirection: Axis.horizontal,
                      physics: scroll ? null : NeverScrollableScrollPhysics(),
                      controller: _controller,
                      onPageChanged: (value) {
                        setState(() {
                          _pageIndex = value;
                        });
                        if (value == 1 && !validated) {
                          setState(() {
                            scroll = false;
                          });
                        }
                        if (value == 2) {
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
                        imageScreen(),
                        thirdPage(),
                      ],
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.only(right: 20.w, left: 20.w, bottom: 20),
                    height: 60.h,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: List.generate(4,
                                (index) => dotsIndicator(_pageIndex == index)),
                          ),
                        ),
                        arrow(provider)
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
  }

  Center firstPage() {
    return Center(
        child: Container(
      width: 300.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "sentence sentencesentencesentencesentencesentencesentencesentence",
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
            "Upload event photos",
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
              controller: eventDiscriptionController,
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
              decoration:
                  InputDecoration(hintText: "Capacity", labelText: "Capacity"),
            ),
            Sized_Box().sizedBoxH(context, 15.h),
            CategorySelector(categoryController: categoryController),
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
        child: Container(
          height: 120,
          width: 120,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(FontAwesomeIcons.camera, color: Palate.black, size: 50.w),
              Sized_Box().sizedBoxH(context, 10.0.h),
              Text(
                "Upload",
              )
            ],
          ),
        ),
      ),
    );
  }

  Stack arrow(UserProvider provider) {
    return Stack(
      children: [
        Visibility(
          visible: !visible,
          child: IconButton(
              onPressed: (_pageIndex == 1 && !validated)
                  ? null
                  : () {
                      // if (_pageIndex == 2) {

                      //   User _user = _global!.user;

                      //   // UserController().update(user)
                      // }
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    },
              icon: Icon(
                Icons.play_arrow_rounded,
                size: 40,
                color: (_pageIndex == 1 && !validated)
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
              onPressed: () {},
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
          color: isActive ? Palate.black : Palate.lighterBlack,
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
      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      setState(() {
        _file = File(image!.path);
      });
      EasyLoading.show(status: "Loading");
      ImageController().Upload(File(image!.path)).then((value) {
        EasyLoading.dismiss();
        EasyLoading.showSuccess(value);
      }).catchError((ex) {
        EasyLoading.dismiss();
        EasyLoading.showError(ex.toString());
      });
    } else {
      EasyLoading.showError("Not Supported");
    }
  }
}

class thirdPage extends StatelessWidget {
  const thirdPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Pending',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Text(
            'Your request to be organizer will be reviewed',
            style: TextStyle(fontSize: 15),
            softWrap: true,
          ),
        ],
      ),
    );
  }
}

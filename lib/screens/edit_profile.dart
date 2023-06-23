import 'dart:io';

import 'package:clust/models/user_model.dart';
import 'package:clust/providers/user_provider.dart';
import 'package:clust/styles/palate.dart';
import 'package:clust/widgets/sized_box.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:clust/controllers/image_controller.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../widgets/date_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormBuilderState>();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var aboutController = TextEditingController();
  var dateController = TextEditingController();

  File? _file;
  var uploaded = false;
  String? uploadedImage;
  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (BuildContext context, UserProvider provider, Widget? child) {
      firstNameController.text = provider.user!.firstName;
      lastNameController.text = provider.user!.lastName;
      aboutController.text = provider.user!.about!;
      dateController.text = provider.user!.birthDate;

      return Scaffold(
          appBar: AppBar(
            title: Text("Account info"),
          ),
          body: Container(
            padding: EdgeInsets.all(20),
            child: FormBuilder(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      TextFormField(
                        enabled: false,
                        decoration: InputDecoration(
                            hintText: "${provider.user!.email}"),
                      ),
                      Sized_Box().sizedBoxH(context, 15.h),
                      TextFormField(
                        controller: firstNameController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: FormBuilderValidators.required(),
                        decoration: InputDecoration(labelText: "First Name"),
                      ),
                      Sized_Box().sizedBoxH(context, 15.h),
                      TextFormField(
                        controller: lastNameController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: FormBuilderValidators.required(),
                        decoration: InputDecoration(labelText: "Last Name"),
                      ),
                      Sized_Box().sizedBoxH(context, 30.h),
                      TextFormField(
                        controller: aboutController,
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          labelText: 'About',
                          alignLabelWithHint: true,
                          border: OutlineInputBorder(),
                        ),
                      ),
                      Sized_Box().sizedBoxH(context, 30.h),
                     
                      DatePicker(
                        dateController: dateController,
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    child: MaterialButton(
                      elevation: 0,
                      onPressed: () {
                        User user = User.fromObj(provider.user!,
                            firstName: firstNameController.text,
                            lastName: lastNameController.text,
                            about: aboutController.text,
                            birthDate: dateController.text);

                        provider.updateUser(user);
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Palate.wine,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ],
              ),
            ),
          ));
    });
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
}

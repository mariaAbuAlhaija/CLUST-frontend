import 'package:clust/models/user_model.dart';
import 'package:clust/providers/user_provider.dart';
import 'package:clust/styles/palate.dart';
import 'package:clust/widgets/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../widgets/date_picker.dart';

class EditProfile extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();

  var firstNameController = TextEditingController();

  var lastNameController = TextEditingController();

  var aboutController = TextEditingController();

  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (BuildContext context, UserProvider provider, Widget? child) {
      firstNameController.text = provider.user!.firstName;
      lastNameController.text = provider.user!.lastName;
      aboutController.text = provider.user!.about!;
      dateController.text = provider.user!.birthDate;

      return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text("Account info"),
          ),
          body: Container(
            padding: const EdgeInsets.all(20),
            child: FormBuilder(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      TextFormField(
                        enabled: false,
                        decoration:
                            InputDecoration(hintText: provider.user!.email),
                      ),
                      Sized_Box().sizedBoxH(context, 15.h),
                      firstName(),
                      Sized_Box().sizedBoxH(context, 15.h),
                      lastName(),
                      Sized_Box().sizedBoxH(context, 30.h),
                      about(),
                      Sized_Box().sizedBoxH(context, 30.h),
                      DatePicker(
                        dateController: dateController,
                      ),
                    ],
                  ),
                  saveButton(provider, context),
                ],
              ),
            ),
          ));
    });
  }

  SizedBox saveButton(UserProvider provider, BuildContext context) {
    return SizedBox(
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
        color: Palate.wine,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: const Text(
          "Save",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  TextFormField firstName() {
    return TextFormField(
      controller: firstNameController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: const InputDecoration(labelText: "First Name"),
    );
  }

  TextFormField lastName() {
    return TextFormField(
      controller: lastNameController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: const InputDecoration(
        labelText: "Last Name",
      ),
    );
  }

  TextFormField about() {
    return TextFormField(
      controller: aboutController,
      maxLines: 3,
      keyboardType: TextInputType.multiline,
      decoration: const InputDecoration(
        labelText: 'About',
        alignLabelWithHint: true,
        border: OutlineInputBorder(),
      ),
    );
  }
}

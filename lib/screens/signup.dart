import 'package:clust/controllers/user_controller.dart';
import 'package:clust/screens/logo.dart';
import 'package:clust/styles/palate.dart';
import 'package:clust/widgets/text_field.dart' as txtField;
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:clust/styles/web_styles.dart' as web;
import 'package:clust/styles/mobile_styles.dart' as mobile;
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        useMaterial3: true,
        textTheme: kIsWeb
            ? Theme.of(context).textTheme.copyWith(
                  labelMedium:
                      web.labelMedium(color: Palate.black.withOpacity(0.5)),
                )
            : Theme.of(context).textTheme.copyWith(
                  bodySmall: mobile.bodySmall(
                    color: Palate.black.withOpacity(0.5),
                  ),
                ),
      ),
      child: Scaffold(
        backgroundColor: Palate.black,
        body: Padding(
          padding: EdgeInsets.only(top: 30.h, right: 30.w, left: 30.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                kIsWeb ? Logo().logo() : sizedBoxH(context, 150.h),
                FormBuilder(
                  key: _formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        nameField(),
                        sizedBoxH(context, 20.h),
                        datePicker(context),
                        sizedBoxH(context, 20.h),
                        emailField(),
                        sizedBoxH(context, 20.h),
                        passwordField(context),
                        submitButton(context),
                        sizedBoxH(context, 10.h),
                        options(context)
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column datePicker(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        lable(context),
        SizedBox(
          height: 15.h,
        ),
        FormBuilderDateTimePicker(
          name: "Date",
          inputType: InputType.date,
          decoration: InputDecoration(
            hintText: "Date of birth",
            filled: true,
            fillColor: Palate.white,
            hintStyle: hintstyle(context),
            contentPadding: padding(),
            isDense: true,
            border: border(),
            focusedBorder: focusedborder(),
          ),
          firstDate: DateTime(1900, 1, 1),
          lastDate: DateTime.now(),
        ),
      ],
    );
  }

  Text lable(BuildContext context) =>
      Text("Date of birth", style: Theme.of(context).textTheme.headlineSmall);
  TextStyle? hintstyle(BuildContext context) {
    return kIsWeb
        ? Theme.of(context).textTheme.labelMedium
        : Theme.of(context).textTheme.bodySmall;
  }

  EdgeInsets padding() {
    return const EdgeInsets.symmetric(vertical: 15, horizontal: 10);
  }

  OutlineInputBorder focusedborder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.transparent, width: 0),
        gapPadding: 20);
  }

  OutlineInputBorder border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.transparent, width: 0),
      gapPadding: 20,
    );
  }

  RichText options(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          style: kIsWeb
              ? Theme.of(context).textTheme.labelLarge
              : Theme.of(context).textTheme.bodySmall,
          text: ("Already a member? "),
          children: [
            TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushNamed(context, "/signin");
                  },
                style: TextStyle(color: Palate.sand),
                text: kIsWeb ? "\nSign in" : "Sign in"),
          ],
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              Navigator.pushNamed(context, "/signin");
            }),
    );
  }

  Column passwordField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 460,
          child: txtField.TextField(
            type: txtField.Type.password,
            controller: passwordController,
            hint: "Password",
            lable: "Password",
            forWhat: txtField.For.signin,
          ),
        ),
        sizedBoxH(context, 7.h),
        RichText(
          text: TextSpan(
              style: kIsWeb
                  ? Theme.of(context).textTheme.labelSmall
                  : Theme.of(context).textTheme.labelSmall,
              text: ("Forget password?"),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  // Navigator.pop(context);
                }),
        )
      ],
    );
  }

  Container emailField() {
    return Container(
      width: 460,
      child: txtField.TextField(
        type: txtField.Type.email,
        controller: emailController,
        hint: "Email",
        lable: "Email",
        forWhat: txtField.For.signin,
      ),
    );
  }

  Row nameField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 170,
          child: txtField.TextField(
            type: txtField.Type.general,
            controller: nameController,
            hint: "First name",
            lable: "First name",
            forWhat: txtField.For.signup,
          ),
        ),
        // sizedBoxW(context, 10.w),
        Container(
          width: 170,
          child: txtField.TextField(
            type: txtField.Type.general,
            controller: nameController,
            hint: "Last name",
            lable: "Last name",
            forWhat: txtField.For.signup,
          ),
        ),
      ],
    );
  }

  SizedBox sizedBoxH(BuildContext context, height) {
    return SizedBox(height: height);
  }

  SizedBox sizedBoxW(BuildContext context, width) {
    return SizedBox(width: width);
  }

  Padding submitButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 70),
      child: Container(
        height: 60,
        width: 460,
        child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              String email = emailController.text;
              String password = passwordController.text;
              print("before");
              UserController().getByID(1).then((value) {
                print("during");
                Navigator.pushNamed(context, "/start");
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

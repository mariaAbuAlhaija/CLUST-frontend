import 'package:clust/controllers/user_controller.dart';
import 'package:clust/screens/logo.dart';
import 'package:clust/styles/palate.dart';
import 'package:clust/widgets/sized_box.dart';
import 'package:clust/widgets/text_field.dart' as txt_field;
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:clust/styles/web_styles.dart' as web;
import 'package:clust/styles/mobile_styles.dart' as mobile;
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignIn extends StatelessWidget {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: theme(context),
      child: Scaffold(
        backgroundColor: Palate.black,
        body: Padding(
          padding: EdgeInsets.only(top: 150.h, right: 30.w, left: 30.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Logo().logo(),
                FormBuilder(
                  key: _formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        emailField(),
                        Sized_Box().sizedBoxH(context, kIsWeb ? 30.h : 20.h),
                        passwordField(context),
                        submitButton(context),
                        Sized_Box().sizedBoxH(context, 10.h),
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

  ThemeData theme(BuildContext context) {
    return ThemeData(
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
    );
  }

  RichText options(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: kIsWeb
            ? Theme.of(context).textTheme.labelLarge
            : Theme.of(context).textTheme.bodySmall,
        text: ("Not a member? "),
        children: [
          TextSpan(
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, "/signup");
                },
              style: const TextStyle(color: Palate.sand),
              text: kIsWeb ? "\nSign up" : "Sign up")
        ],
      ),
    );
  }

  Column passwordField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 460,
          child: txt_field.CustomTextField(
            type: txt_field.Type.password,
            controller: passwordController,
            hint: "Password",
            lable: "Password",
            forWhat: txt_field.For.signin,
          ),
        ),
        Sized_Box().sizedBoxH(context, 7.h),
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
      child: txt_field.CustomTextField(
        type: txt_field.Type.email,
        controller: emailController,
        hint: "Email",
        lable: "Email",
        forWhat: txt_field.For.signin,
      ),
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
            onPress(context);
          },
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )),
              backgroundColor: MaterialStateProperty.all(
                  Palate.lighterBlack.withOpacity(0.48))),
          child: Text(
            "Sign In",
            style: kIsWeb
                ? Theme.of(context).textTheme.bodySmall
                : Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      ),
    );
  }

  onPress(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      String email = emailController.text;
      String password = passwordController.text;
      print("before");
      UserController().signin(email, password).then((value) {
        print("during");
        Navigator.pushNamedAndRemoveUntil(
          context,
          "/navigator",
          (Route<dynamic> route) => false,
        );
      }).catchError((ex, stacktrace) {
        print("error");
        print(ex.toString());
        print(stacktrace);
        const SnackBar(
          content: Text("This is my content"),
        );
      });
    }
  }
}

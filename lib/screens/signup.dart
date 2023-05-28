import 'package:clust/controllers/user_controller.dart';
import 'package:clust/models/user_model.dart';
import 'package:clust/screens/logo.dart';
import 'package:clust/styles/palate.dart';
import 'package:clust/widgets/chips.dart';
import 'package:clust/widgets/sized_box.dart';
import 'package:clust/widgets/text_field.dart' as txtField;
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:clust/styles/web_styles.dart' as web;
import 'package:clust/styles/mobile_styles.dart' as mobile;
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:clust/widgets/date_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

var fnameController = TextEditingController();
var lnameController = TextEditingController();
var dateController = TextEditingController();
Gender genderController = Gender.other;
var emailController = TextEditingController();
var passwordController = TextEditingController();
var confirmPasswordController = TextEditingController();
var selectedIndex = "";

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.amberAccent,
        useMaterial3: true,
        textTheme: kIsWeb
            ? Theme.of(context).textTheme.copyWith(
                  labelMedium:
                      web.labelMedium(color: Palate.black.withOpacity(0.5)),
                  bodySmall: mobile.bodySmall(
                    color: Palate.black.withOpacity(0.5),
                  ),
                )
            : Theme.of(context).textTheme.copyWith(
                  bodySmall: mobile.bodySmall(
                    color: Palate.black.withOpacity(0.5),
                  ),
                ),
      ),
      child: Scaffold(
        backgroundColor: Palate.black,
        body: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 30.h, right: 30.w, left: 30.w),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // kIsWeb ? Logo().logo() :
                  Sized_Box().sizedBoxH(context, 40.h),
                  FormBuilder(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          nameField(),
                          Sized_Box().sizedBoxH(context, 20.h),
                          DatePicker(
                            dateController: dateController,
                          ),
                          Sized_Box().sizedBoxH(context, 20.h),
                          Container(
                              width: 460,
                              //!! change the selected index
                              child: Chips(selected: selectedIndex)),
                          Sized_Box().sizedBoxH(context, 20.h),
                          emailField(),
                          Sized_Box().sizedBoxH(context, 20.h),
                          passwordField(),
                          submitButton(context),
                          Sized_Box().sizedBoxH(context, 10.h),
                          options(context),
                        ]),
                  ),
                ],
              ),
            ),
          ),
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

  Container nameField() {
    return Container(
      width: 460,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          splitedFields(fnameController, "First name", "First name",
              txtField.Type.general),
          // sizedBoxW(context, 10.w),
          splitedFields(
              lnameController, "Last name", "Last name", txtField.Type.general),
        ],
      ),
    );
  }

  Container splitedFields(controller, hint, lable, type) {
    return Container(
      width: kIsWeb ? 225 : 170,
      child: txtField.TextField(
        type: type,
        controller: controller,
        hint: hint,
        lable: lable,
        forWhat: txtField.For.signup,
      ),
    );
  }

  Container passwordField() {
    return Container(
      width: 460,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          splitedFields(passwordController, "Password", "Password",
              txtField.Type.password),
          // sizedBoxW(context, 10.w),
          splitedFields(confirmPasswordController, "Confirm", "Confirm",
              txtField.Type.confirm),
        ],
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
            print("pressed");
            if (_formKey.currentState!.validate()) {
              print("inside");
              print("""firstName: ${fnameController.text},
                  lastName: ${lnameController.text},
                  birthDate: ${dateController.text},
                  email: ${emailController.text},
                  password: ${passwordController.text}
                  gender: ${genderController}""");
              User _user = User(
                  firstName: fnameController.text,
                  lastName: lnameController.text,
                  birthDate: dateController.text,
                  email: emailController.text,
                  password: passwordController.text,
                  gender: genderController);
              print("before");
              UserController().create(_user).then((value) {
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

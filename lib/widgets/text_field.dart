import 'package:clust/screens/signup.dart';
import 'package:clust/styles/palate.dart';
import 'package:clust/widgets/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class CustomTextField extends StatefulWidget {
  CustomTextField({
    super.key,
    required this.type,
    required this.controller,
    required this.hint,
    required this.lable,
    this.forWhat = For.signup,
  });
  Type type;
  TextEditingController controller;
  String hint;
  String lable;
  For forWhat;

  @override
  State<CustomTextField> createState() => TtextFieldState();
}

class TtextFieldState extends State<CustomTextField> {
  var obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        lable(context),
        Sized_Box().sizedBoxH(context, 15.h),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator:
              widget.forWhat == For.signup ? validators() : signinValidators(),
          controller: widget.controller,
          decoration: decoration(context),
          obscureText: isPassword ? obscureText : false,
          keyboardType: keyboardType(),
          // onChanged: (value) => print(widget.controller.text),
        ),
      ],
    );
  }

  Text lable(BuildContext context) => Text(widget.lable,
      style: kIsWeb
          ? Theme.of(context).textTheme.labelLarge
          : Theme.of(context).textTheme.headlineSmall);

  InputDecoration decoration(BuildContext context) {
    return InputDecoration(
      filled: true,
      fillColor: Palate.white,
      hintText: widget.hint,
      hintStyle: hintstyle(context),
      contentPadding: padding(),
      isDense: true,
      suffixIcon: isPassword ? suffix() : null,
      border: border(),
      focusedBorder: focusedborder(),
    );
  }

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

  FormFieldValidator<String> signinValidators() {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(errorText: "required field"),
      isEmail
          ? FormBuilderValidators.email()
          : FormBuilderValidators.required(errorText: "required field"),
    ]);
  }

  FormFieldValidator<String> validators() {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(errorText: "required field"),
      isEmail
          ? FormBuilderValidators.email()
          : isPassword
              ? (value) {
                  if (!value!.contains(RegExp("(?=.*?[0-9])"))) {
                    return "Include one digit at least";
                  }
                  if (!value.contains(RegExp("(?=.*?[A-Za-z])"))) {
                    return "Include one letter at least";
                  }
                  if (!value.contains(RegExp(".{8,}"))) {
                    return "Include more than 8 characters";
                  }
                  return null;
                }
              : FormBuilderValidators.required(errorText: "required field"),
    ]);
  }

  customisedValidator(value) {
    if (!value!.contains(RegExp("(?=.*?[0-9])"))) {
      return "Include one digit at least";
    }
    if (!value.contains(RegExp("(?=.*?[A-Za-z])"))) {
      return "Include one letter at least";
    }
    if (!value.contains(RegExp(".{8,}"))) {
      return "Include more than 8 characters";
    }

    return FormBuilderValidators.email();
  }

  String confirmValidator(value) {
    if (value != passwordController.text) {
      print("v=$value c=${passwordController.text}");
      print("v=$value c=${passwordController.text}");
      print("pc= ${passwordController.text}");
      print("fn= ${fnameController.text}");
      print("ln= ${lnameController.text}");
      print("db= ${dateController.text}");
      print("e= ${emailController.text}");
      print("g= ${genderController}");
      return "Passwords must match";
    }

    return "";
  }

  InkWell suffix() {
    return InkWell(
        onTap: () {
          setState(() {
            obscureText = !obscureText;
          });
        },
        child: obscureText
            ? const Icon(Icons.visibility, color: Palate.black, size: 22)
            : const Icon(Icons.visibility_off, color: Palate.black, size: 22));
  }

  TextInputType keyboardType() {
    return isEmail
        ? TextInputType.emailAddress
        : isPassword
            ? TextInputType.visiblePassword
            : TextInputType.text;
  }

  bool get isEmail => widget.type == Type.email;

  bool get isPassword => widget.type == Type.password;
  bool get isConfirm => widget.type == Type.confirm;
}

enum Type { email, password, general, confirm }

enum For { signin, signup, createEvent }

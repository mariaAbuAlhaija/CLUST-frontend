import 'package:clust/styles/palate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class TextField extends StatefulWidget {
  TextField({
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
  State<TextField> createState() => TtextFieldState();
}

class TtextFieldState extends State<TextField> {
  var obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        lable(context),
        SizedBox(
          height: 15.h,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator:
              widget.forWhat == For.signup ? validators() : signinValidators(),
          controller: widget.controller,
          decoration: decoration(context),
          obscureText: isPassword ? obscureText : false,
          keyboardType: keyboardType(),
        ),
      ],
    );
  }

  Text lable(BuildContext context) =>
      Text(widget.lable, style: Theme.of(context).textTheme.headlineSmall);

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
      FormBuilderValidators.required(),
      isEmail
          ? FormBuilderValidators.email()
          : FormBuilderValidators.required(),
    ]);
  }

  FormFieldValidator<String> validators() {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(),
      isEmail
          ? FormBuilderValidators.email()
          : isPassword
              ? customisedValidator
              : FormBuilderValidators.required(),
    ]);
  }

  String customisedValidator(value) {
    if (!value!.contains(RegExp("(?=.*?[0-9])"))) {
      return "password must have at least one digit";
    }
    if (!value.contains(RegExp("(?=.*?[A-Za-z])"))) {
      return "password must have at least one letter";
    }
    if (!value.contains(RegExp(".{8,}"))) {
      return "password must have more than 8 characters";
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
}

enum Type { email, password, general }

enum For { signin, signup }

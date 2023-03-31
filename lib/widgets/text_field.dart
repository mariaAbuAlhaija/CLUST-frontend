import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class TextField extends StatefulWidget {
  TextField(
      {super.key,
      required this.type,
      required this.controller,
      required this.hint});
  Type type;
  TextEditingController controller;
  String hint;

  @override
  State<TextField> createState() => TtextFieldState();
}

class TtextFieldState extends State<TextField> {
  var obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validators(),
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hint,
        contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 390),
        isDense: true,
        suffix: isPassword ? suffix() : null,
      ),
      obscureText: isPassword ? obscureText : false,
      keyboardType: keyboardType(),
    );
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
            ? const Icon(Icons.visibility)
            : const Icon(Icons.visibility_off));
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

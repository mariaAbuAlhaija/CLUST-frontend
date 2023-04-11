import 'package:clust/styles/palate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class SubmitButton extends StatefulWidget {
  SubmitButton({super.key, required this.onPress, required this.txt});
  Function() onPress;
  String txt;

  @override
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 70),
      child: Container(
        height: 60,
        width: 460,
        child: ElevatedButton(
          onPressed: widget.onPress,
          style: style(),
          child: Text(
            widget.txt,
            style: txtStyle(context),
          ),
        ),
      ),
    );
    ;
  }

  TextStyle? txtStyle(BuildContext context) {
    return kIsWeb
        ? Theme.of(context).textTheme.bodySmall
        : Theme.of(context).textTheme.headlineMedium;
  }

  ButtonStyle style() {
    return ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        )),
        backgroundColor:
            MaterialStateProperty.all(Palate.lighterBlack.withOpacity(0.48)));
  }
}

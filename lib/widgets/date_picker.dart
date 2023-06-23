import 'package:clust/widgets/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:clust/styles/palate.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  DatePicker({super.key, required this.dateController});
  var dateController;
  @override
  State<DatePicker> createState() => DatePickerState();
}

class DatePickerState extends State<DatePicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 460,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          lable(context),
          Sized_Box().sizedBoxH(context, 15.h),
          FormBuilderDateTimePicker(
            controller: widget.dateController,
            name: "Date",
            inputType: InputType.date,
                initialValue: widget.dateController.text.isNotEmpty
              ? DateFormat("MM/dd/yyyy").parse(widget.dateController.text)
                : null,
            decoration: InputDecoration(
              label: widget.dateController.text.isNotEmpty
              ?  Text("Birth Date"):null,
              hintText: "Date of birth",
              filled: true,
              fillColor: Palate.white,
              hintStyle: hintstyle(),
              contentPadding: padding(),
              isDense: true,
              border: border(),
              focusedBorder: focusedborder(),
            ),
            firstDate: DateTime(1900, 1, 1),
            lastDate: DateTime.now(),
          ),
        ],
      ),
    );
  }

  Text lable(BuildContext context) => Text("Date of birth",
      style: kIsWeb
          ? Theme.of(context).textTheme.labelLarge
          : Theme.of(context).textTheme.headlineSmall);
  TextStyle? hintstyle() {
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
}

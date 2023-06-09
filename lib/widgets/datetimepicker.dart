import 'package:clust/widgets/sized_box.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styles/palate.dart';

class DateTimePicker extends StatefulWidget {
  final TextEditingController dateTimeController;
  TextEditingController? startDateTimeController;
  String txt;
  DateTimePicker(this.txt,
      {Key? key,
      required this.dateTimeController,
      this.startDateTimeController})
      : super(key: key);

  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  DateTime? dateTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 460,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          lable(context, widget.txt),
          SizedBox(height: 10.h),
          MaterialButton(
            color: Palate.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            onPressed: () => pickDateTime(),
            child: Text(
              dateTime != null
                  ? '${dateTime!.year.toString().padLeft(2, '0')}-${dateTime!.month.toString().padLeft(2, '0')}-${dateTime!.day.toString().padLeft(2, '0')} ${dateTime!.hour.toString().padLeft(2, '0')}:${dateTime!.minute.toString().padLeft(2, '0')}'
                  : 'Select Date and Time',
            ),
          ),
        ],
      ),
    );
  }

  void pickDateTime() async {
    DateTime? selectedDateTime = await pickDateAndTime();
    if (selectedDateTime != null) {
      setState(() {
        dateTime = selectedDateTime;
        widget.dateTimeController.text =
            '${dateTime!.year.toString().padLeft(2, '0')}-${dateTime!.month.toString().padLeft(2, '0')}-${dateTime!.day.toString().padLeft(2, '0')} ${dateTime!.hour.toString().padLeft(2, '0')}:${dateTime!.minute.toString().padLeft(2, '0')}';
      });
    }
  }

  Future<DateTime?> pickDateAndTime() async {
    DateTime? date = await pickDate();
    if (date == null) return null;

    TimeOfDay? time = await pickTime();
    if (time == null) return null;

    return DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
  }

  Future<DateTime?> pickDate() async {
    print(DateTime.now());
    print(TimeOfDay.now());
    // print(DateTime.parse(widget.startDateTimeController!.text));
    return showDatePicker(
      context: context,
      initialDate: widget.startDateTimeController != null
          ? DateTime.parse(widget.startDateTimeController!.text)
          : DateTime.now(),
      firstDate: widget.startDateTimeController != null
          ? DateTime.parse(widget.startDateTimeController!.text)
          : DateTime.now(),
      lastDate: DateTime(2030),
    );
  }

  Future<TimeOfDay?> pickTime() async {
    // var dateTime = DateTime.parse(widget.startDateTimeController!.text);
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
  }

  Text lable(BuildContext context, txt) => Text(txt);
}

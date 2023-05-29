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

  DateTimePicker({Key? key, required this.dateTimeController})
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
          lable(context),
          SizedBox(height: 15.h),
          ElevatedButton(
            onPressed: () => pickDateTime(),
            child: Text(
              dateTime != null
                  ? '${dateTime!.year}/${dateTime!.month}/${dateTime!.day} ${dateTime!.hour.toString().padLeft(2, '0')}:${dateTime!.minute.toString().padLeft(2, '0')}'
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
            '${dateTime!.year}/${dateTime!.month}/${dateTime!.day} ${dateTime!.hour.toString().padLeft(2, '0')}:${dateTime!.minute.toString().padLeft(2, '0')}';
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
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
  }

  Future<TimeOfDay?> pickTime() async {
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
  }

  Text lable(BuildContext context) => Text(
        "Start Date",
        style: kIsWeb
            ? Theme.of(context).textTheme.labelLarge
            : Theme.of(context).textTheme.headlineSmall,
      );
}

import 'package:clust/models/event_model.dart';
import 'package:clust/styles/palate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../controllers/report_controller.dart';
import '../models/report_model.dart';
import 'image.dart';

class Items extends StatelessWidget {
  Items({this.event, super.key});
  final Event? event;

  @override
  Widget build(BuildContext context) {
    return item(context);
  }

  GestureDetector item(BuildContext context) {
    final bool showReportIcon = event!.end_date.isAfter(DateTime.now());

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/displayEvent", arguments: event);
      },
      child: Row(
        children: [
          leading(event!),
          SizedBox(
            height: 110.h,
            width: 150.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event!.name,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text(
                        "${event!.organizer!.firstName} ${event!.organizer!.lastName}",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${event!.address}, ${event!.country!.countryName}",
                    ),
                    Text(
                      "${weekDay(event!.start_date.weekday)}, ${months(event!.start_date.month)} ${event!.start_date.day} ${event!.start_date.year} ${event!.start_date.hour}:${event!.start_date.minute} ",
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (event!.end_date.isBefore(DateTime.now()))
            IconButton(
              icon: Icon(Icons.report_outlined),
              color: Color.fromARGB(255, 192, 192, 192),
              onPressed: () {
                _showReportPopup(context);
              },
            ),
        ],
      ),
    );
  }

  Container leading(Event event) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      height: 125.h,
      width: 150.w,
      child: ImageView(event: event),
    );
  }

  String weekDay(int day) {
    switch (day) {
      case 1:
        return "Mon";
      case 2:
        return "Tue";
      case 3:
        return "Wed";
      case 4:
        return "Thu";
      case 5:
        return "Fri";
      case 6:
        return "Sat";
      default:
        return "Sun";
    }
  }

  String months(int month) {
    switch (month) {
      case 1:
        return "Jan";
      case 2:
        return "Feb";
      case 3:
        return "Mar";
      case 4:
        return "Apr";
      case 5:
        return "May";
      case 6:
        return "Jun";
      case 7:
        return "Jul";
      case 8:
        return "Aug";
      case 9:
        return "Sept";
      case 10:
        return "Oct";
      case 11:
        return "Nov";
      default:
        return "Dec";
    }
  }

  void sendReportEmail(
      String organizerEmail, String eventName, String reason) async {
    String username = 'clustevents@gmail.com'; // your email address
    String password = 'ovqsvecbocresybx'; // your email password

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'Your Name') // your name
      ..recipients.add(organizerEmail) // organizer's email
      ..subject = 'Event Report'
      ..text =
          'Event "$eventName" has been reported with the following reason:\n\n$reason';

    try {
      final sendReport = await send(message, smtpServer);
      print('Report email sent: $sendReport');
    } catch (e) {
      print('Error sending report email: $e');
    }
  }

  void _showReportPopup(BuildContext context) {
    TextEditingController reasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Palate.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Report Event',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: reasonController,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      color: Palate.lighterBlack,
                    ),
                    labelText: 'Reason',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Palate.lighterBlack,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Palate.lighterBlack,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Palate.lighterBlack,
                      ),
                    ),
                    hintText: 'Enter reason',
                    hintStyle: TextStyle(
                      color: Palate.lighterBlack,
                    ),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: const Text(
                        'Submit',
                        style: TextStyle(color: Palate.lightwine),
                      ),
                      onPressed: () async {
                        String reason = reasonController.text;
                        // Perform submission logic here
                        Navigator.of(context).pop();
                        sendReportEmail(
                            event!.organizer!.email, event!.name, reason);
                        // Create a report object and save it to the database
                        Report report = Report(0, reason, event!.id);
                        await ReportController().create(report);
                      },
                    ),
                    const SizedBox(width: 8.0),
                    TextButton(
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: Palate.lighterBlack,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:clust/models/event_model.dart';
import 'package:clust/styles/palate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
      child: Container(
        // height: 130,
        child: Row(
          children: [
            leading(event!),
            SizedBox(
              height: 112.h,
              width: 180.w,
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
          ],
        ),
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
      height: 110.h,
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
}

import 'package:clust/controllers/event_controller.dart';
import 'package:clust/models/event_model.dart';
import 'package:clust/providers/event_spot_provider.dart';
import 'package:clust/widgets/items_view.dart';
import 'package:flutter/material.dart';
import 'package:clust/widgets/events_view.dart' as EventsViewWidget;
import 'package:clust/styles/palate.dart';
import 'package:flutter/foundation.dart';
import 'package:clust/styles/mobile_styles.dart' as mobile;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:provider/provider.dart';

import '../controllers/report_controller.dart';
import '../models/report_model.dart';

class Memories extends StatefulWidget {
  const Memories({super.key});
  @override
  State<Memories> createState() => _MemoriesState();
}

class _MemoriesState extends State<Memories> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: !kIsWeb ? theme(context) : ThemeData(),
      child: Scaffold(
        appBar: AppBar(title: Text("Memories")),
        body: Container(
          child: Consumer(
            builder: (BuildContext context, eventSpotProvider provider,
                Widget? child) {
              return provider.pastSpots.isNotEmpty
                  ? Container(
                      child: ListView.builder(
                          itemCount: provider.pastSpots.length,
                          itemBuilder: (context, index) {
                            void _showReportPopup(
                                BuildContext context, String organizerEmail) {
                              TextEditingController reasonController =
                                  TextEditingController();

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
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              TextButton(
                                                child: const Text(
                                                  'Submit',
                                                  style: TextStyle(
                                                      color: Palate.lightwine),
                                                ),
                                                onPressed: () async {
                                                  eventSpotProvider provider =
                                                      eventSpotProvider();
                                                  Event event =
                                                      await EventController()
                                                          .getByID(provider
                                                              .pastSpots[index]
                                                              .eventId);
                                                  String reason =
                                                      reasonController.text;

                                                  Navigator.of(context).pop();
                                                  sendReportEmail(
                                                      organizerEmail,
                                                  
                                                      event.name,
                                                      reason);
                                                  // Create a report object and save it to the database
                                                  Report report = Report(
                                                      0,
                                                      reason,
                                                      provider.pastSpots[index]
                                                          .eventId);
                                                  await ReportController()
                                                      .create(report);
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

                            return FutureBuilder<Event>(
                              future: EventController()
                                  .getByID(provider.pastSpots[index].eventId),
                              builder: (context, snapshott) {
                                if (!snapshott.hasData) {
                                  return Container();
                                }
                                return Row(
                                  children: [
                                    Items(event: snapshott.data!),
                                    Column(
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.flag_rounded),
                                          color: Palate.wine,
                                          onPressed: () async {
                                            Event event =
                                                await EventController().getByID(
                                                    provider.pastSpots[index]
                                                        .eventId);
                                            String organizerEmail = '';
                                            if (event != null) {
                                              organizerEmail =
                                                  event.organizer!.email;
                                              _showReportPopup(
                                                  context, organizerEmail);
                                            }
                                          },
                                        ),
                                      ],
                                    )
                                  ],
                                );
                              },
                            );
                          }),
                    )
                  : Center(
                      child: Text("No Memories"),
                    );
            },
          ),
        ),
      ),
    );
  }

  ThemeData theme(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      textTheme: Theme.of(context).textTheme.copyWith(
            displayLarge: mobile.displayLarge(color: Colors.amber),
            headlineLarge: mobile.headlineLarge(color: Palate.black),
            headlineMedium: mobile.headlineMedium(color: Palate.black),
            headlineSmall: mobile.headlineSmall(color: Palate.black),
            bodySmall: mobile.bodySmall(color: Palate.black),
            labelSmall: mobile.labelSmall(color: Palate.black),
          ),
    );
  }

  void sendReportEmail(
      String organizerEmail, //String eventName,
    String name,  String reason) async {
    String username = 'clustevents@gmail.com'; // your email address
    String password = 'ovqsvecbocresybx'; // your email password

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'Your Name') // your name
      ..recipients.add(organizerEmail) // organizer's email
      ..subject = 'Event Report'
      ..text =
          'your event $name has been reported with the following reason:\n\n$reason';

    try {
      final sendReport = await send(message, smtpServer);
      print('Report email sent: $sendReport');
    } catch (e) {
      print('Error sending report email: $e');
    }
  }
}

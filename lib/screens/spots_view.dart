import 'package:clust/controllers/event_controller.dart';
import 'package:clust/models/event_model.dart';
import 'package:clust/providers/event_spot_provider.dart';
import 'package:clust/styles/palate.dart';
import 'package:clust/widgets/items_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:clust/styles/mobile_styles.dart' as mobile;
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../controllers/answer_controller.dart';
import '../models/answer_model.dart';
import '../models/interaction_model.dart';

class SpotsView extends StatefulWidget {
  const SpotsView({Key? key}) : super(key: key);

  @override
  State<SpotsView> createState() => _SpotsViewState();
}

class _SpotsViewState extends State<SpotsView> {
  bool isQRCodeVisible = false;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: !kIsWeb
          ? theme(context)
          : ThemeData(
              useMaterial3: true,
            ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("My Spots"),
        ),
        body: Consumer(
          builder: (BuildContext context, eventSpotProvider provider,
              Widget? child) {
            if (provider.spottedSpots.isEmpty) {
              return const Center(
                child: Text("No Spotted Spots!"),
              );
            }
            Future<void> refresh() async {
              setState(() {
                provider.spottedSpots.clear();
              });
              var event = provider.spots();
              await event;
            }

            return RefreshIndicator(
              onRefresh: refresh,
              child: Container(
                child: ListView.builder(
                  itemCount: provider.spottedSpots.length,
                  itemBuilder: (context, index) {
                    return FutureBuilder<Event>(
                      future: EventController()
                          .getByID(provider.spottedSpots[index].eventId),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Container();
                        }
                        bool isCheckedAndLive =
                            provider.spottedSpots[index].checked &&
                                provider.liveEvents.any((event) =>
                                    event.id ==
                                    provider.spottedSpots[index].eventId) &&
                                provider.liveEvents.any((event) =>
                                    event.interaction != null &&
                                    event.id ==
                                        provider.spottedSpots[index].eventId);
                        bool isNotChecked =
                            !provider.spottedSpots[index].checked;
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Items(event: snapshot.data!),
                            Expanded(
                              child: Column(
                                children: [
                                  qrCode(
                                      isNotChecked, context, provider, index),
                                  interaction(isCheckedAndLive, snapshot),
                                  deleteSpot(provider, index),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  IconButton deleteSpot(eventSpotProvider provider, int index) {
    return IconButton(
      onPressed: () {
        provider.removeSpot(provider.spottedSpots[index]);
      },
      icon: const Icon(
        Icons.close,
        color: Colors.red,
      ),
    );
  }

  Visibility interaction(bool isCheckedAndLive, AsyncSnapshot<Event> snapshot) {
    return Visibility(
      visible: isCheckedAndLive,
      child: IconButton(
        onPressed: () {
          // Show interaction dialog
          _showInteractionDialog(snapshot.data!.interaction!);
        },
        icon: const Icon(
          Icons.question_answer,
          color: Colors.green,
        ),
      ),
    );
  }

  Visibility qrCode(bool isNotChecked, BuildContext context,
      eventSpotProvider provider, int index) {
    return Visibility(
      visible: isNotChecked,
      child: IconButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                child: showQr(provider, index, context),
              );
            },
          );
        },
        icon: const Icon(
          Icons.qr_code,
          color: Colors.blue,
        ),
      ),
    );
  }

  Container showQr(
      eventSpotProvider provider, int index, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Palate.white, borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "QR Code",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          const SizedBox(height: 16.0),
          if (!provider.spottedSpots[index].checked)
            QrImage(
              data:
                  '${provider.spottedSpots[index].id},${provider.spottedSpots[index].eventId}',
              version: QrVersions.auto,
              size: 200.0,
            ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.grey,
            ),
            child: const Text('Close'),
          ),
        ],
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
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }

  Future<void> _showInteractionDialog(Interaction interaction) async {
    TextEditingController answerController = TextEditingController();

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            decoration: BoxDecoration(
                color: Palate.white, borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  interaction.type,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: answerController,
                  decoration: const InputDecoration(
                    labelText: 'Answer',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    // Save the answer
                    Answer answer = Answer(
                      0, // Provide the actual answer ID
                      answerController.text,
                      interaction.id!,
                    );
                    AnswerController().create(answer);

                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green,
                  ),
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

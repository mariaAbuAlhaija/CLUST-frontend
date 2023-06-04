import 'package:clust/controllers/event_controller.dart';
import 'package:clust/controllers/spot_controller.dart';
import 'package:clust/models/event_model.dart';
import 'package:clust/models/spot_model.dart';
import 'package:clust/providers/event_spot_provider.dart';
import 'package:clust/styles/palate.dart';
import 'package:clust/widgets/image.dart';
import 'package:clust/widgets/items_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:clust/styles/mobile_styles.dart' as mobile;
import 'package:provider/provider.dart';

class SpotsView extends StatefulWidget {
  const SpotsView({super.key});

  @override
  State<SpotsView> createState() => _SpotsViewState();
}

class _SpotsViewState extends State<SpotsView> {
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
          title: Text("My Spots"),
        ),
        body: Consumer(
          builder: (BuildContext context, eventSpotProvider provider,
              Widget? child) {
            if (provider.spottedSpots.isEmpty)
              return Center(
                child: Text("No Spotted Spots!"),
              );
            return Container(
              child: ListView.builder(
                  itemCount: provider.spottedSpots.length,
                  itemBuilder: (context, index) {
                    return FutureBuilder<Event>(
                      future: EventController()
                          .getByID(provider.spottedSpots[index].eventId),
                      builder: (context, snapshott) {
                        if (!snapshott.hasData) {
                          return Container();
                        }
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Items(event: snapshott.data!),
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: IconButton(
                                onPressed: () {
                                  provider
                                      .removeSpot(provider.spottedSpots[index]);
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    );
                  }),
            );
          },
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
}

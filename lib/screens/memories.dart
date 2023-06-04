import 'package:clust/controllers/event_controller.dart';
import 'package:clust/models/event_model.dart';
import 'package:clust/providers/event_spot_provider.dart';
import 'package:clust/widgets/items_view.dart';
import 'package:flutter/material.dart';
import 'package:clust/widgets/events_view.dart' as EventsViewWidget;
import 'package:clust/styles/palate.dart';
import 'package:flutter/foundation.dart';
import 'package:clust/styles/mobile_styles.dart' as mobile;
import 'package:provider/provider.dart';

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
                            return FutureBuilder<Event>(
                              future: EventController()
                                  .getByID(provider.pastSpots[index].eventId),
                              builder: (context, snapshott) {
                                if (!snapshott.hasData) {
                                  return Container();
                                }
                                return Items(event: snapshott.data!);
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
}

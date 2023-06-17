 
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clust/providers/event_spot_provider.dart';
   import 'package:clust/widgets/events_view.dart' as EventsViewWidget;
import 'package:clust/styles/palate.dart';
 import 'package:clust/styles/mobile_styles.dart' as mobile;
 class SearchResultsView extends StatefulWidget {
  final String searchQuery;

  SearchResultsView(this.searchQuery);

  @override
  State<SearchResultsView> createState() => _SearchResultsViewState();
}

class _SearchResultsViewState extends State<SearchResultsView> {
  @override
  Widget build(BuildContext context) 
 
  //           // Ad
  {
       final _eventSpotProvider = Provider.of<eventSpotProvider>(context);
         
    return Theme(
      data: !kIsWeb ? theme(context) : ThemeData(),
      child: Scaffold(
         body: Container(
          child: Consumer(
            builder: (BuildContext context, eventSpotProvider provider,
                Widget? child) {
                  
              return provider.search.isNotEmpty
                  ? EventsViewWidget.EventsView(_eventSpotProvider.search)
                  : Center(
                      child: Text("No Live Events"),
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
  
  
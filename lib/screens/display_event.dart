import 'package:clust/controllers/spot_controller.dart';
import 'package:clust/controllers/user_controller.dart';
import 'package:clust/main.dart';
import 'package:clust/models/event_model.dart';
import 'package:clust/models/spot_model.dart';
import 'package:clust/models/user_model.dart';
import 'package:clust/providers/event_spot_provider.dart';
import 'package:clust/screens/home_mob.dart';
import 'package:clust/styles/palate.dart';
import 'package:clust/widgets/image.dart';
import 'package:clust/widgets/events_view.dart';
import 'package:clust/widgets/items_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:clust/globals.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:clust/styles/mobile_styles.dart' as mobile;

class DisplayEvent extends StatefulWidget {
  DisplayEvent(this._event, {super.key});
  final Event _event;
  @override
  State<DisplayEvent> createState() => _DisplayEventState();
}

class _DisplayEventState extends State<DisplayEvent> {
  @override
  Widget build(BuildContext context) {
    var spotted = false;
    return FutureBuilder<User>(
        future: UserController().getAll(),
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                color: Palate.black,
              ),
            );
          }
          return Consumer(
            builder: (BuildContext context, eventSpotProvider provider,
                Widget? child) {
              spotted =
                  provider.containsSpot(widget._event.id, snapshot.data!.id);
              return Scaffold(
                extendBodyBehindAppBar: true,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 1,
                  iconTheme: IconThemeData(
                    color: Colors.white,
                  ),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 350.h,
                        width: double.infinity,
                        child: ImageView(widget._event),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 200.w,
                                  child: Text(
                                    "${widget._event.name}",
                                    softWrap: true,
                                    style: GoogleFonts.kameron(
                                        textStyle: mobile.headlineLarge(
                                            color: Palate.black)),
                                  ),
                                ),
                                Container(
                                  width: 150.w,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Going: ${provider.allEvents[provider.eventIndex(widget._event)].spotsCount}",
                                        style: GoogleFonts.kameron(
                                            textStyle: mobile.bodySmall(
                                                color: Palate.black)),
                                      ),
                                      Text(
                                        "Capacity: ${widget._event.capacity}",
                                        style: GoogleFonts.kameron(
                                            textStyle: mobile.bodySmall(
                                                color: Palate.black)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${widget._event.organizer!.firstName} ${widget._event.organizer!.lastName}",
                              style: GoogleFonts.kameron(
                                  textStyle:
                                      mobile.bodySmall(color: Palate.black)),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                              "Description",
                              style: GoogleFonts.kameron(
                                  textStyle: mobile.headlineMedium(
                                      color: Palate.black)),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              "${widget._event.description}",
                              style: GoogleFonts.kameron(
                                  textStyle: mobile.headlineMedium(
                                      color: Palate.black)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                bottomNavigationBar: Container(
                  padding: EdgeInsets.all(10),
                  height: 110.h,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Icon(FontAwesomeIcons.clock),
                                Text(
                                    "  ${Items().weekDay(widget._event.start_date.weekday)}, ${Items().months(widget._event.start_date.month)} ${widget._event.start_date.day} ${widget._event.start_date.year} ${widget._event.start_date.hour}:${widget._event.start_date.minute} "),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Icon(Icons.location_on),
                                //!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                                Text("  Location not added"),
                              ],
                            ),
                          )
                        ],
                      ),
                      Container(
                        width: double.infinity,
                        height: 50.h,
                        child: MaterialButton(
                          onPressed: (widget._event.spotsCount >=
                                      widget._event.capacity) ||
                                  spotted
                              ? null
                              : () {
                                  try {
                                    if (widget._event.spotsCount <
                                        widget._event.capacity) {
                                      Spot spot = Spot(0, widget._event.id!,
                                          snapshot.data!.id, false);
                                      provider.spotAdded(widget._event, spot);

                                      EasyLoading.showSuccess(
                                        "Spotted!",
                                        duration: Duration(seconds: 3),
                                      );
                                    } else {
                                      throw ("Full Capacity");
                                    }
                                  } catch (error) {
                                    EasyLoading.showError(
                                      "${error.toString()}",
                                      duration: Duration(seconds: 3),
                                    );
                                  }
                                },
                          child: Text(
                            widget._event.spotsCount >= widget._event.capacity
                                ? "Full Capacity"
                                : spotted
                                    ? "Spotted!"
                                    : "Spot",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Palate.wine,
                          disabledColor: Palate.lighterBlack,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}

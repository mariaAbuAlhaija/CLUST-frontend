import 'package:clust/controllers/user_controller.dart';
import 'package:clust/models/event_model.dart';
import 'package:clust/models/rate_model.dart';
import 'package:clust/models/spot_model.dart';
import 'package:clust/models/user_model.dart';
import 'package:clust/providers/event_spot_provider.dart';
import 'package:clust/providers/rate_provider.dart';
import 'package:clust/screens/intractions.dart';
import 'package:clust/styles/palate.dart';
import 'package:clust/widgets/image.dart';
import 'package:clust/widgets/rate_chip.dart';
import 'package:clust/widgets/items_view.dart';
import 'package:clust/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:clust/styles/mobile_styles.dart' as mobile;

import '../models/interaction_model.dart';

class DisplayEvent extends StatelessWidget {
  DisplayEvent(this._event, {super.key});
  final Event _event;
  Interaction? _interaction;

  var spotted = false;

  var rated = false;

  var pastEvent = false;

  int _rating = 0;

  String eventRate = "0";

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
        future: UserController().getAll(),
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData) {
            return const loading();
          }
          _interaction = _event.interaction;

          return Consumer(builder:
              (BuildContext context, RateProvider rateProvider, Widget? child) {
            return Consumer(
              builder: (BuildContext context, eventSpotProvider provider,
                  Widget? child) {
                rated = rateProvider.checkRated(_event.id, snapshot.data!.id);
                spotted = provider.containsSpot(_event.id, snapshot.data!.id);
                pastEvent = provider.isPastEvent(_event.id, snapshot.data!.id);

                return Scaffold(
                  extendBodyBehindAppBar: true,
                  appBar: appbar(rateProvider),
                  body: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        image(),
                        Container(
                          margin: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              eventData(provider),
                              organizerData(),
                              SizedBox(
                                height: 20.h,
                              ),
                              descriptionLable(),
                              SizedBox(
                                height: 10.h,
                              ),
                              description(),
                              if (_interaction != null)
                                interactionData(context),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  bottomNavigationBar: Container(
                    padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
                    height: 110.h,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [date(), location()],
                        ),
                        spotButton(snapshot, provider, context),
                      ],
                    ),
                  ),
                );
              },
            );
          });
        });
  }

  Container spotButton(
      AsyncSnapshot<User> snapshot, eventSpotProvider provider, context) {
    return Container(
      width: double.infinity,
      height: 50.h,
      child: MaterialButton(
        onPressed: (_event.spotsCount >= _event.capacity) || spotted || rated
            ? null
            : pastEvent && !rated
                ? () {
                    bottomSheet(snapshot.data!, context);
                  }
                : () {
                    try {
                      if (_event.spotsCount < _event.capacity) {
                        Spot spot =
                            Spot(0, _event.id, snapshot.data!.id, false);
                        provider.spotAdded(_event, spot);

                        EasyLoading.showSuccess(
                          "Spotted!",
                          duration: const Duration(seconds: 3),
                        );
                      } else {
                        throw ("Full Capacity");
                      }
                    } catch (error) {
                      EasyLoading.showError(
                        error.toString(),
                        duration: const Duration(seconds: 3),
                      );
                    }
                  },
        color: Palate.wine,
        disabledColor: Palate.lighterBlack,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Text(
          rated
              ? "Rated"
              : pastEvent
                  ? "Rate"
                  : _event.spotsCount >= _event.capacity
                      ? "Full Capacity"
                      : spotted
                          ? "Spotted!"
                          : "Spot",
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget interactionData(context) {
    eventSpotProvider provider = eventSpotProvider();
    bool ispast = !provider.liveEvents.any((event) => event.id == _event.id);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => QuestionScreen(
                    interactionId: _interaction!.id!,
                    ispast: ispast,
                  )),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Interaction Details",
                  style: GoogleFonts.kameron(
                    textStyle: mobile.headlineMedium(color: Palate.black),
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward),
        ],
      ),
    );
  }

  Container date() {
    return Container(
      child: Row(
        children: [
          const Icon(FontAwesomeIcons.clock),
          Text(
              "  ${Items().weekDay(_event.start_date.weekday)}, ${Items().months(_event.start_date.month)} ${_event.start_date.day} ${_event.start_date.year} ${_event.start_date.hour}:${_event.start_date.minute} "),
        ],
      ),
    );
  }

  Container location() {
    return Container(
      child: Row(
        children: [
          const Icon(Icons.location_on),
          Text(" ${_event.address}, ${_event.country!.countryName}"),
        ],
      ),
    );
  }

  Text description() {
    return Text(
      _event.description,
      style: GoogleFonts.kameron(
          textStyle: mobile.headlineMedium(color: Palate.black)),
    );
  }

  Text descriptionLable() {
    return Text(
      "Description",
      style: GoogleFonts.kameron(
          textStyle: mobile.headlineMedium(color: Palate.black)),
    );
  }

  Text organizerData() {
    return Text(
      "${_event.organizer!.firstName} ${_event.organizer!.lastName}",
      style:
          GoogleFonts.kameron(textStyle: mobile.bodySmall(color: Palate.black)),
    );
  }

  Row eventData(eventSpotProvider provider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 200.w,
          child: Text(
            _event.name,
            softWrap: true,
            style: GoogleFonts.kameron(
                textStyle: mobile.headlineLarge(color: Palate.black)),
          ),
        ),
        Container(
          width: 150.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Going: ${(_event).spotsCount}",
                style: GoogleFonts.kameron(
                    textStyle: mobile.bodySmall(color: Palate.black)),
              ),
              Text(
                "Capacity: ${_event.capacity}",
                style: GoogleFonts.kameron(
                    textStyle: mobile.bodySmall(color: Palate.black)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Container image() {
    return Container(
      height: 350.h,
      width: double.infinity,
      child: ImageView(event: _event),
    );
  }

  AppBar appbar(RateProvider provider) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 1,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      actions: [
        Visibility(
          visible: pastEvent,
          child: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: chip(txt: _event.rate.toStringAsFixed(2)),
          ),
        )
      ],
    );
  }

  bottomSheet(user, context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.white,
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setModalState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  bottomSheetContent(setModalState, user, context),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Align(
                        alignment: Alignment.bottomLeft,
                        child: Icon(
                          Icons.close,
                          size: 30,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          );
        });
      },
    );
  }

  Container bottomSheetContent(
      StateSetter setModalState, user, BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(40.w, 50.h, 30.w, 30.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  final filledIcon =
                      _rating >= index + 1 ? Icons.star : Icons.star_border;
                  final color =
                      _rating >= index + 1 ? Colors.yellow : Colors.grey;

                  return IconButton(
                    icon: Icon(
                      filledIcon,
                      color: color,
                      size: 50,
                    ),
                    onPressed: () {
                      setModalState(() {
                        if (_rating == index + 1) {
                          _rating = index;
                        } else {
                          _rating = index + 1;
                        }
                      });
                    },
                  );
                })),
          ),
          const SizedBox(
            height: 20,
          ),
          MaterialButton(
            onPressed: () async {
              print("""
                ${user.id},
                ${_event.id},""");
              Rate rate = Rate(
                0,
                _event.id,
                user.id,
                _rating,
              );
              await Provider.of<RateProvider>(context, listen: false)
                  .addRate(rate);
              Provider.of<RateProvider>(context, listen: false)
                  .getEventRates(_event);

              Navigator.pop(context);
            },
            color: Colors.black,
            child: const Text(
              "Submit",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}

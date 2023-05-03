import 'package:flutter/material.dart';

import '../styles/palate.dart';

class Notifications extends StatefulWidget {
  const Notifications({
    super.key,
  });

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  OverlayEntry? overlayEntry;
  bool overLayDisplayed = false;

  void createHighlightOverlay() {
    removeHighlightOverlay();

    assert(overlayEntry == null);

    overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return SafeArea(
          child: Stack(
            children: [
              Positioned(
                  right: 200,
                  top: 55,
                  child: SizedBox(
                    height: 200,
                    width: 200,
                    child: Card(
                      color: Colors.red,
                    ),
                  ))
            ],
          ),
        );
      },
    );

    Overlay.of(context, debugRequiredFor: widget).insert(overlayEntry!);
  }

  // Remove the OverlayEntry.
  void removeHighlightOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  @override
  void initState() {
    super.initState();
    removeHighlightOverlay();
  }

  @override
  void dispose() {
    removeHighlightOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      child: InkWell(
        onTap: () {
          setState(() {
            overLayDisplayed = !overLayDisplayed;
          });
          overLayDisplayed
              ? createHighlightOverlay()
              : removeHighlightOverlay();
        },
        child: Stack(
          children: [
            Icon(
              Icons.notifications,
              color: Palate.white,
              size: 30,
            ),
            Container(
              width: 30,
              height: 30,
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(top: 5),
              child: Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffc32c37),
                    border: Border.all(color: Colors.white, width: 1)),
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Center(
                    child: Text(
                      "1",
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

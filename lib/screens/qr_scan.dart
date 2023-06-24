import 'package:clust/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../controllers/spot_controller.dart';
import '../controllers/event_controller.dart';
import '../styles/palate.dart';

class ScanQRScreen extends StatefulWidget {
  @override
  _ScanQRScreenState createState() => _ScanQRScreenState();
}

class _ScanQRScreenState extends State<ScanQRScreen> {
  String scannedResult = 'No QR code scanned';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan QR Code'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              scannedResult,
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _scanQRCode,
              style: ElevatedButton.styleFrom(
                primary: Palate.sand,
              ),
              child: Text(
                'Scan QR Code',
                style: TextStyle(color: Palate.wine),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _scanQRCode() async {
    String barcodeScanResult = await FlutterBarcodeScanner.scanBarcode(
      '#ff6666',
      'Cancel',
      true,
      ScanMode.QR,
    );

    // Update the spot with checked = true
   
      // Extract spotId and eventId from the scanned QR code result
      List<String> qrResult = barcodeScanResult.split(',');
      if (qrResult.length == 2) {
        int spotId = int.tryParse(qrResult[0].trim()) ?? -1;
        int eventId = int.tryParse(qrResult[1].trim()) ?? -1;
        if (spotId != -1 && eventId != -1) {
          // Check if the event ID exists for the organizer
          List<int> eventIds = await EventController().getEventIdsByOrganizer(
              UserProvider()
                  .user!
                  .id); // Replace `organizerId` with the actual organizer ID
          if (eventIds.contains(eventId)) {
            // Update the spot with checked = true
            SpotController().updateSpotChecked(spotId);
            setState(() {
              scannedResult = 'Spot ID $spotId has been checked';
            });
            EasyLoading.showSuccess(
              "Checked!",
              duration: Duration(seconds: 3),
            );
          } else {
            setState(() {
              scannedResult = 'Wrong event';
            });
            EasyLoading.showError(
              "Wrong event",
              duration: Duration(seconds: 3),
            );
          }
        } else {
          setState(() {
            scannedResult = 'Invalid QR code';
          });
          EasyLoading.showError(
            "Invalid QR code",
            duration: Duration(seconds: 3),
          );
        }
      } else {
        setState(() {
          scannedResult = 'Invalid QR code';
        });
        EasyLoading.showError(
          "Invalid QR code",
          duration: Duration(seconds: 3),
        );
      }
    }
  }
 

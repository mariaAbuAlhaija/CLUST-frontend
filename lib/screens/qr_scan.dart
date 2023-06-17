import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../controllers/spot_controller.dart';
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
           
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _scanQRCode();
              },
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
    int spotId = int.tryParse(barcodeScanResult) ?? -1;
    if (spotId != -1) {
      SpotController().updateSpotChecked(spotId);
      setState(() {
       });
      EasyLoading.showSuccess(
        "Checked!",
        duration: Duration(seconds: 3),
      );
    } else {
      setState(() {
       });
       EasyLoading.showSuccess(
        "Error!",
        duration: Duration(seconds: 3),
      );
    }
  }
}

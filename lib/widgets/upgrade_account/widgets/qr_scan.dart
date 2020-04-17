import 'package:Core/core/translate/public.dart';
import 'package:Core/utils/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_code_scanner/qr_scanner_overlay_shape.dart';

const flash_on = "FLASH ON";
const flash_off = "FLASH OFF";

class QrScan extends StatefulWidget {
  final Function(dynamic) onScanSuccess;
  QrScan({Key key, @required this.onScanSuccess})
      : assert(
            onScanSuccess != null, 'Bắt buộc phải có hàm onScanSuccess data'),
        super(key: key);

  @override
  _QrScanState createState() => _QrScanState();
}

class _QrScanState extends State<QrScan> {
  var flashState = flash_off;
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Image(
        image: AssetImage('assets/images/background_appbar.jpg'),
        fit: BoxFit.cover,
        alignment: AlignmentDirectional.center,
      ),
        actions: _buildButtton(),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderColor: colorBlue,
          borderRadius: 0,
          borderLength: 10,
          borderWidth: 10,
          cutOutSize: 300,
        ),
      ),
    );
  }

  List<Widget> _buildButtton() {
    List<Widget> out = [];
    if (_isFlashOn(flashState)) {
      out.add(FlatButton.icon(
          onPressed: () => onClickFLash(),
          icon: Icon(
            Icons.flash_off,
            color: colorWhite,
          ),
          label: Text(tr('upgrade_salon_34'),
              style: style15.copyWith(color: colorWhite))));
      // out.add(Text(tr('upgrade_salon_34')));
    } else {
      out.add(FlatButton.icon(
          onPressed: () => onClickFLash(),
          icon: Icon(
            Icons.flash_on,
            color: colorWhite,
          ),
          label: Text(tr('upgrade_salon_35'),
              style: style15.copyWith(color: colorWhite))));
      // out.add(Text(tr('upgrade_salon_35')));
    }
    return out;
  }

  onClickFLash() {
    controller.toggleFlash();
    if (_isFlashOn(flashState)) {
      setState(() {
        flashState = flash_off;
      });
    } else {
      setState(() {
        flashState = flash_on;
      });
    }
  }

  bool _isFlashOn(String current) {
    return flash_on == current;
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      // controller.toggleFlash();
      controller.pauseCamera();
      Future.delayed(const Duration(milliseconds: 1000), () {
        //push value to page
        widget.onScanSuccess(cutTextToLastLink(scanData));
        Navigator.of(context).pop();
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  /*
    @author Bình
   */
  cutTextToLastLink(String url) {
    if (url == null || url.trim().isEmpty == true) {
      return '';
    }
    List<String> tam = url.split('/');

    if (tam.isEmpty == true) {
      return '';
    }
    return tam[tam.length - 1];
  }
}

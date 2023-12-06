import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRCodeScannerPage extends StatefulWidget {
  const QRCodeScannerPage({Key? key}) : super(key: key);

  @override
  State<QRCodeScannerPage> createState() => _QRCodeScannerPageState();
}

class _QRCodeScannerPageState extends State<QRCodeScannerPage> {
  Barcode? result;
  QRViewController? controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Scanner'),
      ),
      body: Builder(
        builder: (BuildContext context) {
          return Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: QRView(
                  key: const Key('qrv'),
                  onQRViewCreated: (controller) {
                    setState(() {
                      this.controller = controller;
                    });
                  },
                  onPermissionSet: (QRViewController controller, bool p) {
                    if (!p) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('QR Code Scanner permission denied'),
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
              Center(
                child: Text(
                  result != null ? result!.code : '',
                  style: const TextStyle(fontSize: 18.0),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

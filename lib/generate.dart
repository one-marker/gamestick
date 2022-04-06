import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';

// class GeneratePage extends StatelessWidget {
//   String data;
//
//
//   GeneratePage(String _data) {
//     data = _data;
//   }
//   @override
//   State<StatefulWidget> createState() => GeneratePageState("afsdf");
//
//
// }

class GeneratePageState extends StatelessWidget {
  String qrData;  // already generated qr code when the page opens

  GeneratePageState(String _qrData) {
    qrData= _qrData;
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(

        leading: IconButton(

              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
                //advancedPlayer.stop();
              },
            ),

        backgroundColor: Colors.transparent,
        elevation: 0.0,



      ),
      body: Container(

        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            QrImage(
              //plce where the QR Image will be shown
              data: qrData,
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
            ),

          ],
        ),
      ),
    );
  }

  final qrdataFeed = TextEditingController();
}

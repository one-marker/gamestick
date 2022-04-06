import 'dart:async';
import 'dart:convert';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ScanPage extends StatefulWidget {
  String data;
  ScanPage(String data) {
    this.data = data;
  }
  @override
  _ScanPageState createState() => _ScanPageState(data);
}

class _ScanPageState extends State<ScanPage> {
  String data;
  String game = '''data:text/html,<html><head><title>Змейка</title><style>html,body{height:100%;margin:0}body{background:black;display:flex;align-items:center;justify-content:center}canvas{border:1px solid white}</style></head><body><canvas width="400"height="400"id="game"></canvas><script>var canvas=document.getElementById('game');var touchsurface=canvas,swipedir,startX,startY,distX,distY,threshold=150,restraint=100,allowedTime=300,elapsedTime,startTime;var context=canvas.getContext('2d');var grid=16;var count=0;var snake={x:160,y:160,dx:grid,dy:0,cells:[],maxCells:4};var apple={x:320,y:320};function getRandomInt(min,max){return Math.floor(Math.random()*(max-min))+min}function loop(){requestAnimationFrame(loop);if(++count<14){return}count=0;context.clearRect(0,0,canvas.width,canvas.height);snake.x+=snake.dx;snake.y+=snake.dy;if(snake.x<0){snake.x=canvas.width-grid}else if(snake.x>=canvas.width){snake.x=0}if(snake.y<0){snake.y=canvas.height-grid}else if(snake.y>=canvas.height){snake.y=0}snake.cells.unshift({x:snake.x,y:snake.y});if(snake.cells.length>snake.maxCells){snake.cells.pop()}context.fillStyle='red';context.fillRect(apple.x,apple.y,grid-1,grid-1);context.fillStyle='green';snake.cells.forEach(function(cell,index){context.fillRect(cell.x,cell.y,grid-1,grid-1);if(cell.x===apple.x&&cell.y===apple.y){snake.maxCells++;apple.x=getRandomInt(0,25)*grid;apple.y=getRandomInt(0,25)*grid}for(var i=index+1;i<snake.cells.length;i++){if(cell.x===snake.cells[i].x&&cell.y===snake.cells[i].y){snake.x=160;snake.y=160;snake.cells=[];snake.maxCells=4;snake.dx=grid;snake.dy=0;apple.x=getRandomInt(0,25)*grid;apple.y=getRandomInt(0,25)*grid}}})}touchsurface.addEventListener('touchstart',function(e){var touchobj=e.changedTouches[0];swipedir='none';dist=0; startX=touchobj.pageX; startY=touchobj.pageY; startTime=new Date().getTime();e.preventDefault()},false);touchsurface.addEventListener('touchmove',function(e){e.preventDefault()},false);touchsurface.addEventListener('touchend',function(e){var touchobj=e.changedTouches[0];distX=touchobj.pageX-startX ;distY=touchobj.pageY-startY; elapsedTime=new Date().getTime()-startTime; if(elapsedTime<=allowedTime){if(Math.abs(distX)>=threshold&&Math.abs(distY)<=restraint){swipedir=(distX<0)?'left':'right'}else if(Math.abs(distY)>=threshold&&Math.abs(distX)<=restraint){swipedir=(distY<0)?'up':'down'}}if(swipedir==='left'&&snake.dx===0){snake.dx=-grid;snake.dy=0}else if(swipedir==='up'&&snake.dy===0){snake.dy=-grid;snake.dx=0}else if(swipedir==='right'&&snake.dx===0){snake.dx=grid;snake.dy=0}else if(swipedir==='down'&&snake.dy===0){snake.dy=grid;snake.dx=0}handleswipe(swipedir);e.preventDefault()},false);requestAnimationFrame(loop);</script></body></html>''';
  String qrCodeResult = "Not Yet Scanned";
 // Completer<WebViewController> _controller = Completer<WebViewController>();
  WebViewController _controller;

  _ScanPageState(String data) {
    this.data = data;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Flutter WebView example'),
      // ),
      body: WebView(
        initialUrl: '',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) async {
          _controller = webViewController;
          await loadHtmlFromAssets(_controller);
        },
        // initialUrl: game,
        // onWebViewCreated: (WebViewController webViewController) {
        //   _controller.complete(webViewController);
        // },
      ),
    );
  }
  Future<void> loadHtmlFromAssets(controller) async {
    //String fileText = await rootBundle.loadString(filename);
    controller.loadUrl(Uri.dataFromString(data, mimeType: 'text/html', encoding: Encoding.getByName('utf-8')).toString());
  }

    /*Scaffold(
      appBar: AppBar(
        title: Text("Scanner"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "Result",
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              qrCodeResult,
              style: TextStyle(
                fontSize: 20.0,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20.0,
            ),
            FlatButton(
              padding: EdgeInsets.all(15.0),
              onPressed: () async {


                String codeSanner = await BarcodeScanner.scan();    //barcode scnner
                setState(() {
                  qrCodeResult = codeSanner;
                });

                // try{
                //   BarcodeScanner.scan()    this method is used to scan the QR code
                // }catch (e){
                //   BarcodeScanner.CameraAccessDenied;   we can print that user has denied for the permisions
                //   BarcodeScanner.UserCanceled;   we can print on the page that user has cancelled
                // }


              },
              child: Text(
                "Open Scanner",
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.blue, width: 3.0),
                  borderRadius: BorderRadius.circular(20.0)),
            )
          ],
        ),
      ),
    );
  }
*/
  //its quite simple as that you can use try and catch staatements too for platform exception
}

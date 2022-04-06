import 'dart:convert';

//import 'package:gamestick/detail_audio_page.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/cupertino.dart';
import 'file:///Users/marker/AndroidStudioProjects/museum/lib/app_colors.dart'
    as AppColors;
import 'package:flutter/material.dart';
import 'package:gamestick/scan.dart';

//import 'my_tabs.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  List popularBooks;
  List books;
  ScrollController _scrollController;
  TabController _tabController;

  ReadData() async {
    await DefaultAssetBundle.of(context)
        .loadString("json/popularBooks.json")
        .then((s) {
      setState(() {
        popularBooks = json.decode(s);
      });
    });
    await DefaultAssetBundle.of(context)
        .loadString("json/books.json")
        .then((s) {
      setState(() {
        books = json.decode(s);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    ReadData();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      //color: Colors.black54,
      child: Scaffold(
        backgroundColor: Color.fromRGBO(33, 33, 33, 100),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
              //margin: EdgeInsets.fromLTRB(75, 100, 75, 0),
              // height: 100,
              // width: 300,
              //color: Colors.green,
              child: Center(child: const Text("GAMESTICK",  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      fontFamily: "Avenir"))

              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                height: 500,
                child: Stack(children: [
                  Positioned(
                      top: 0,
                      left: -0,
                      right: 0,
                      child: Container(
                        height: 500,
                        child: PageView.builder(
                            controller: PageController(viewportFraction: 0.8),
                            itemCount:
                                popularBooks == null ? 0 : popularBooks.length,
                            itemBuilder: (_, i) {
                              return GestureDetector(
                                onTap:()  async {
                                  if (i==0) {
                                    String codeSanner = (await BarcodeScanner
                                        .scan()) as String; //barcode scnner
                                    // setState(() {
                                    //   qrCodeResult = codeSanner;
                                    // });
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                        builder: (context) =>
                                            ScanPage(codeSanner)));
                                  } else {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                        builder: (context) =>
                                            ScanPage(popularBooks[i]["game"])));
                                  }
                                },

                                child: Container(
                                height: 500,
                                width: MediaQuery.of(context).size.width,
                                margin: const EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(

                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                      image: AssetImage(popularBooks[i]["img"]),
                                      fit: BoxFit.fitWidth,
                                    )),
                              ),);

                            }),


                      ))
                ])
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              //margin: EdgeInsets.fromLTRB(75, 100, 75, 0),
              // height: 100,
              // width: 300,
              //color: Colors.green,
              child: Center(child: const Text("by mireastick",  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color.fromRGBO(146, 146, 146, 100),
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      fontFamily: "Avenir"))

              ),
            ),
          ],
        ),
      ),
    );
  }
}

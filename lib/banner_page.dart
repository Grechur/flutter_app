import 'package:flutter/material.dart';

class BannerPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _BannerPage();
  }
}

class _BannerPage extends State<BannerPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('广告页'),
      ),
      body: new PageView(
        controller: new PageController(
          initialPage: 0,
          keepPage: true,
        ),
        children: <Widget>[
          new Image.asset("images/banner.jpg"),
          new Image.asset("images/banner1.jpg"),
          new Image.asset("images/banner2.jpg"),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

class NewsDetail extends StatefulWidget{

  NewsDetail ({Key key,this.title}):super(key:key);
  final String title;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _NewsDetail(title:title);
  }
}

class _NewsDetail extends State<NewsDetail>{
  _NewsDetail({Key key,this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(title),
      ),
    );
  }
}
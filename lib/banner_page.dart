import 'dart:async';

import 'package:flutter/material.dart';

class BannerPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _BannerPage();
  }
}

class _BannerPage extends State<BannerPage>{
  static int fakeLength = 1000;
  PageController _pageController =
  new PageController(initialPage: fakeLength ~/ 2);

  Timer _timer;

  Duration _bannerDuration = new Duration(seconds: 3);

  Duration _bannerAnimationDuration = new Duration(milliseconds: 500);

  bool _isEndScroll = true;

  int _curPageIndex = 0;

  int _curIndicatorsIndex = 0;
  @override
  void initState() {
    super.initState();
    _curPageIndex = fakeLength ~/ 2;

    initTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('广告页'),
      ),
      body: new NotificationListener(
      onNotification: (ScrollNotification scrollNotification) {
      if (scrollNotification is ScrollEndNotification || scrollNotification is UserScrollNotification) {
      _isEndScroll = true;
      } else {
      _isEndScroll = false;
      }
      return false;
      },
      child:new PageView(
        controller: _pageController,
        children: <Widget>[
          new Image.asset("images/banner.jpg"),
          new Image.asset("images/banner1.jpg"),
          new Image.asset("images/banner2.jpg"),
        ],
        onPageChanged: (index) {
          _changePage(index);
        },
      ),
    ),
    );
  }

  void _changePage(int index) {
    _curPageIndex = index;
    //获取指示器索引
    _curIndicatorsIndex = index % 3;
    setState(() {});
  }


  initTimer() {
    _timer = new Timer.periodic(_bannerDuration, (timer) {
      if(_isEndScroll){
        _pageController.animateToPage(_curPageIndex + 1,
            duration: _bannerAnimationDuration, curve: Curves.linear);
      }
    });
  }
}
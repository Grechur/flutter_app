import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BannerPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _BannerPage();
  }
}

class _BannerPage extends State<BannerPage>{
  PageController _pageController =
  new PageController();

  List<String> data = ["images/banner.jpg","images/banner1.jpg","images/banner2.jpg"];

  List<String> bannerList = [];

  List<Widget> widgets = [];
  
  Timer _timer;

  Duration _bannerDuration = new Duration(seconds: 3);

  Duration _bannerAnimationDuration = new Duration(milliseconds: 500);

  bool _isEndScroll = true;

  int _curPageIndex = 0;

  int _curIndicatorsIndex = 0;

  bool isFirst = true;



  @override
  void initState() {
    super.initState();

    initTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    _initData();
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('广告页'),
      ),
      body: new NotificationListener(
      onNotification: (ScrollNotification scrollNotification) {
      if (scrollNotification is ScrollEndNotification || scrollNotification is UserScrollNotification) {
        if (_curPageIndex == 0) {
          setState(() {
            _curPageIndex =  bannerList.length~/2;
            _pageController.jumpToPage(_curPageIndex);
          });
        }
          _isEndScroll = true;
        } else {
          _isEndScroll = false;
        }
        return false;
      },
      child:
      new PageView.custom(
        controller: _pageController,
        physics: const PageScrollPhysics(parent: const BouncingScrollPhysics()),
        onPageChanged: (index) {
          _changePage(index);
        },
      childrenDelegate: SliverChildBuilderDelegate((context, index){
      int current = index % data.length;
      String bannerWithEval = bannerList[current];
      return GestureDetector(
      onTap: (){
        print(current);
      },
      child: Image.asset(bannerWithEval,
        fit: BoxFit.fitWidth),);
      },
      childCount: bannerList.length,
      ),

      ),
      )
    );
  }

  void _changePage(int index) {
    _curPageIndex = index;
    //获取指示器索引
    _curIndicatorsIndex = index % data.length;
    setState(() {});
  }

  _initData(){
    int index = data.length-1;
    if(isFirst||_curPageIndex%data.length==index) {
      isFirst = false;
//      for(int i = 0;i<2;i++){
        bannerList.addAll(data);
//      }
    }
    print(bannerList.length);
  }

  initTimer() {
    _timer = new Timer.periodic(_bannerDuration, (timer) {
      if(_isEndScroll){
        _curPageIndex += 1;
        print(_curPageIndex);
        _pageController.animateToPage(_curPageIndex,
            duration: _bannerAnimationDuration, curve: Curves.linear);
      }
    });
  }

  List<Widget> buildTabPage() {
    int index = data.length-1;
    if(isFirst||_curPageIndex%data.length==index) {
      isFirst = false;
      for (int i = 0; i < data.length; i++) {
        widgets.insert(i, _itemWidget(i));
      }
    }
//    print("widgets");
//    print(widgets.length);
    return widgets;
  }

  Widget _itemWidget(int i) {
    return new Container(
      child: new GestureDetector(
        onTap: ()=>setState(() {
          print(i);
        }),
        child: new Image.asset(bannerList[i]),
      )
    );
  }


}
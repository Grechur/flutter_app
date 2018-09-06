import 'package:flutter/material.dart';
import './banner_evalutor.dart';
import 'package:meta/meta.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:async';

class BannerWidget extends StatefulWidget{
  final List<BannerWithEval> data;
  final int height,delayTime,duration,count;
  final ItemBuild build;
  final OnClick onClick;
  final Curve curve;
  final IndicatorBuild indicator;

  BannerWidget({
    Key key,
    @required this.data,
    @required this.curve,
    this.indicator,
    this.build,
    this.onClick,
    this.height = 160,
    this.delayTime = 2000,
    this.duration = 3000,
    this.count = 30
  }): super(key : key);

  createState() => BannerState();
}

class BannerState extends State<BannerWidget>{
  Timer timer;
  PageController controller;
  int position,currentPage;
  List<Widget> bannerWidget = [];
  List<BannerWithEval> bannerList = [];
  bool isRoll = true;

  @override
  void initState() {
    super.initState();
    position = 0;
    currentPage = getRealCount() -1;
    controller = PageController(initialPage: getRealCount());
    restTime();
  }

  @override
  Widget build(BuildContext context) {
    restData();
    return Container(
        height: widget.height.toDouble(),
        color: Colors.grey,
        child: Stack(
          children: <Widget>[
            _pageView(),
            _indicator(),
          ],
        ));
  }

  Widget _pageView() {
    return Listener(
      onPointerDown: (event){
        isRoll = false;
      },
      onPointerUp: (event){
        isRoll = true;
      },
      onPointerCancel: (event){
        isRoll = true;
      },
      child: NotificationListener(
        onNotification: (scrollNotification){
          if (scrollNotification is ScrollEndNotification || scrollNotification is UserScrollNotification) {
            if (currentPage == 0) {
              setState(() {
                currentPage =  widget.count~/2;
                controller.jumpToPage(currentPage);
              });
            }
            isRoll = true;
          } else {
            isRoll = false;
          }
        },
        child: PageView.custom(
          controller: controller,
          onPageChanged: onPageChanged,
          physics: const PageScrollPhysics(parent: const BouncingScrollPhysics()),
          childrenDelegate: SliverChildBuilderDelegate((context, index){
              int current = index % getRealCount();
              BannerWithEval bannerWithEval = bannerList[current];
              return GestureDetector(
                onTap: (){
                  widget.onClick(current, bannerWithEval);
                },
                child: widget.build != null ? widget.build(current) : CachedNetworkImage(
                    imageUrl: bannerWithEval.bannerUrl,
                    fit: BoxFit.cover),);
            },
            childCount: bannerList.length,
          ),
        ),),
    );
  }

  Widget _indicator() {
    return widget.indicator == null ? Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 28.0,
          margin: const EdgeInsets.only(left: 0.0,top: 0.0,bottom: 5.0,right: 0.0),
          padding: EdgeInsets.all(2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(children: _circularPoint())
            ],
          ),
        )) : widget.indicator(position,getRealCount());
  }

  List<Widget> _circularPoint() {
    List<Widget> widgetList = [];
    int count = getRealCount();
    for (var i = 0; i < count; i++) {
      widgetList.add(Container(
        width: 8.0,
        height: 8.0,
        margin: EdgeInsets.all(2.0),
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          color: position == i ? Colors.black38 : Colors.white,
        ),
      ));
    }
    return widgetList;
  }

  void restData(){
    for(int i = 0;i<2;i++){
      bannerList.addAll(widget.data);
    }
  }

  onPageChanged(index) {
    currentPage = index;
    position = index % getRealCount();
    setState(() {});
  }

  int getRealCount() => widget.data.length;

  void restTime() {
    if (timer == null){
      timer = Timer.periodic(Duration(milliseconds: widget.delayTime), (timer) {
        if (isRoll){
          currentPage+1;
          controller.nextPage(duration: new Duration(milliseconds: widget.duration),
              curve: widget.curve);
        }
      });
    }
  }

  void cancelTime(){
    timer?.cancel();
    timer = null;
  }

  @override
  void dispose() {
    super.dispose();
    cancelTime();
    controller?.dispose();
    controller = null;
    bannerWidget.clear();
    bannerList.clear();
    bannerWidget = null;
    bannerList = null;
  }
}

//Banner中滚动的Item
typedef Widget ItemBuild(int position);

//在这添加自定义的指示器，默认圆点
typedef Widget IndicatorBuild(int position,int count);

//点击监听
typedef void OnClick(int position, BannerWithEval bannerWithEval);
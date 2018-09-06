import 'package:flutter/material.dart';
import 'package:flutter_app/banner/banner.dart';
import 'package:flutter_app/banner/banner_evalutor.dart';

class BaseBannerPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _BaseBannerPage();
  }
}

class _BaseBannerPage extends State<BaseBannerPage>{

  static final List<Model> data = [
    new Model(imgUrl: 'https://img01.sogoucdn.com/app/a/100520093/60d2f4fe0275d790-007c9f9485c5acfd-bdc6566f9acf5ba2a7e7190734c38920.jpg',desc: '海贼王'),
    new Model(imgUrl: 'http://img5.duitang.com/uploads/item/201507/07/20150707231358_z4PQr.jpeg',desc: '二次元'),
    new Model(imgUrl: 'http://img4.duitang.com/uploads/item/201502/27/20150227083741_w5YjR.jpeg',desc: "天使"),
    new Model(imgUrl: 'http://img4.duitang.com/uploads/item/201501/06/20150106081248_ae4Rk.jpeg',desc: '黑与白'),
    new Model(imgUrl: 'http://pic1.win4000.com/wallpaper/a/59322eda4daf0.jpg',desc:'少女战士'),
    new Model(imgUrl: 'http://uploads.5068.com/allimg/1711/151-1G130093R1.jpg'),
  ];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('广告栏'),
      ),
      body: new Container(
        child:BannerWidget(
          data: data,
          curve: Curves.linear,
          indicator: (position,count) => _indicator(position,count),
          onClick: (position,bannerWithEval){
            print(position);
          },
        ),
      ),
    );
  }


  Widget _indicator(int position,int count) {

    return Stack(children: <Widget>[
      Align(alignment: Alignment.bottomCenter,
          child: Container(
            height: 28.0,
            margin: const EdgeInsets.only(left: 0.0,top: 0.0,bottom: 5.0,right: 0.0),
            padding: EdgeInsets.all(2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(children: _circularPoint(position,count))
              ],
            ),
          )),
        Align(
          alignment: Alignment.bottomLeft,

          child: new Text(data[position].bannerDesc,style:new TextStyle(color: Colors.white),),
        ),

    ],


    ) ;
  }

  List<Widget> _circularPoint(int position,int count) {
    List<Widget> widgetList = [];
    for (var i = 0; i < count; i++) {
      widgetList.add(
            Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.all(2.0),
              decoration: new BoxDecoration(
                shape: BoxShape.circle,
      //         color:  Colors.white,
                color: position == i ? Colors.red : Colors.white,
              ),
            )
      );

    }
    return widgetList;
  }

}

class Model extends Object with BannerWithEval {
  final String imgUrl;
  final String desc;

  Model({this.imgUrl,this.desc});

  @override
  get bannerUrl => imgUrl==null?'images/banner':imgUrl;

  // TODO: implement desc
  @override
  get bannerDesc => desc == null?"":desc;
}
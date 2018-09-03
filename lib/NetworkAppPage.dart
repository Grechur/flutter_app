import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Constant.dart';
import 'package:flutter_app/ai_model.dart';
import 'package:flutter_app/hot_news_model.dart';
import 'package:flutter_app/news_detail.dart';

class NetworkAppPage extends StatefulWidget{
    @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _NetworkAppPage();
  }
}

class _NetworkAppPage extends State<NetworkAppPage>{
  var _result = '';
  var _decodeResult = '';

  var httpClient = new HttpClient();

  var dio_url = 'https://news-at.zhihu.com/api/4/news/latest';
  var url = Constant.baseUrl + 'Android/1/1';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("网络请求"),
        centerTitle: true,

      ),
      body: new ListView(
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
            child: new RaisedButton(
                textColor: Colors.black,
                child: new Text('不使用第三方库加载数据'),
                onPressed: _loadData),
          ),
          new Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
            child: new RaisedButton(
                textColor: Colors.black,
                child: new Text('使用第三方dio库加载数据'),
                onPressed: _loadDataByDio),
          ),
          new Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
            child: new Text('原始数据：\n$_result'),
          ),
          new Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
            child: new Text('解析后的数据：\n$_decodeResult'),
          ),

        ],
      ),
      endDrawer: new Drawer(child: new ListView.builder(itemCount: storiesList.length,itemBuilder: buildItem),),
      floatingActionButton: new FloatingActionButton(onPressed: null),
    );
  }

  _loadData() async{
    try {
      var request = await httpClient.getUrl(Uri.parse(dio_url));
      var response = await request.close();
      if (response.statusCode == HttpStatus.OK) {
        _result = await response.transform(UTF8.decoder).join();
        _decodeJson(_result, true);
      } else {
        _result = 'error code : ${response.statusCode}';
      }
    } catch (exception) {
      _result = '网络异常';
    }

    // If the widget was removed from the tree while the message was in flight,
    // we want to discard the reply rather than calling setState to update our
    // non-existent appearance.
    if (!mounted) return;

    setState(() {});
  }

  //使用第三方库Dio的请求
  Dio dio = new Dio();

  _loadDataByDio() async {
    try {
      Response response = await dio.get(dio_url);
      if (response.statusCode == HttpStatus.OK) {
        _result = response.data.toString();
        _decodeTest(response.data);
      } else {
        _result = 'error code : ${response.statusCode}';
      }
    } catch (exception) {
      print('exc:$exception');
      _result = '网络异常';
    }

    setState(() {});
  }
  List<HotNewsStoriesModel> storiesList = new List<HotNewsStoriesModel>();
  _decodeTest(var body) {

    String date = body['date'];

    List stories = body['stories'];

    List topStories = body['top_stories'];

    storiesList = stories.map((model) {
      return new HotNewsStoriesModel.fromJson(model);
    }).toList();


    List<HotNewsTopStoriesModel> topStoriesList = topStories.map((model) {
      return new HotNewsTopStoriesModel.fromJson(model);
    }).toList();

    HotNewsModel hotNewsModel = new HotNewsModel(
        date: date, stories: storiesList, top_stories: topStoriesList);

    print(topStoriesList.length);

    print(storiesList.length);


    storiesList.forEach((model) => print('${model.images}:${model.id}:${model.title}:${model.type}'));

    for(HotNewsStoriesModel model in storiesList){
      _decodeResult =
      '图片：${model.images}\nID：${model.id}\n标题：${model.title}\n类型：${model.type}';
    }
    setState(() {});
  }


  _decodeJson(var body, bool isDio) {
    var json;

    if (isDio) {
      //如果是Dio则不需要jsonDecode
      json = body;
    } else {
      json = jsonDecode(body);
    }

    List flModels = json['results'];

    List<AIModel> list = flModels.map((model) {
      return new AIModel.fromJson(model);
    }).toList();

    for (AIModel model in list) {
      _decodeResult =
      '作者：${model.who}\n描述：${model.desc}\n地址：${model.url}\n时间：${DateTime.parse(
          model.publishedAt)}';
      setState(() {});
    }


  }

  Widget buildItem(BuildContext context, int index) {
    HotNewsStoriesModel hotNewsStoriesModel = null;
    if(storiesList.length>0) hotNewsStoriesModel = storiesList[index];
    if(hotNewsStoriesModel == null) return new Text("");
    return new GestureDetector(
      child: new Container(
                child: new Row(
                  children: <Widget>[
                    new Image.network(hotNewsStoriesModel.images[0],width: 150.0,height: 150.0,),

                    new Container(
                      child: new Column(children: <Widget>[
                        new Text(hotNewsStoriesModel.title,style: new TextStyle(fontSize: 16.0,color: Colors.blue),
                          softWrap: true,textAlign: TextAlign.left,maxLines: 3,overflow: TextOverflow.ellipsis,),
                        new Text(hotNewsStoriesModel.type.toString(),style: new TextStyle(fontSize: 14.0,color: Colors.grey)),
                        new Text(hotNewsStoriesModel.id.toString(),style: new TextStyle(fontSize: 14.0,color: Colors.grey))
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.center,),
                      padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 10.0),
                      margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                      width: 133.0,
                    ),

                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,),
                color: Colors.white,
                padding: EdgeInsets.all(10.0),

      ),
      onTap:(){
        setState(() {
          Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new NewsDetail(title: hotNewsStoriesModel.title,)));
          print('row $index');
        });
      },
    );
  }


}

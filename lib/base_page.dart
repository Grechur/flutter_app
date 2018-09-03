import 'package:flutter/material.dart';

class BaseViewPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = new TextEditingController();
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("基础控件"),
        centerTitle: true,//是否居中
      ),
      body: new Column(
        children: <Widget>[
          new ConstrainedBox(
            constraints: new BoxConstraints(
                minWidth: 100.0,
                maxWidth: 200.0,
                minHeight: 40.0,
                maxHeight: 60.0
            ),
            child: new TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(
                prefixIcon: new Icon(Icons.search),
                suffixIcon: new GestureDetector(
                  child: new Icon(Icons.cancel),
                  onTap: ()=>_controller.clear(),
                ),
                border: new OutlineInputBorder(borderSide: new BorderSide(color: Colors.red)),

              ),
            ),

          ),
          new Text("横向布局"),
          new Row(
            children: <Widget>[
              new Text("文本"),
              new Image.asset("images/own_message_order.png"),
              new RaisedButton(onPressed: null,child: new Text('按钮'),)
            ],
          ),
          new Text("占位符"),
          new Placeholder(
            fallbackHeight: 150.0,
            fallbackWidth: 150.0,
            color: Colors.red,
          ),
          new Text("图标"),
          new FlutterLogo(
            size: 150.0,
            textColor: Colors.blue,
          ),

        ],
      ),
    );
  }


}
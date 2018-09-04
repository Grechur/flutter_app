import 'package:flutter/material.dart';

class BaseViewPage extends StatefulWidget{


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _BaseViewPage();
  }
}

class _BaseViewPage extends State<BaseViewPage>{
  String _textSub = '';
  final TextEditingController _controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {

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
              keyboardType: TextInputType.text,
              autofocus: true,
              autocorrect: false,
              decoration: new InputDecoration(
                prefixIcon: new Icon(Icons.search),
                suffixIcon: new GestureDetector(
                  child: new Icon(Icons.cancel),
                  onTap: ()=>_controller.clear(),
                ),
                border: new OutlineInputBorder(

                    borderSide: new BorderSide(
                        color: Colors.orange,
                        width: 0.0,
                        style: BorderStyle.solid),
                    gapPadding: 10.0,
                    borderRadius: BorderRadius.all(const Radius.circular(20.0))),

              ),
              onSubmitted: _handleMessage,
            ),

          ),
          new Text("横向布局"),
          new Row(
            children: <Widget>[
              new Text(_textSub),
              new Image.asset("images/own_message_order.png"),
              new RaisedButton(onPressed: null,child: new Text('按钮'),)
            ],
          ),
          new Text("占位符"),
          new Placeholder(
            fallbackWidth: 10.0,
            fallbackHeight: 10.0,
            color: Colors.red,
          ),
          new Text("图标"),
          new FlutterLogo(
            size: 80.0,
            textColor: Colors.blue,
          ),

        ],
      ),
    );
  }

  void _handleMessage(String text) {
    setState(() {
      _textSub = text;
    });
  }
}
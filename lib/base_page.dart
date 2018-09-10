import 'dart:async';

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
  bool val =false;
  bool select = false;

  int rvalue = 0;

  double slid = 0.0;

  bool highLight = false;

  final snackBar =
  new SnackBar(content: new Text('这是一个SnackBar'));

  DateTime dateTime ;
  TimeOfDay timeOfDay;
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
          new Row(
            children: <Widget>[
              new Switch(value: val, onChanged: (bool val){
                _check(val);
              }),
              new Checkbox(value: select, onChanged: (bool cb) {
                setState(() {
                  select = cb;
                  print(select);
                });
              }
                ),
              new Slider(value: slid, onChanged: (double s){slideChange(s);},min: 0.0,max: 100.0,),
            ],
          ),
    new Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
        new Radio(value: 1, groupValue: rvalue, onChanged: (int rval){method1(rval);}),
        new Radio(value: 2, groupValue: rvalue, onChanged: (int rval){method1(rval);}),
        new Radio(value: 3, groupValue: rvalue, onChanged: (int rval){method1(rval);}),
        new RaisedButton(onPressed: ()=>rButton(),
          color:Colors.blue,
          textTheme: ButtonTextTheme.accent,
          child: new Text("raisedbtn",style: new TextStyle(color: highLight?Colors.white:Colors.yellowAccent),),
          shape: StadiumBorder(side: const BorderSide(color:Colors.lightGreenAccent,width: 1.0, style: BorderStyle.solid)),
          onHighlightChanged: (bool val){_onHighlight(val);},
          highlightColor: Colors.red,),
//        Border(
//          top: const BorderSide(color:Colors.lightGreenAccent,width: 1.0, style: BorderStyle.solid),
//          right: const BorderSide(color:Colors.lightGreenAccent,width: 1.0, style: BorderStyle.solid),
//          bottom: const BorderSide(color:Colors.lightGreenAccent,width: 1.0, style: BorderStyle.solid),
//          left: const BorderSide(color:Colors.lightGreenAccent,width: 1.0, style: BorderStyle.solid),
//        ),
          new Builder(builder: (BuildContext context){
            return new FlatButton(onPressed: ()=>flatClick(context),
              child: new Text("flatbtn"),
              shape:StadiumBorder(side: const BorderSide(color:Colors.lightGreenAccent,width: 1.0, style: BorderStyle.solid)) ,
              highlightColor: Colors.amberAccent,
            );
          }),

            ],
        ),
        new ButtonBar(
          children: <Widget>[
            new IconButton(icon: new Icon(Icons.home), onPressed: ()=>{}),
            new FlatButton(onPressed: ()=>_showTime(), child: new Text(dateTime==null?'选择日期':dateTime.toString())),
            new FlatButton(onPressed: ()=>_showTimeofDay(), child: new Text(timeOfDay==null ? '选择时间':timeOfDay.toString()))
          ],
        )
        ],
      ),

    );
  }



  void _handleMessage(String text) {
    setState(() {
      _textSub = text;
    });
  }

  void _check(bool val) {
    setState(() {
      this.val = val;
    });
  }

  void method1(int rval) {
    setState(() {
      this.rvalue = rval;
    });
  }

  slideChange(double slid) {
    setState(() {
      this.slid = slid;
      print(slid);
    });
  }

  rButton() {
    setState(() {
      dateTime = new DateTime.now();
      print("点击按钮"+dateTime.toString());
    });


  }

  void _onHighlight(bool val) {
    setState(() {
      this.highLight = val;
    });
  }

  flatClick(BuildContext context) {
    Scaffold.of(context).showSnackBar(snackBar);
  }

  _showTime() {
    _selectDate(context);
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime _pick = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(1991),
        lastDate: new DateTime(2050)
    );
    if(_pick!=null){
      setState(() {
        dateTime = _pick;
      });
    }
  }


  _showTimeofDay() {
    _selectTime(context);
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay _pick = await showTimePicker(
        context: context,
        initialTime: new TimeOfDay.now(),

    );
    if(_pick!=null){
      setState(() {
        timeOfDay = _pick;
      });
    }
  }


}
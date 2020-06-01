import 'dart:ffi';

import 'package:flutter/material.dart';



void main() {
  return runApp(MaterialApp(
    title: "switching screens",
    home: Home(),
  ));
}


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var _nameFielsController = new TextEditingController();
  
  Future _goToNextScreen(BuildContext context) async{
    Map result = await Navigator.of(context).push(
      new MaterialPageRoute(builder: (BuildContext context){
        return new NextScreen(name:  _nameFielsController.text,);
      })
    );
    if (result!=null && result.containsKey("info")){
      print(result["info"].toString());
      _nameFielsController.text = result["info"] ;  
    }
    else{
      print("nothing");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text("FirstScreen"),
        centerTitle: true,

      ),
      body: new ListView(
        children: <Widget>[
          new ListTile(
            title: new TextField(
              controller: _nameFielsController,
              decoration: new InputDecoration(
                labelText: "Enter your name"
              ),
            ),
          ),
          new ListTile(
            title: new RaisedButton(onPressed: (){_goToNextScreen(context);},
            child:new Text("Send to NextScreen") ,
            ),
          )
        ],

      ),
    );
  }
}


class NextScreen extends StatefulWidget {



  final String name ; 

  NextScreen({Key key , this.name}) : super(key : key);
  @override
  _NextScreenState createState() => _NextScreenState();
}

class _NextScreenState extends State<NextScreen> {
  var _backScreenController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.greenAccent,
        title: new Text("Second Screen"),
        centerTitle: true,
      ),
      body: Container(
        child: new ListView(
          children: <Widget>[
            new ListTile(
              title: new Text("${widget.name}"),
            ),
            new ListTile(
              title: new TextField(
                controller:  _backScreenController,
              ),
              
            ),
            new ListTile(
              title : new FlatButton(
                onPressed: 
                (){
                  Navigator.pop(context , {
                    'info':_backScreenController.text
                  });
                }, 
              child: new Text("Send data back"))
            )
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main(){
  runApp(MaterialApp(
    title: "shared preferences",
    home: Home(),
  ));
}


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _enterDataFieldController = new TextEditingController();
  String _savedData= "" ;

  @override
  void initState() {
    
    super.initState();
    _loadSavedData();




  }

  _loadSavedData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance() ;
    setState(() {
      if(preferences.getString("data") != null &&preferences.getString("data").isNotEmpty )
      {
         _savedData = preferences.getString("data") ;
      }else{
        _savedData = "Empty SP" ;
      }
     
    });
  }

  _saveData(String message) async {
    SharedPreferences preferences = await SharedPreferences.getInstance() ;
    preferences.setString("data", message) ;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("ReadWrite"),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      body: new Container(
        padding: const EdgeInsets.all(13.4),
        alignment: Alignment.topCenter,
        child: new ListTile(
          title: new TextField(
            controller: _enterDataFieldController,
            decoration: new InputDecoration(
              labelText: 'write Something',
            ),
          ),
          subtitle: new FlatButton(
              onPressed: () {
                _saveData(_enterDataFieldController.text) ;
              },
              child: new Column(
                children: <Widget>[
                  new Text("Save Data"),
                  new Padding(padding: EdgeInsets.all(14.5)),
                  new Text(_savedData)
                ],
              ),
          ),
        ),
      ),
    );
  }
}
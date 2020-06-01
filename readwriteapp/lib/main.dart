import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'package:path_provider/path_provider.dart';

void main() async {
 var data = await readFromFile();
 if (data != null){
   String message = await readFromFile();
   print(message) ;
 }
  runApp(MaterialApp(
    title: "IO",
    home: new Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _enterDataFieldController = new TextEditingController();
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
                writeData(_enterDataFieldController.text);
              },
              child: new Column(
                children: <Widget>[
                  new Text("Save Data"),
                  new Padding(padding: EdgeInsets.all(14.5)),
                  new FutureBuilder(
                    future: readFromFile(),
                    builder: (BuildContext context , AsyncSnapshot<String> data){
                      if(data.hasData != null)
                      {
                        return new Text(data.data.toString(),
                        style: new TextStyle(
                          color : Colors.blueAccent
                        ),
                        );
                        
                      }else{
                        return new Text("No data saved") ;
                      }
                    }
                  )
                ],
              ),
          ),
        ),
      ),
    );
  }
}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path; //home/directory:text
}

Future<File> get _localFile async {
  final path = await _localPath;
  return new File('$path/data.txt');
}

//write and read from file
Future<File> writeData(String message) async {
  final file = await _localFile;
  return file.writeAsString("$message");
}

Future<String> readFromFile() async {
  try {
    final file = await _localFile;

    ///Read
    ///
    String data = await file.readAsString();
    return data;
  } catch (e) {
    return "nothing saved here";
  }
}

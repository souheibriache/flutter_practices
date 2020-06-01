import 'dart:convert' ;

import 'package:flutter/material.dart' ; 
import 'package:http/http.dart' as http;


void main(List<String> args) async{
  List data = await getJson();
  return runApp(MaterialApp(
  title: "Json",
  home: new Home(data),
));
}
class Home extends StatefulWidget {
  @override
  List data ; 
  Home(List data){
    this.data = data ; 
  }
  _HomeState createState() => _HomeState(data);
}

class _HomeState extends State<Home> {
  var i = 0 ; 
  
  List data ;

  _HomeState(List data){
    this.data = data;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Json"),
        backgroundColor: Colors.orange,
        
      ),
     body: new ListView.builder(
       itemCount: data.length,
       itemBuilder: (BuildContext context , int position){
         return Column(
           children: <Widget>[
             Divider(height: 3.4,),
             ListTile(
               title: Text("Title ${data[position]["title"]}"),
             )
           ],
         );
       },
     ),
    );
  }
}


Future<List> getJson() async{
 String apiURL = "https://jsonplaceholder.typicode.com/posts" ; 
   http.Response response = await http.get(apiURL) ; 
  return json.decode(response.body);
}
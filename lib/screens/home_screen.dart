import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitnessapp/screens/exercise_hub.dart';
import 'package:fitnessapp/screens/exercise_start_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final String apiUrl="https://raw.githubusercontent.com/codeifitech/fitness-app/master/exercises.json";

  ExerciseHub exerciseHub;//data will be loaded in the future

  @override
  void initState() {
   getExercise();
    super.initState();
  }
 void getExercise() async{
    var response= await http.get(apiUrl);
    var body=response.body;
    var decodedJson=jsonDecode(body);
    exerciseHub=ExerciseHub.fromJson(decodedJson);
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Keep Fit')),
      body: Container(
        child: exerciseHub!=null ? ListView(
          children: exerciseHub.exercises.map((e){
            return InkWell(
              onTap: (){
                Navigator.push(
                  context, MaterialPageRoute(
                  builder:(context)=>ExerciseStartScreen(exercises: e,)
                ),
                );
              },
              child: Hero(
                tag: e.id,
                child: Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16)
                  ),
                  child: Stack(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
//                        child: FadeInImage(
//                          image:NetworkImage(e.thumbnail),
//                          placeholder: AssetImage('assets/placeholder.jpg'),
//                          width: MediaQuery.of(context).size.width,
//                          height:250 ,
//                          fit: BoxFit.cover,
//                        ),
                        child: CachedNetworkImage(
                        imageUrl:e.thumbnail,
                        placeholder:(context,url)=>Image(
                          image: AssetImage('assets/placeholder.jpg'),
                          fit: BoxFit.cover,
                          height: 250,
                          width: MediaQuery.of(context).size .width,
                        ),//Image
                        errorWidget:(context,url,error)=>
                            Icon(Icons.error),
                        fit:BoxFit.cover,
                        height:250,
                        width:MediaQuery.of(context).size.width
                      ),//CachedNetworkImage


                      ),//ClipRRect

                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 250,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFF000000),
                                Color(0xFF000000),
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.center
                            )//Lineargradient
                          ),
                        ),
                      ),//ClipRRect
                      Container(
                        height: 250,
                        alignment: Alignment.bottomLeft,
                        margin: EdgeInsets.only(left:10,bottom: 10),
                        child: Text(
                          e.title,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white
                          ),
                        ),
                      ),//Container
                    ],
                  ),//Stack
                ),
              ),
            );//Container
          }).toList(),
        ) :
        LinearProgressIndicator(),
//        width: MediaQuery.of(context).size.width,
//        color: Color(0xFF192A56),

      ),
    );
  }
}

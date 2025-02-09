import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitnessapp/screens/exercise_screen.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import 'exercise_hub.dart';

class ExerciseStartScreen extends StatefulWidget {
 final Exercises exercises;

  ExerciseStartScreen({this.exercises});

  @override
  _ExerciseStartScreenState createState() => _ExerciseStartScreenState();
}

class _ExerciseStartScreenState extends State<ExerciseStartScreen> {

  int seconds=10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Hero(
            tag: widget.exercises.id,
//        child: Image(
//          image: NetworkImage(widget.exercises.thumbnail),
//          width: MediaQuery.of(context).size.width,
//          height: MediaQuery.of(context).size.height,
//          fit: BoxFit.cover
//        ),//image
            child: Stack(
              children: <Widget>[
                CachedNetworkImage(
                    imageUrl:widget.exercises.thumbnail,
                    placeholder:(context,url)=>Image(
                      image: AssetImage('assets/placeholder.jpg'),
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size .width,
                    ),//Image
                    errorWidget:(context,url,error)=>
                        Icon(Icons.error),
                    fit:BoxFit.cover,
                    height:MediaQuery.of(context).size.height,
                    width:MediaQuery.of(context).size.width
                ),//CachednetworkImage
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          Color(0xFF000000),
                          Color(0x000000),//transparent
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.center
                    ),//LinearGradient
                  ),//BoxDecoration
                ),//Container
                Positioned(
                  bottom: 40,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 200,
                    width: 200,
                    child:  SleekCircularSlider(
                      appearance: CircularSliderAppearance(),
                      onChange: (double value) {
                        seconds=value.toInt();
                      },
                      initialValue:30,
                      min:10,
                      max:60,
                      innerWidget:(v){
                        return Container(
                          alignment: Alignment.center,
                          child: Text(
                            '${v.toInt()}S',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20
                            ),//TextStyle
                          ),//Text
                        );//Container
                      },//innerWidget
                    ),//SleekCircularSlider
                  ),//Container
                ),//Positioned
                Container(
                  alignment: Alignment.center,
                  child: RaisedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context)=>ExerciseScreen(
                          exercises: widget.exercises,
                          seconds: seconds,
                        )
                      ));//Navigator.push
                    },
                    child: Text('Start Exercise', style: TextStyle(fontSize: 20,color: Color(0xFFE83350))),
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    splashColor: Colors.black
                  ),//RaisedButton
                ),//Container
              ],//widget
            ),//stack


          ),//Hero
        ),//container
    );//Scaffold

  }
}

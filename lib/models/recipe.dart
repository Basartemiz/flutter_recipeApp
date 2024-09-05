import 'dart:typed_data'; //import for the Uint8List
import 'package:flutter/material.dart'; //import for image class
class Recipe{

  String ingr;
  String describtion;
  Uint8List image;
  int id;

  Recipe(
   this.ingr
  ,this.describtion
  ,this.id
  ,this.image
  ); //constructor

  // a method to return the model class as a map
  Map<String,dynamic> toMap(){
    Map<String,dynamic> map=Map();
    map["ing"]=ingr;
    map["des"]=describtion;
    map["id"]=id;
    map["img"]=image;
    return map;
  }

  Image getImage(){
    return Image.memory(image,
  fit: BoxFit.fill,);
  }



}
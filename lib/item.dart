import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:recipe_app/models/recipe.dart';

class Item extends StatefulWidget{
  Recipe recipe;
  Item({Key? key, required this.recipe}):super(key:key);
  @override
  State<StatefulWidget> createState() {
    return ItemState();
    
  }
  
}

class ItemState extends State<Item>{
  double height=0;
  double width=0;
  String describtion="";
  bool clicked=false; //indicating if the down button is clicked
  void revealDes(String string){
    setState(() {
      if(clicked){
        describtion="";
        height=0;
        clicked=false;
        print("no_reveal");
      }
      //reveal the describtion
      else{
        describtion=string;
        height=50;
        clicked=true;
        print("reveal");
      }
    });
  }
  @override Widget build(BuildContext context) {

      return Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.black,
              width: 0.75,
            )
          ),
          //main colomn of recipes
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Column( 
              children: [
                Padding(
                  padding: EdgeInsets.all(10), //padding between objects 
                  child: Row(
                    children: [
                      // image of recipe
                      getImage(widget.recipe.getImage()),
                      //ingredients of recipe
                      getIngredients(widget.recipe.ingr),
                    ],
                  ),
                ),
                //action button for showing the describtion
                getDescButton(widget.recipe.describtion,describtion_pressed),
                getDescribtion(describtion,height),
              ],
            
            ),
          ),
        ),
      );  }
  //function to run when descibtion is pressed
  void describtion_pressed(String string){
  
    revealDes(string);
}
}



Widget getDescribtion(String string,double height){
  return Center(
    child: Container(
      height: height,
      child:Text(string)
    ),
  );
}

Widget getDescButton(String string,Function function){
  return   Align( //alignment widget in order to put the buttom to the bottom left
    alignment: Alignment.bottomLeft,
    child: SizedBox( //sized box widget for size adjustments
      width: 15,
      height: 15,
          child: FloatingActionButton(   
                        onPressed: (){
                          function(string); //when the button is pressed the function describtion pressed takes place
                        },
                        mini: true,
                        elevation: 0.0, //remove the shadow 
                        backgroundColor: Colors.transparent,
                        child: const Center(child: Icon(
                          size: 15, //size of the given icon
                          Icons.arrow_downward))), //added icon
                        ),
  );
}

Widget getImage(Image image){
  return Expanded(
                        child: SizedBox(
                        height:100,child: image)
                      );
}

Widget getIngredients(String string){
  return Expanded(
                        child: Center(child: Text(string)));
}


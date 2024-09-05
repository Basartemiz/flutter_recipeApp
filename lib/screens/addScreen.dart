import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_app/models/recipe.dart';
import 'dart:io';

import 'package:recipe_app/utils/databaseHelper.dart';

class AddScreen extends StatefulWidget{
  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() {
    return AddState();
  }

  
}

class AddState extends State<AddScreen>{
  File? _image; //image file that needs to be chosen
  Uint8List? _imageByte; //image as bytes in order to save to the database
  int? recipe_id; //id of recipe that should be added
  TextEditingController describtionController=TextEditingController(); //text edit for describtion
  TextEditingController ingredientsController=TextEditingController(); //text edit for image

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          Container(height: 50,),
          chosePhoto(),
          addIngredients(ingredientsController),
          addDescribtion(describtionController),
          Container(height: 50,),
        ],),
      ),
      floatingActionButton: getButtons(context,ingredientsController,describtionController),
    );
  }
  @override void dispose(){
    describtionController.dispose(); //clean up the memory
    ingredientsController.dispose();
    super.dispose();
  }


  //TO DO FILL THE FUNCTIONS
  //function for adding photos , that is a photo adder
  Widget chosePhoto(){
  return Expanded(
    child:Center(
      
      child: SizedBox.expand(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          child: _image != null? SizedBox.expand(child: ClipRRect(borderRadius:BorderRadius.circular(2), child: Image.file(_image!),)): SizedBox.expand(child: Icon(size:50,Icons.add_a_photo)) ,
          onPressed: () {
          getImageFile();
        },),
      ))
    );
  }

  //widget that will enable user to add describtion to their recipes
  Widget addDescribtion(controller){
    return Expanded(child: Align(
      alignment: Alignment.topCenter,
      child: TextField(
      maxLines: null,
      decoration: InputDecoration(hintText: "add Describtion"),
      controller: controller,)), 
    );
  }

  //Widget that will enable the user to add ingredient list 
  Widget addIngredients(controller){
    return Expanded(child: Align(
      alignment: Alignment.center,
      child: TextField(
      maxLines: null,
      decoration: InputDecoration(hintText: "add Ingredients"),
      controller:controller,)),);
  }
  //button to remove the plan of the recipe and go back to the previous page
  Widget removeButton(context){
    return ClipOval(
        child: Container(
          child: FloatingActionButton(
          onPressed: ()=>{
          Navigator.pop(context)
        },
        heroTag: "removeButton",
        backgroundColor: Colors.red,
        child: Icon(Icons.undo),
        ),)
      );
  }

  Widget addButton(context,TextEditingController controllerI,TextEditingController controllerD){
    return ClipOval(
      child: Container(
        child: FloatingActionButton(
        onPressed: (){
          //adds the recipe to the database if the image is not null
          if(_image!=null){
            String ingredients=controllerI.text;  //Ingredient text
            String describtion=controllerD.text; //Describtion text
            Databasehelper db=Databasehelper(); //get the database
            db.insertRecipe(Recipe(ingredients,describtion,recipe_id!,_imageByte!)); //insert the recipe to the database
            Navigator.pop(context); //remove to the recipe list 
          }
           else{
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please add a photo")));
          }
      },
      heroTag: "addButton",
      backgroundColor: Colors.green,
      child: Icon(Icons.check),
      ),)
    );
  }
  //widget in order to display buttons
  Widget getButtons(context,controllerI,controllerD){
      return Padding(
        padding: const EdgeInsets.only(left:30.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
              removeButton(context),
              Expanded(child: Container()),
              addButton(context,controllerI,controllerD),
        ],),
      );
  }

  Future<void> getImageFile()async{
      ImagePicker _picker=ImagePicker();
      final XFile? image=await _picker.pickImage(source: ImageSource.gallery);
      if(image!=null){
        Uint8List imageBlob= (await image.readAsBytes()); //turn image to binary format for encoding 
        Databasehelper db=Databasehelper(); //get database
        recipe_id=await db.itemCount();
        setState(() {
          _image=File(image.path); //get image file
          _imageByte=imageBlob; //set the imageByte in order to save to the database
        });
      }
  }
  
}
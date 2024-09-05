

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipe_app/item.dart';
import "package:recipe_app/models/recipe.dart";
import 'package:recipe_app/screens/addScreen.dart';
import 'package:recipe_app/utils/databaseHelper.dart';


void main(){
  WidgetsFlutterBinding.ensureInitialized(); // to ensure the file system is initialized 
  runApp(MaterialApp(
    home: MyFirstPage()));
}

class MyFirstPage extends StatefulWidget{
  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() {
    return FirstState();
  }

}

class FirstState extends State<MyFirstPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Recipe>>(
        future: getRecipes(),
        builder: (context, snapshot) {
        if(snapshot.hasData){ //the future object now has obtained it's data
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context,index){ //function for the listView item builder
              return Item(recipe:snapshot.data![index]); // return an item object for the listView
            });
        }

        else{
          return const Center(child:  CircularProgressIndicator());
        }
      },),
      floatingActionButton: addButton(context),
      );
  }





Future<List<Recipe>> getRecipes() async {
  Databasehelper dbhelper=Databasehelper();
  List<Map<String,dynamic>> recipesMap= await dbhelper.getRecipes();
  List<Recipe> recipes=[];
  for(int i=0; i<recipesMap.length;i++){
    Recipe recipe=Recipe(recipesMap[i]["ing"], recipesMap[i]["des"], recipesMap[i]["id"],recipesMap[i]["img"]);
    recipes.add(recipe);
  }
  if(recipes.isEmpty){
    Uint8List imageBlob= (await rootBundle.load("lib/assets/image.PNG")).buffer.asUint8List(); //turn image to binary format for encoding 
    await dbhelper.insertRecipe(Recipe("ingr 1 ", "describtion1", 1,imageBlob)); //add recipe 1 
    await dbhelper.insertRecipe(Recipe("ingr 2 ", "describtion2", 2,imageBlob)); //add recipe 2 
    await dbhelper.insertRecipe(Recipe("ingr 3 ", "describtion3", 3,imageBlob)); //add recipe 3
    return await getRecipes();
  }
  return recipes;

}

Widget addButton(context){
  
  return ClipOval( // wrapped the widget with the clip oval in order to make the button circular
    child: FloatingActionButton(onPressed: () async {
      //main purpose should be to move to the second screen
      await Navigator.push(context,
      MaterialPageRoute(builder: (context)=>AddScreen()));
      setState((){});
    },
    heroTag: "addRecipe",
    backgroundColor: Colors.blue,
    child: const Icon(Icons.add),
    ),
  );
}


}
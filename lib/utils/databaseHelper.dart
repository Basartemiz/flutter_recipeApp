
import "dart:io";
import "dart:async";
import "package:path_provider/path_provider.dart";
import "package:sqflite/sqflite.dart";
import "package:recipe_app/models/recipe.dart";



class Databasehelper{
  static Databasehelper _databasehelper=Databasehelper._createInstance();
  static Database? _database;
  
  String ingredients="ing"; //ingridients column
  String describtion="des"; //describtion column

  Databasehelper._createInstance();

  factory Databasehelper(){
    return _databasehelper;

  }

  //initialize database when needed
  Future<Database> get database async{
    _database ??= await _initializeDb();
    return _database!;
  }

  Future<Database> _initializeDb() async{
    //get the directory path
    
    Directory directory= await getApplicationDocumentsDirectory();
    String path=directory.path+"recipes.db";
    //open the database
    Database database= await openDatabase(path,version:1,onCreate: _createDb);
    return database;
  }
   
  //creates the database 
  void _createDb(Database db,int newVersion) async {
      await db.execute('CREATE TABLE recipes ($ingredients TEXT, $describtion TEXT, id INTEGER,img BLOB)');

  }

  //get database method
  Future<Database> getDatabase() async {
    _database ??= await _initializeDb();
    return _database!;
  }
  
  //method to get all the objects from the database
  Future<List<Map<String,dynamic>>> getRecipes() async{
    Database db=await _databasehelper.database;
    return db.query("recipes");
  }

  //a method for inserting  a recipe
  insertRecipe(Recipe rp) async {
    Database db=await _databasehelper.database;
    db.insert("recipes", rp.toMap());
  }

  //a method for getting item count
  Future<int> itemCount() async{
      Database db=await this.database;
      List<dynamic> recipes = await db.query("recipes");
      return recipes.length;
  }



}
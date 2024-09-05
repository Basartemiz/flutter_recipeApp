
# Recipe App

## Overview

The Recipe App is a Flutter-based mobile application that allows users to add, view, and manage their favorite recipes. The app provides a simple user interface for storing recipes, including the ability to add descriptions, ingredients, and an image. This project demonstrates the use of Flutter widgets, state management, and a local SQLite database for storing and retrieving data.

## Features

- **Add Recipes**: Users can add recipes by entering ingredients, a description, and uploading an image.
- **View Recipes**: The home screen displays a list of all stored recipes with details.
- **Edit Recipes**: Users can update the details of a recipe.
- **SQLite Integration**: Recipes are stored in a local SQLite database for persistence.

## Screens

### 1. Home Screen (MyFirstPage)

- Displays a list of recipes retrieved from the SQLite database.
- Shows a loading spinner (CircularProgressIndicator) while data is being fetched.
- Contains a FloatingActionButton to navigate to the add recipe screen.
- Uses a `FutureBuilder` to display the list of recipes dynamically as they are fetched from the database.

### 2. Add Recipe Screen (AddScreen)

- Allows users to add a new recipe by providing the following:
  - **Photo**: Users can choose an image from the gallery.
  - **Ingredients**: Input ingredients for the recipe.
  - **Description**: Add a detailed description of the recipe.
- Provides buttons for saving or discarding the recipe.

## Dependencies

This project uses several Flutter dependencies:

```yaml
dependencies:
  flutter:
    sdk: flutter
  image_picker: ^0.8.4+4
  sqflite: ^2.0.0+3
  path_provider: ^2.0.7
```

Ensure to install these dependencies using:

```bash
flutter pub get
```

## Project Structure

The project is structured as follows:

```bash
lib/
│
├── models/
│   └── recipe.dart             # Recipe model class
│
├── screens/
│   ├── addScreen.dart          # AddRecipe screen
│   └── homeScreen.dart         # Main HomeScreen where recipes are listed
│
├── utils/
│   └── databaseHelper.dart     # SQLite database helper functions
│
├── item.dart                   # Item widget used to display individual recipes in a list
└── main.dart                   # Main entry point of the app
```

### Key Files

#### `main.dart`

This is the main entry point of the application. It initializes the widget tree and calls `MyFirstPage` to load the home screen.

#### `addScreen.dart`

This screen allows users to add recipes by selecting an image, entering ingredients, and a description. It integrates with the SQLite database to store the recipe data.

#### `databaseHelper.dart`

Contains helper methods for interacting with the SQLite database. This includes methods for inserting and retrieving recipes.

#### `item.dart`

Defines the `Item` widget, which is used to display each recipe in the `ListView` on the home screen.

## Database Schema

The app uses an SQLite database to store recipes with the following schema:

| Column       | Type        |
|--------------|-------------|
| id           | INTEGER     |
| ingredients  | TEXT        |
| description  | TEXT        |
| image        | BLOB        |

## Setup

### 1. Clone the repository

```bash
git clone https://github.com/username/recipe-app.git
cd recipe-app
```

### 2. Install Flutter

Ensure you have Flutter installed. You can install it [here](https://flutter.dev/docs/get-started/install).

### 3. Run the project

Run the following command to start the app:

```bash
flutter run
```

This will launch the app on your connected device or emulator.

## Contributions

Feel free to contribute to the project by submitting a pull request or opening an issue.

## License

This project is licensed under the MIT License.



import 'package:flutter/material.dart';
import 'screens/categories_screen.dart';

void main() {
  runApp(const RecipeApp());
}

class RecipeApp extends StatelessWidget {
  const RecipeApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Апликација за рецепти - 211257',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const CategoriesScreen(),
    );
  }
}
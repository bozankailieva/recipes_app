import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category.dart';
import '../models/meal.dart';
import '../models/meal_detail.dart';

class ApiService {
  static const String baseUrl = 'https://www.themealdb.com/api/json/v1/1';

  Future<List<Category>> getCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/categories.php'));
     
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<Category> categories = [];
      for (var item in data['categories']) {
        categories.add(Category.fromJson(item));
      }
      return categories;
    } else {
      throw Exception('Неуспешно вчитување на категориите');
    }
  }

  Future<List<Meal>> getMealsByCategory(String category) async {
    final response = await http.get(
      Uri.parse('$baseUrl/filter.php?c=$category')
    );
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<Meal> meals = [];
      if (data['meals'] != null) {
        for (var item in data['meals']) {
          meals.add(Meal.fromJson(item));
        }
      }
      return meals;
    } else {
      throw Exception('Неуспешно вчитување на рецепти по категорија');
    }
  }

  Future<MealDetail> getMealDetail(String id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/lookup.php?i=$id')
    );
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['meals'] != null && data['meals'].isNotEmpty) {
        return MealDetail.fromJson(data['meals'][0]);
      } else {
        throw Exception('Рецептот не е пронајден');
      }
    } else {
      throw Exception('Neуспешно вчитување на деталите за рецептот');
    }
  }

  Future<List<Meal>> searchMeals(String query) async {
    final response = await http.get(
      Uri.parse('$baseUrl/search.php?s=$query')
    );
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<Meal> meals = [];
      if (data['meals'] != null) {
        for (var item in data['meals']) {
          meals.add(Meal.fromJson(item));
        }
      }
      return meals;
    } else {
      throw Exception('Неуспешно пребарување на рецепт');
    }
  }

  Future<MealDetail> getRandomMeal() async {
    final response = await http.get(
      Uri.parse('$baseUrl/random.php')
    );
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['meals'] != null && data['meals'].isNotEmpty) {
        return MealDetail.fromJson(data['meals'][0]);
      } else {
        throw Exception('Не е пронајден рандом рецепт');
      }
    } else {
      throw Exception('Неуспешно вчитување на рандом рецепт');
    }
  }
}
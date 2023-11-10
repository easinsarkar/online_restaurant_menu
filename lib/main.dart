import 'package:flutter/material.dart';
import './models/dummy_data.dart';
import './models/meal.dart';
import './screens/filters_screen.dart';
import './screens/tabs_screen.dart';
import './screens/meal_detail_screen.dart';
// import './screens/categories_screen.dart';
import './screens/category_meals_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  Map<String, bool> _filters = {
    'gluten' : false,
    'lactose' : false,
    'vegan' : false,
    'vegetarian' : false,
  };
  List<Meal> _availableMeals = dummyMeals;
  List<Meal> _favoriteMeals = [];

  void _toggleFavorite(String mealDetails){
    final existingIndex = _favoriteMeals.indexWhere((element) => element.id == mealDetails);
    if( existingIndex  >= 0){
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    }
    else{
      setState(() {
        _favoriteMeals.add(dummyMeals.firstWhere((element) => element.id==mealDetails));
      });
    }
  }

  void _setFilters(Map<String, bool> filterData){
    setState(() {
      _filters = filterData;
      _availableMeals = dummyMeals.where((element) {
        if(_filters['gluten'] == true && !element.isGlutenFree){
          return false;
        }
        if(_filters['lactose'] == true  && !element.isLactoseFree){
          return false;
        }
        if(_filters['vagan'] == true  && !element.isVegan){
          return false;
        }
        if(_filters['vegetarian'] == true  && !element.isVegetarian){
          return false;
        }
        return true;
      }).toList();
    });
  }
  bool _isMealFavorite(String id){
    return _favoriteMeals.any((element) => element.id== id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Delimeals',
      theme: ThemeData(
        primaryColor: Colors.pink,
        fontFamily: 'Raleaway',
        textTheme: ThemeData.light().textTheme.copyWith(
          bodyLarge: const TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1)
          ),
          bodyMedium: const TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1)
          ),
          titleLarge: const TextStyle(
            fontSize: 20,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold
          ),
        ),
        primarySwatch: Colors.pink,
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        hoverColor: Colors.blueAccent,
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      // home: const CategoriesScreen(),
      initialRoute: '/', // defalt is '/'
    routes:{
      '/': (ctx) => TabsScreen(_favoriteMeals),
      CategoryMealsScreen.routeName:(ctx) => CategoryMealsScreen(_availableMeals,),
      MealDetailScreen.routeName:(ctx) => MealDetailScreen(_toggleFavorite, _isMealFavorite),
      FiltersScreen.routeName: (ctx) => FiltersScreen( _filters, _setFilters),
    },
    onUnknownRoute: (settings){
      return MaterialPageRoute(
        builder: (ctx)=> TabsScreen(_favoriteMeals),
      );
    },
    );
  }
}
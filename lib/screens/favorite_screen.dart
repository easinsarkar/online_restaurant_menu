import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class  FavoriteScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;
  const FavoriteScreen(this.favoriteMeals, {super.key});

  @override
  Widget build(BuildContext context) {
    if(favoriteMeals.isEmpty){
      return const Center(
        child: Text('fovorite meals list'),
      );
    }
    else{
      return  ListView.builder(itemBuilder: (context,index){
        return MealItem(
          id: favoriteMeals[index].id, 
          title: favoriteMeals[index].title, 
          imageUrl: favoriteMeals[index].imageUrl, 
          duration: favoriteMeals[index].duration, 
          complexity: favoriteMeals[index].complexity, 
          affordability: favoriteMeals[index].affordability,
        );
      },
      itemCount: favoriteMeals.length,);
    }
  }
}
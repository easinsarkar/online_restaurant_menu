import 'package:flutter/material.dart';
import '../widgets/meal_item.dart';
import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category_meals_screen';
  final List<Meal> availableMeals;
  const CategoryMealsScreen(this.availableMeals, {super.key});

  // ignore: empty_constructor_bodies
  @override
  State<CategoryMealsScreen> createState() => CategoryMealsScreenState();
}

class CategoryMealsScreenState extends State<CategoryMealsScreen> {
  late String categoryTitle;
  late List <Meal> displayedMeals;
  var _loadedInitData = false;
  @override
  void initState() {
    //...

    // TODO: implement initState
    super.initState();
  }
  @override
  void didChangeDependencies() {
    if(!_loadedInitData){
            final routesArguments= ModalRoute.of(context)
    ?.settings.arguments as Map<String,String>;
    categoryTitle = routesArguments['title'] as String;
    final categoryId = routesArguments['id'];
    displayedMeals = widget.availableMeals.where((element) {
      return element.categories.contains(categoryId);
    }).toList();
    }
  
    _loadedInitData= true;
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  void _removeMeal(String mealDetails){
    setState(() {
      displayedMeals.removeWhere((element) => element.id == mealDetails);
    });
  }
  // final String categoryId;
  @override
  Widget build(BuildContext context) {
    
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(categoryTitle),
      ),
      body: ListView.builder(itemBuilder: (context,index){
        return MealItem(
          id: displayedMeals[index].id, 
          title: displayedMeals[index].title, 
          imageUrl: displayedMeals[index].imageUrl, 
          duration: displayedMeals[index].duration, 
          complexity: displayedMeals[index].complexity, 
          affordability: displayedMeals[index].affordability,
        );
      },
      itemCount: displayedMeals.length,),
    );
  }
}
import 'package:flutter/material.dart';
// import '../widgets/meal_item.dart';
import '../models/dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  // const MealDetailScreen({super.key});
  final Function toggleFavorite;
  final Function isMealFavorite;
  const MealDetailScreen(this.toggleFavorite, this.isMealFavorite, {super.key});
  static const routeName = '/meal_detail_screen';
  Widget buildSelectionTitle( BuildContext context, text ){
    return Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              text,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          );
  }
  Widget buildContainer(Widget child){
   return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            height: 100,
            width: 300,
            child:child,
    );
  }



  @override
  Widget build(BuildContext context) {
    final mealDetails =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;

    final selectedMeal = dummyMeals.firstWhere(
      (element) => element.id == mealDetails['id'] as String,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(selectedMeal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSelectionTitle(context, 'Ingredients'),
            buildContainer(
             ListView.builder(
                itemBuilder: (ctx, index) => Card(
                  color: Theme.of(context).canvasColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                    child: Text(selectedMeal.ingredients[index]),
                  ),
                ),
                itemCount: selectedMeal.ingredients.length,
              ),
            ),
            buildSelectionTitle(context, 'Steps'),
            buildContainer(ListView.builder(
              itemBuilder: (context,index) => Column(
                children: [ListTile(
                  leading: CircleAvatar(child: Text('# ${(index+1)}'),
                  ),
                  title: Text(selectedMeal.steps[index],),
                ),
                const Divider(),
                ],
              ),
              itemCount: selectedMeal.steps.length,
            ),),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          isMealFavorite(mealDetails['id'])? Icons.star : Icons.star_border,
          ),
        onPressed: ()=>toggleFavorite(mealDetails['id']),
      ),
    );
  }
}

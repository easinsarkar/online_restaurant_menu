import 'package:flutter/material.dart';
import 'package:online_restaurent/screens/category_meals_screen.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;
  const CategoryItem({
    required this.id,
    required this.title,
    required this.color,
    });
    void _selectCategory(BuildContext context){
      Navigator.of(context).pushNamed(
        CategoryMealsScreen.routeName,
        arguments: {
          'id':id,
          'title':title,
        },
      );
      // Navigator.of(context).push(MaterialPageRoute(
      //   builder: (context){
      //     return CategoryMealsScreen(
      //       categoryId: id,
      //       categoryTitle:title
      //     );
      //   },
      // ),
      // );
    }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){return _selectCategory(context);},
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      hoverColor: Theme.of(context).hoverColor,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.5),color,],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          title,
          style:Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
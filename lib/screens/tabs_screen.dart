import 'package:flutter/material.dart';
import 'package:online_restaurent/models/meal.dart';
import '../screens/favorite_screen.dart';
import '../screens/categories_screen.dart';
import '../widgets/drawer_main.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;
  const TabsScreen(this.favoriteMeals, {super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late List<Map<String,Object>> _pages;
  @override
  void initState() {
    // TODO: implement initState
    _pages =[
    {
      'page':  const CategoriesScreen(),
      'title': 'Categories',
    },
    {
      'page': FavoriteScreen(widget.favoriteMeals),
      'title': 'Favorites',
    },
  ];
    super.initState();
  }

  int _selectedPageIndex = 0;
  void _selectPage(int index){
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title:Text( _pages[_selectedPageIndex]['title'] as String),
      ),
      drawer: const DrawerMain(),
      body: _pages[_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColorLight,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedFontSize: 14,
        currentIndex: _selectedPageIndex,
        onTap: _selectPage,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
            ),
        ],
      ),
    );
    // return  DefaultTabController(
    //   length: 2,
    //   child: Scaffold(
    //     appBar: AppBar(
    //       title: const Text('Meals'),
    //       bottom: const TabBar(
            
    //         tabs: <Widget>[
    //           Tab(
    //             icon: Icon(Icons.category),
    //             text:'Categories',
    //           ),
    //           Tab(
    //             icon: Icon(Icons.favorite),
    //             text: 'Favorite',
    //           ),
    //         ],
    //       ),
    //     ),
    //     body:const TabBarView(
    //       children: <Widget>[
    //         CategoriesScreen(),
    //         FavoriteScreen(),
    //       ],
    //     ) ,
    //   ),
    // );
  }
}
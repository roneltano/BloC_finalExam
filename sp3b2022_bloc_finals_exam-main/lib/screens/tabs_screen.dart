import 'package:flutter/material.dart';
import 'add_task_sreen.dart';
import 'complated_tasks_screen.dart';
import 'favourite_tasks_screen.dart';
import 'pending_tasks_screen.dart';
import 'my_drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _Tabs_screenState();
}

// ignore: camel_case_types
class _Tabs_screenState extends State<TabsScreen> {
  final List<Map<String, dynamic>> _pages = [
    {'page': const TasksScreen(), 'title': 'Pending Tasks'},
    {'page': const CompletedTasksScreen(), 'title': 'Completed Tasks'},
    {'page': const FavouriteTasksScreen(), 'title': 'Favourite Tasks'},
  ];

  void _addTask(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: const AddTaskScreen(),
        ),
      ),
    );
  }

  var _selectedPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title']),
        actions: [
          IconButton(
            onPressed: () => _addTask(context),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      drawer: const MyDrawer(),
      floatingActionButton: _selectedPageIndex == 0
          ? FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _addTask(context),
      )
          : null,
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedPageIndex,
          onTap: _selectPage,
          items: [
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: const Icon(Icons.incomplete_circle_sharp),
              label: 'Pending Tasks',
            ),
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: const Icon(Icons.done),
              label: 'Completed Tasks',
            ),
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: const Icon(Icons.favorite),
              label: 'Favorite Tasks',
            ),
          ]),
    );
  }
}

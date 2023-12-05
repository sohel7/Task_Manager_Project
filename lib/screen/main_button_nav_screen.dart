import 'package:copytaskmanager/screen/cancel_tasks_screen.dart';
import 'package:copytaskmanager/screen/completed_tasks_screen.dart';
import 'package:copytaskmanager/screen/new_tasks_screen.dart';
import 'package:copytaskmanager/screen/progress_tasks_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class mainBottomNav extends StatefulWidget {
  const mainBottomNav({super.key});

  @override
  State<mainBottomNav> createState() => _mainBottomNavState();
}

class _mainBottomNavState extends State<mainBottomNav> {

  int _selectedIdex = 0;
  final List<Widget> _screen = [
    NewTaskScreen(),
    ProgressTaskScreen(),
    CompletedTaskScreen(),
    CancelTaskScreen(),


  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _screen[_selectedIdex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIdex,
        onTap: (index){
          setState(() {
            _selectedIdex = index;
          });
        },
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "new Task"),
          BottomNavigationBarItem(icon: Icon(Icons.timelapse), label: "In Progress"),
          BottomNavigationBarItem(icon: Icon(Icons.done), label: "Completed"),
          BottomNavigationBarItem(icon: Icon(Icons.cancel), label: "Cancelled"),
        ],
      ),
    );
  }
}

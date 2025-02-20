import 'package:flutter/material.dart';
import 'package:todo_list_app/ui/task/create_task_page.dart';

class MainPage extends StatefulWidget {
  MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Widget> _pages = [];
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pages = [
      Container(
        color: Colors.red,
      ),
      Container(
        color: Colors.blue,
      ),
      Container(
        color: Colors.green,
      ),
      Container(
        color: Colors.amber,
      ),
      Container(
        color: Colors.purple,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121212),
      body: _pages.elementAt(currentPage),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _onShowCreateTask();
        },
        child: Icon(Icons.add),
        backgroundColor: const Color(0xff8875FF),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xff363636),
        unselectedItemColor: Colors.white,
        selectedItemColor: const Color(0xff8875FF),
        currentIndex: currentPage,
        onTap: (index) {
          if (index == 2) return;
          setState(() {
            currentPage = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('assets/png/home.png'),
            label: 'Home',
            backgroundColor: Colors.transparent,
            activeIcon: Image.asset(
              'assets/png/home.png',
              color: const Color(0xff8875FF),
            ),
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/png/calendar.png'),
            label: 'Calendar',
            backgroundColor: Colors.transparent,
            activeIcon: Image.asset(
              'assets/png/calendar.png',
              color: const Color(0xff8875FF),
            ),
          ),
          BottomNavigationBarItem(icon: Container(), label: ''),
          BottomNavigationBarItem(
            icon: Image.asset('assets/png/clock.png'),
            label: 'Focus',
            backgroundColor: Colors.transparent,
            activeIcon: Image.asset(
              'assets/png/clock.png',
              color: const Color(0xff8875FF),
            ),
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/png/user.png'),
            label: 'Profile',
            backgroundColor: Colors.transparent,
            activeIcon: Image.asset(
              'assets/png/user.png',
              color: const Color(0xff8875FF),
            ),
          ),
        ],
      ),
    );
  }

  void _onShowCreateTask() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: CreateTaskPage(),
          );
        });
  }
}

import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'ProfilePage.dart';
import 'ProgressPage.dart';
import 'GoalsPage.dart';

/// Definition of Root class, the firs class called by the main application class [MyApp]
class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  // index of the selected page on the bottom bar
  int currentPage = 0;

  // List of page widgets on the bottom bar
  List<Widget> pages = [HomePage(), ProgressPage(), GoalsPage(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentPage],

      // Buttom to add drink
      floatingActionButton: FloatingActionButton(
          // action to be performed when the buttom is pressed
          onPressed: () => setState(() {
                // temporary action when Floating Button is pressed (to modify)
                print('add drink');
              }),
          // plus sign for Floating Button
          child: const Icon(Icons.add)),

      // Locationing Floating Action Button on center
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // fixed bottom bar
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.green[100],

        destinations: const [
          // cretion of the icons for the buttom bar
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(
              icon: Icon(Icons.stacked_bar_chart), label: 'Progress'),
          NavigationDestination(icon: Icon(Icons.star), label: 'Goals'),
          NavigationDestination(
              icon: Icon(Icons.account_circle_rounded), label: 'Profile')
        ],

        // set the index of the current page based on the selected NavigationDestination
        onDestinationSelected: (int index) {
          setState(() {
            currentPage = index;
          });
        },
        selectedIndex: currentPage,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pim_group/pages/DrinkPage.dart';
import 'HomePage.dart';
import 'SleepPage.dart';
import 'GoalsPage.dart';
import 'HomePage.dart';
import 'CalendarPage.dart';

/// Definition of Root class, the first class called after the login to the App & ImpactPage
class BottomNavBarV2 extends StatefulWidget {
  @override
  _BottomNavBarV2State createState() => _BottomNavBarV2State();
}

class _BottomNavBarV2State extends State<BottomNavBarV2> {
  int currentIndex = 0;
  var pages = [
    const HomePage(),
    SleepPage(),
    GoalsPage(),
    ProgressPage(),
  ];

  var _appPageController = PageController();

  setBottomBarIndex(index) {
    setState(() {
      currentIndex = index;
    });
    _appPageController.animateToPage(index,
        duration: Duration(milliseconds: 500), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white.withAlpha(100),
      body: PageView(
        scrollDirection: Axis.horizontal,
        children: pages,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        controller: _appPageController,
      ),
      bottomNavigationBar: Container(
        width: size.width,
        height: 80,
        color: Color.fromARGB(255, 255, 255, 255),
        child: Stack(
          children: [
            CustomPaint(
              size: Size(size.width, 80),
              painter: BNBCustomPainter(),
            ),
            Center(
                heightFactor: 0.6,
                child: FloatingActionButton(
                  backgroundColor: Color.fromARGB(255, 255, 147, 15),
                  child: Icon(Icons.add),
                  elevation: 0.1,
                  onPressed: () => _toDrinkPage(context, -1),
                )),
            Container(
              width: size.width,
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.home,
                      color: currentIndex == 0
                          ? Color.fromARGB(255, 131, 7, 214)
                          : Color.fromARGB(255, 255, 255, 255),
                    ),
                    onPressed: () {
                      setBottomBarIndex(0);
                    },
                    splashColor: Colors.white,
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.nights_stay,
                        color: currentIndex == 1
                            ? Color.fromARGB(255, 131, 7, 214)
                            : Color.fromARGB(255, 255, 255, 255),
                      ),
                      onPressed: () {
                        setBottomBarIndex(1);
                      }),
                  Container(
                    width: size.width * 0.20,
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.star,
                        color: currentIndex == 2
                            ? Color.fromARGB(255, 131, 7, 214)
                            : Color.fromARGB(255, 255, 255, 255),
                      ),
                      onPressed: () {
                        setBottomBarIndex(2);
                      }),
                  IconButton(
                      icon: Icon(
                        Icons.calendar_month_outlined,
                        color: currentIndex == 3
                            ? Color.fromARGB(255, 131, 7, 214)
                            : Color.fromARGB(255, 255, 255, 255),
                      ),
                      onPressed: () {
                        setBottomBarIndex(3);
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onTappedBar(int value) {
    setState(() {
      currentIndex = value;
    });
    _appPageController.jumpToPage(value);
  }
}

//Utility method to navigate to DrinkPage
void _toDrinkPage(BuildContext context, int drinkIndex) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => DrinkPage(
                drinkIndex: drinkIndex,
              )));
} //_toDrinkPage

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Color.fromARGB(255, 194, 138, 243)
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 20);
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 20),
        radius: Radius.circular(20.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 20);
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

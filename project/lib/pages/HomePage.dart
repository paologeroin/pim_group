import 'package:flutter/material.dart';

/// Definition of HomePage class
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String convertedDateTime = "";
    convertedDateTime =
        "${now.year.toString()}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}-${now.minute.toString().padLeft(2, '0')}";
    return Scaffold(
      
        appBar: AppBar(title: const Text('App name')),
        body: Column(
          children: [
            Center(
                child: Container(
                    width: MediaQuery.of(context).size.width / 1.1,
                    height: 200,
                    margin: EdgeInsets.only(top: 15.0),
                    padding: EdgeInsets.all(20.0),
                    //color: Colors.amber,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.blue[100],
                    ),
                    child: Column(children: [
                      const Center(
                          
                              child: Text(
                                     'You are sober for:',
                                      style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 35),
                                         ),
                                    
                      ),
                      Center(
                        child: Container(
                          padding: EdgeInsets.all(10.0) ,
                          decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                      color: Colors.blue[50],),
                          child: Text(
                        convertedDateTime,
                        style: const TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 40),
                      )))
                    ])
                    //width: 0.9,
                    )),
            Center(
                child: Container(
              width: MediaQuery.of(context).size.width / 1.5,
              margin: const EdgeInsets.only(top: 70),
              //color: Colors.blue,
              child: Center(
                child: const Text('For now you saved:',style: const TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 30),)
              ),
            )),
            Center(
                child: Container(
              width: MediaQuery.of(context).size.width / 3,
              margin: const EdgeInsets.all(40.0),
              color: Colors.green,
              child: Center(
                
                child: const Text('100£',style: const TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 30),)
              ),
            )),
          ],
        ));
  }
}

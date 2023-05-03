import 'package:flutter/material.dart';

/// Definition of AboutPage class

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

 @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 97, 198, 171),
        elevation: 1,title: const Text ('About', textAlign: TextAlign.center), centerTitle: true),
      body: Column(
        children: [
          Container( 
            child: Text('!!!TO MODIFY The projects of these working group must address the Sustainable Development Goal 3 (Good health and well-being: Ensure healthy lives and promote well-being for all at all ages), Target 3.5 (Strengthen the prevention and treatment of substance abuse, including narcotic drug abuse and harmful use of alcohol).'),
                  

                  margin: const EdgeInsets.only(top: 40),
                  padding: EdgeInsets.all(25.0),
                  // Border to visualize the container
                 // decoration: BoxDecoration(
                  //  border: Border.all(),
                  //  borderRadius: BorderRadius.circular(10),
                    
                 // ),
                 ),
          SizedBox(
           height: 250,
           child: Container( 
            child: Row(
                children: [
                  Image.asset('assets/images/unipd-universita-di-padova.png',
                  height: 160.0,
                  width: 160.0,
                  fit: BoxFit.contain,),
                  new Spacer(),
                  Image.asset('assets/images/dei-logo.png',
                  height: 160.0,
                  width: 160.0,
                  fit: BoxFit.contain,),
                  ]
                  ),

                  margin: EdgeInsets.all(15),
                  //margin: const EdgeInsets.only(top: 70),
                  padding: EdgeInsets.all(25.0),
                  // Border to visualize the container
                 // decoration: BoxDecoration(
                 //   border: Border.all(),
                 //   borderRadius: BorderRadius.circular(10),
                    
                //  ),
                 ), 
          ),
        
         ],
          )
    );
  }
}

  

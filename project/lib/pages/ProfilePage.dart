import 'package:flutter/material.dart';
import 'package:pim_group/pages/HomePage.dart';
import 'editProfilePage.dart';
//import 'editProfilePage.dart'

class ProfilePage extends StatelessWidget {
  // prime righe tutor?

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        // leading: IconButton(
        //   icon: Icon(
        //     Icons.arrow_back,
        //     color: Colors.green,
        //   ),
        //   //da sistemare la navigation
        //   onPressed: () {//Navigator.of(context).push(MaterialPageRoute(
        //           //builder: (BuildContext context) => HomePage()));
        //     },
        // ), //Non serve se rimane la bottomNavigationBar
        actions: [
          IconButton(
            icon: Icon(
              Icons.edit,
              color: Colors.green,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => EditProfilePage()));
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
          child: ListView(
            children: [
              Text(
                "Edit Profile",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 10))
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                "https://i.pinimg.com/originals/22/91/ba/2291babd9eb9f7a2744b8cc24de1216a.jpg",
                              ))),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              buildTextLabel("Full Name"),
              buildText("No Drama Lama"),
              buildTextLabel("E-mail"),
              buildText("hello@lama.com"),
              buildTextLabel("Password"),
              buildText("*******"),
              buildTextLabel("Withdrawal Date"),
              buildText("24/04/23"),
              buildTextLabel("Altro"),
              buildText("..."),
              SizedBox(
                height: 35,
              ),
              buildText("TO DO:"),
              buildText("- Condivisione dati tra le schermate (profilo, edit, home, ecc);"),
              buildText("- Mettere grafico (vedi app tutoring!);"),
              buildText("- Widget scelta data e ora;"),
              buildText("Problemi di navigazione")
  ])));
  }
}

Widget buildTextLabel(String textLabel){
  return Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child:
        Text(
          textLabel, 
          style: TextStyle(fontSize: 12, color: Colors.black45)
        ),
  );
}

Widget buildText(String textField){
  return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child:
        Text(
          textField, 
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)
        ),
  );
}

// DA TUTOR
// class ProfilePage extends StatelessWidget {
//   ProfilePage({Key? key}) : super(key: key);

//   static const route = 'user';
//   static const routename = 'UserPage';

//   final _formKey = GlobalKey<FormState>();

//   final TextEditingController ageController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: const Color(0xFFE4DFD4),
//         appBar: AppBar(
//           elevation: 0,
//           backgroundColor: const Color(0xFFE4DFD4),
//           iconTheme: const IconThemeData(color: Color(0xFF89453C)),
//           title:
//               const Text('Information', style: TextStyle(color: Colors.black)),
//         ),
//         body: SingleChildScrollView(
//             child: Column(
//           children: [
//             Center(
//                 child: CircleAvatar(
//                     radius: 70, child: Image.asset('assets/images/avatar.png'))),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     const SizedBox(height: 10),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: <Widget>[
//                         const SizedBox(width: 10),
//                         const Text('Gender',
//                             style: TextStyle(
//                                 color: Color(0xFF89453C), fontSize: 17)),
//                         Radio(
//                           fillColor: MaterialStateColor.resolveWith(
//                               (states) => const Color(0xFF89453C)),
//                           value: 1,
//                           groupValue: 1,
//                           onChanged: (val) {},
//                         ),
//                         const Text(
//                           'MALE',
//                           style: TextStyle(fontSize: 17.0),
//                         ),
//                         Radio(
//                             fillColor: MaterialStateColor.resolveWith(
//                                 (states) => const Color(0xFF89453C)),
//                             value: 2,
//                             groupValue: 1,
//                             onChanged: (val) {}),
//                         const Text(
//                           'FEMALE',
//                           style: TextStyle(
//                             fontSize: 17.0,
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 20),
//                     SizedBox(
//                       width: 400,
//                       child: TextFormField(
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter your age';
//                             } else if (int.tryParse(value) == null) {
//                               return 'Please enter an integer valid number';
//                             }
//                             return null;
//                           },
//                           controller: ageController,
//                           enabled: true,
//                           decoration: const InputDecoration(
//                               border: OutlineInputBorder(),
//                               focusedBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                       width: 1, color: Color(0xFF89453C))),
//                               labelText: 'Age',
//                               labelStyle: TextStyle(color: Color(0xFF89453C)))),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         ElevatedButton(
//                             onPressed: () async {
//                               if (_formKey.currentState!.validate()) {}
//                             },
//                             style: ElevatedButton.styleFrom(
//                                 backgroundColor: const Color(0xFF83AA99),
//                                 shape: const CircleBorder()),
//                             child: const Icon(Icons.check)),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         )));
//   } //build
// } //Page
  // vacchio codice
  // @override
  // Widget build(BuildContext context) {
  //   return  Scaffold(
  //     appBar: AppBar(title: const Text('Profile')),
  //     body: Center(
  //       child: Text('Profile page')
        
  //     )
  //   );
  // }

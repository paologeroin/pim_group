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
        backgroundColor: Color.fromARGB(255, 97, 198, 171),
        elevation: 1,
        actions: [
          IconButton(
            icon: Icon(
              Icons.edit,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            onPressed: () async {
              final result = await Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => EditProfilePage()));
              ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text('$result')));
            },
          ),
        ],
        centerTitle: true,
        title: 
          const Text(
            "Your Profile",
            style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
          child: ListView(
            children: [
              Text(
                "User Name",
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
              buildText("Dama Lama"),
              buildTextLabel("E-mail"),
              buildText("hello@lama.com"),
              buildTextLabel("Withdrawal Date"),
              buildText("24/04/23"),
              SizedBox(
                height: 35,
              ),
              buildText("TO DO:"),
              buildText("- Condivisione dati tra le schermate (profilo, edit, home, ecc);"),
              buildText("- Widget scelta data e ora;"),
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

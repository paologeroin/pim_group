import 'package:flutter/material.dart';
import 'package:pim_group/utils/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'root.dart';

// Inizializzo la classe LoginPage
class LoginPage extends StatefulWidget {
  static const routeDisplayName = 'LoginPage';

  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => LoginPageState();
}

// inizializzo la classe dello stato della pagina LoginPage
class LoginPageState extends State<LoginPage> {
  final TextEditingController controllerOfUser =
      TextEditingController(); // controllore per controllare inserimento nome utente
  final TextEditingController controllerOfPassword =
      TextEditingController(); // controllore per controllare inserimento pw
  final _formKey = GlobalKey<FormState>();
  static bool _passwordVisible =
      false; // diventa true quando l'user preme pulsante per renderla visibile
  // metodo per far mostrare password
  void _showPassword() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  // inizio a costruire il Widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE4DFD4),
      //appBar
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 109, 230, 69),
        centerTitle: true,
        title: const Text('SoberMan',
            style: TextStyle(
                color: Color.fromARGB(255, 222, 222, 12), fontSize: 32)),
      ),
      // body della pagina, dovremo andremo ad inserire username and password
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const Text(LoginPage.routeDisplayName,
                  style: TextStyle(
                    color: Color.fromARGB(255, 109, 230, 69),
                    fontSize: 32,
                  )),
              const Text('Login to the Soberman app',
                  style: TextStyle(
                    fontSize: 20,
                  )),
              const SizedBox(
                height: 18,
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text('Username', style: TextStyle(fontSize: 20)),
              ),
              const SizedBox(
                height: 6,
              ),
              TextFormField(
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Insert your username';
                  } else if (value != 'username') {
                    return 'Wrong username';
                  }
                  return null;
                },
                controller:
                    controllerOfUser, // controlla che l'username inserito rispetti le 'richieste'
                cursorColor: Color.fromARGB(255, 169, 194, 27),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 109, 230, 69),
                    ),
                  ),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  prefixIcon: const Icon(
                    Icons.person_3,
                    color: Color.fromARGB(255, 109, 230, 69),
                  ),
                  hintText: 'Username',
                  hintStyle: const TextStyle(
                    color: Color.fromARGB(255, 109, 230, 69),
                  ),
                ),
              ),
              const SizedBox(
                height: 17,
              ),
              // ora trattiamo la password
              const Align(
                alignment: Alignment.topLeft,
                child: Text('Password',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Insert your password';
                  } else if (value != '1234!') {
                    return 'Wrong password';
                  }
                  return null;
                },
                controller:
                    controllerOfPassword, // controlla che la password sia ok con le nostre richieste
                cursorColor: const Color(0xFF83AA99),
                obscureText:
                    !_passwordVisible, // per rendere visibile o meno la password
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 109, 230, 69),
                    ),
                  ),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: Color.fromARGB(255, 109, 230, 69),
                  ),
                  suffixIcon: IconButton(
                    // come quello dei prof, se cambio la selezione cambia anche l'icona della password
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      // richiama il metodo implementato all'inizio per aggiornare lo stato della password
                      _showPassword();
                    },
                  ),
                  hintText: 'Password',
                  hintStyle:
                      const TextStyle(color: Color.fromARGB(255, 109, 230, 69)),
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // se premo il bottone per validare le credenziali inserite
                      if (_formKey.currentState!.validate()) {
                        var prefs = Provider.of<Preferences>(context,
                            listen:
                                false); // provider per gestire le credenziali con le shared_preferences
                        prefs.username = controllerOfUser.text;
                        prefs.password = controllerOfPassword.text;
                        Navigator.pushReplacement(
                            // se è tutto okay mi manda alla home
                            context,
                            MaterialPageRoute(
                                builder: (context) => BottomNavBarV2()));
                      }
                    },
                    child: const Text(
                      'Log In to SoberMan',
                      style: TextStyle(
                        color: Color.fromARGB(255, 222, 222, 12),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

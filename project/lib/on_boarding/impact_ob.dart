import 'package:flutter/material.dart';
import 'package:pim_group/pages/root.dart';
import 'package:pim_group/services/impact.dart';
import 'package:provider/provider.dart';

class ImpactOnboarding extends StatefulWidget {
  // inizializzo la classe ImpactOnboarding
  static const routeDisplayName = 'ImpactOnboardingPage';

  ImpactOnboarding({Key? key}) : super(key: key);

  @override
  State<ImpactOnboarding> createState() => _ImpactOnboardingState();
}

class _ImpactOnboardingState extends State<ImpactOnboarding> {
  // inizializzo la classe ImpactOnboardingState

  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  static bool _passwordVisible = false; // per far vedere la password o meno

  void _showPassword() {
    // come spiegato nel login
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  Future<bool> _loginImpact(
      // metodo per eseguire il login
      String name,
      String password,
      BuildContext context) async {
    ImpactService service = Provider.of<ImpactService>(context, listen: false);
    bool logged = await service.getTokens(name, password);
    return logged; // ritorna i tokens
  }

  @override // costruiamo la pagina in modo molto simile alla loginpage
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 222, 212, 12),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              /*Image.asset(
                 'assets/impact_logo.png'),*/ // prende il logo di impact da internet, io lo cambierei
              const Text(
                  'We need your authorization to connect to your fitbit', // PER ACCEDERE AI TOKEN serve che l'utente acceda a impact
                  style: TextStyle(
                    fontSize: 14,
                  )),
              const SizedBox(
                height: 20,
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text('Username',
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    // appare scritta se utente non scrive nulla
                    return 'Insert your username';
                  }
                  return null;
                },
                controller:
                    userController, // solito controllore per l'inserimento, si vuole che l'inserimento rispetti le nostre richieste
                cursorColor: Color.fromARGB(255, 222, 212, 12),
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
                    Icons.person,
                    color: Color.fromARGB(255, 109, 230, 69),
                  ),
                  hintText: 'Username',
                  hintStyle:
                      const TextStyle(color: Color.fromARGB(255, 109, 230, 69)),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Align(
                alignment: Alignment.topLeft,
                // uguale a Username per la password
                child: Text('Password',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(
                height: 7,
              ),
              TextFormField(
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    // ritorna scritta se non ci sono inserimenti
                    return 'Insert your password';
                  }
                  return null;
                },
                controller:
                    passwordController, // solito controllore per l'inserimento, si vuole che l'inserimento rispetti le nostre richieste
                cursorColor: Color.fromARGB(255, 222, 212, 12),
                obscureText: !_passwordVisible,
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
                    icon: Icon(
                      // icona che ci permette di rendere la password visibile
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Color.fromARGB(255, 222, 212, 12),
                    ),
                    onPressed: () {
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
                  // qui abbiamo il tasto per validare la connessione all'impact
                  padding: const EdgeInsets.all(12.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      bool? validation = await _loginImpact(
                          userController.text,
                          passwordController.text,
                          context); // userController.text, passwordController.text sono i nostri inserimenti
                      if (!validation) {
                        // se non è riuscito il login a impact appare il messaggio che le credenziali sono sbagliate
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          backgroundColor: Color.fromARGB(255, 120, 10, 3),
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.all(8),
                          content: Text(
                              'Your credentials are wrong, please try again'),
                          duration: Duration(seconds: 3),
                        ));
                      } else {
                        // se è andato a buon fine ci riporta nella homepage, perchè la connessione è avvenuta e abbiamo ottenuto i token per i dati
                        Future.delayed(
                            const Duration(milliseconds: 300),
                            () => Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => BottomNavBarV2())));
                      }
                    },
                    style: ButtonStyle(
                        // bottone
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                        elevation: MaterialStateProperty.all(0),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            const EdgeInsets.symmetric(
                                horizontal: 80, vertical: 12)),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 109, 230, 69))),
                    child: const Text('Push to authorize the connection'),
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

import 'package:flutter/material.dart';
import 'package:pim_group/pages/root.dart';
import 'package:pim_group/services/impact.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/shared_preferences.dart';


class ImpactOnboarding extends StatefulWidget {
  // class ImpactOnboarding
  static const routeDisplayName = 'ImpactOnboardingPage';

  ImpactOnboarding({Key? key}) : super(key: key);

  @override
  State<ImpactOnboarding> createState() => _ImpactOnboardingState();
}

class _ImpactOnboardingState extends State<ImpactOnboarding> {
  // class ImpactOnboardingState

  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  static bool _passwordVisible = false; 

  void _showPassword() {

    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  Future<bool> _loginImpact(

      String username,
      String password,
      BuildContext context) async {
    ImpactService service = Provider.of<ImpactService>(context, listen: false);
    bool logged = await service.authorize(username, password);
    return logged; 
  }

  void _toDownloadPage(BuildContext context) {
    var prefs = Provider.of<Preferences>(context,
        listen: false); // SharedPreferences
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: ((context) => ImpactService(prefs))));
  } //_toDownloadPage


  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
               Padding(
             padding: EdgeInsets.only(top:0), child: Image.asset(
                 'assets/images/impact.png',
                 height: 190,
                 width: 250)),
                 
              
              Padding(
  padding: EdgeInsets.only(top:0, left:45,right:45, bottom:0), child: Text(
                  'We need your authorization to connect to your fitbit',textAlign: TextAlign.center,
                  style: GoogleFonts.lato( 
                 
                    fontSize: 20,
                  ))),
              const SizedBox(
                height: 20,
              ),
               Align(
                alignment: Alignment.topLeft,
                child: Text('Username',
                    style:
                        GoogleFonts.lato(fontSize: 22, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                 
                    return 'Insert your username';
                  }
                  return null;
                },
                controller:
                    userController, 
                cursorColor: Color.fromARGB(255, 255, 255, 255),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 142, 76, 255),
                    ),
                  ),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Color.fromARGB(255, 142, 76, 255),
                  ),
                  hintText: 'Username',
                  hintStyle:
                      const TextStyle(color:Color.fromARGB(255, 118, 118, 119)),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
               Align(
                alignment: Alignment.topLeft,
       
                child: Text('Password',
                    style:
                        GoogleFonts.lato(fontSize: 22, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(
                height: 7,
              ),
              TextFormField(
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                  
                    return 'Insert your password';
                  }
                  return null;
                },
                controller:
                    passwordController, // solito controllore per l'inserimento, si vuole che l'inserimento rispetti le nostre richieste
                cursorColor: Color.fromARGB(255, 142, 76, 255),
                obscureText: !_passwordVisible,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 142, 76, 255),
                    ),
                  ),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: Color.fromARGB(255, 142, 76, 255),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      // icona che ci permette di rendere la password visibile
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Color.fromARGB(255, 125, 125, 125),
                    ),
                    onPressed: () {
                      _showPassword();
                    },
                  ),
                  hintText: 'Password',
                  hintStyle:
                       TextStyle(color: Color.fromARGB(255, 118, 118, 119), ),
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomCenter,
               // child: Padding(
                  // qui abbiamo il tasto per validare la connessione all'impact
                 // padding:  EdgeInsets.only(top: 0, bottom: 70.0, left: 40, right:40),
                  child: ElevatedButton(
                    onPressed: () async {
                      bool? validation = await _loginImpact(
                          userController.text,
                          passwordController.text,
                          context); // userController.text, passwordController.text sono i nostri inserimenti
                      if (!validation) {
                       
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
                        
                      
                        Future.delayed(
                            const Duration(milliseconds: 300),
                            () => _toDownloadPage(context));
                      }
                    },
                    style: ButtonStyle(
             
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35))),
                        elevation: MaterialStateProperty.all(4),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 12)),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 142, 76, 255))),
                    child:  Text('Push to authorize the connection', textAlign: TextAlign.center, style: GoogleFonts.lato(fontSize: 19),)
                  ),
                ),
              
            ],
          ),
        ),
      ),
    );
  }
}

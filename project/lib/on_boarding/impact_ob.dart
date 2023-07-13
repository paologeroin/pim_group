import 'package:flutter/material.dart';
import 'package:pim_group/services/impact.dart';
import 'package:provider/provider.dart';

import '../utils/shared_preferences.dart';

class ImpactOnboarding extends StatefulWidget {
  static const routeDisplayName = 'ImpactOnboardingPage';

  ImpactOnboarding({Key? key}) : super(key: key);

  @override
  State<ImpactOnboarding> createState() => _ImpactOnboardingState();
}

class _ImpactOnboardingState extends State<ImpactOnboarding> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  static bool _passwordVisible = false;

  // method used to show the password to the user
  void _showPassword() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  // Method used to login to the Impact Server
  Future<bool> _loginImpact(
      String username, String password, BuildContext context) async {
    ImpactService service = Provider.of<ImpactService>(context, listen: false);
    bool logged = await service.authorize(username, password);
    return logged;
  }

  // Method used to go to the ImpactServicePage
  void _toDownloadPage(BuildContext context) {
    var prefs = Provider.of<Preferences>(context, listen: false);
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: ((context) => ImpactService(prefs))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 222, 212, 12),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const Text('We need your authorization to connect to your fitbit',
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
                    return 'Insert your username';
                  }
                  return null;
                },
                controller: userController,
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
                    return 'Insert your password';
                  }
                  return null;
                },
                controller: passwordController,
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
                  padding: const EdgeInsets.all(12.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      bool? validation = await _loginImpact(userController.text,
                          passwordController.text, context);
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
                        Future.delayed(const Duration(milliseconds: 300),
                            () => _toDownloadPage(context));
                      }
                    },
                    style: ButtonStyle(
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

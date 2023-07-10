import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:pim_group/pages/jump.dart';
import 'package:pim_group/services/impact.dart';
import 'root.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  static const routename = 'LoginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    //Check if the user is already logged in before rendering the login page
    _checkLogin();
  } //initState

  void _checkLogin() async {
    //Get the SharedPreference instance and check if the value of the 'username' filed is set or not
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('email') != null) {
      //If 'username is set, push the HomePage
      _toHomePage(context);
    } //if
  } //_checkLogin

  Future<String> _loginUser(LoginData data) async {
    if (data.name == 'paolo@cappon.com' && data.password == 'mariairene') {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('email', data.name);
      prefs.setString('password_user', data.password);

      return '';
    } else {
      return 'Wrong credentials, try again';
    }
  }

  // _loginUser
  Future<String> _signUpUser(SignupData data) async {
    return 'To be implemented';
  }

  // _signUpUser
  Future<String> _recoverPassword(String email) async {
    return 'Recover password functionality needs to be implemented';
  } // _recoverPassword

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'Welcome to DrinkBreak',
      onLogin: _loginUser,
      onSignup: _signUpUser,
      onRecoverPassword: _recoverPassword,
      onSubmitAnimationCompleted: () async {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => Jump()));
      },
    );
  } // build

  void _toHomePage(BuildContext context) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Jump()));
    // qui teniamo la Jump page (da modificare perché h
    // ancora i metodi vecchi) che nel caso non ci sono i token
    // manda al login dell'impact, altrimenti (quindi ci sono i
    // token ma deve solo fare il refresh) manda a root che
    // manda a HomePage
  } //_toHomePage
} // LoginScreen
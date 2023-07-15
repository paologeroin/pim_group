import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:pim_group/pages/jump.dart';
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
    _checkLogin();
  } //initState

  // Method used to check the login to the App
  void _checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('email') != null) {
      _toJump(context);
    }
  } //_checkLogin

  // Method used to try the login with the User's credentials to the App
  Future<String> _loginUser(LoginData data) async {
    if (data.name == 'user@gmail.com' && data.password == '12345') {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('email', data.name);
      prefs.setString('password_user', data.password);

      return '';
    } else {
      return 'Wrong credentials, try again';
    }
  }

  // Method for future implementation
  Future<String> _signUpUser(SignupData data) async {
    return 'To be implemented';
  } // _signUpUser

  // Method for future implementation
  Future<String> _recoverPassword(String email) async {
    return 'Recover password functionality needs to be implemented';
  } // _recoverPassword

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'WineNot? Login',
      onLogin: _loginUser,
      onSignup: _signUpUser,
      onRecoverPassword: _recoverPassword,
      onSubmitAnimationCompleted: () async {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => Jump()));
      },
    );
  } // build

  void _toJump(BuildContext context) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Jump()));
  } //_toJump
} // LoginScreen
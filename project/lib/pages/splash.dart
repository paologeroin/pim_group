import 'package:flutter/material.dart';
import 'package:pim_group/on_boarding/impact_ob.dart';
import 'package:pim_group/pages/LoginPage.dart';
import 'package:pim_group/pages/root.dart';
import 'package:pim_group/services/impact.dart';
import 'package:pim_group/utils/shared_preferences.dart';
import 'package:provider/provider.dart';

class Splash extends StatelessWidget {
  static const route = '/splash/';
  static const routeDisplayName = 'SplashPage';

  const Splash({Key? key}) : super(key: key);

  // Method for navigation SplashPage -> LoginPage
  void _toLoginPage(BuildContext context) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: ((context) => LoginPage())));
  } //_toLoginPage

  // Method for navigation SplashPage -> HomePage (ROOT)
  void _toHomePage(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: ((context) => BottomNavBarV2()))); // dovrebbe essere la root
  } //_toHomePage

  // Method for navigation SplashPage -> Impact
  void _toImpactPage(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: ((context) =>
            ImpactOnboarding()))); // dovrebbe essere l'impact di Onboarding per chiedere i token
  }

/*
  // Method for navigation SplashPage -> PurpleAirPage
  void _toPurpleAirPage(BuildContext context) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: ((context) => PurpleAirOnboarding())));
  }
*/
  void _checkAuth(BuildContext context) async {
    var prefs = Provider.of<Preferences>(context, listen: false);
    String? username = prefs.username;
    String? password = prefs.password;

    // no user logged in the app
    if (username == null || password == null) {
      Future.delayed(const Duration(seconds: 1), () => _toLoginPage(context));
    } else {
      ImpactService service =
          Provider.of<ImpactService>(context, listen: false);
      bool responseAccessToken = service.checkSavedToken();
      bool refreshAccessToken = service.checkSavedToken(refresh: true);

      // if we have a valid token for impact, proceed
      if (responseAccessToken || refreshAccessToken) {
        // DA TOGLIERE PERCHE NOI NON ABBIAMO DA ACCEDERE ONLINE ALLA POLLUTION
        // check if we have saved an api key for purpleair
        // if (prefs.purpleAirXApiKey != null) {
        Future.delayed(const Duration(seconds: 1), () => _toHomePage(context));
        // } else {
        //   Future.delayed(const Duration(seconds: 1), () => _toPurpleAirPage(context));
        // }
        // DA TOGLIERE PERCHE NOI NON ABBIAMO DA ACCEDERE ONLINE ALLA POLLUTION
      } else {
        Future.delayed(
            const Duration(seconds: 1), () => _toImpactPage(context));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 5), () => _toLoginPage(context));
    Future.delayed(const Duration(seconds: 1), () => _checkAuth(context));
    return Material(
      child: Container(
        color: const Color(0xFF83AA99),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const <Widget>[
            Text(
              'DrinkBreak',
              style: TextStyle(
                  color: Color(0xFFE4DFD4),
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
            Center(
              child: CircularProgressIndicator(
                strokeWidth: 4,
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF89453C)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

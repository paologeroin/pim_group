import 'package:flutter/material.dart';
import 'package:pim_group/on_boarding/impact_ob.dart';
import 'package:pim_group/services/impact.dart';
import 'package:pim_group/utils/shared_preferences.dart';
import 'package:provider/provider.dart';

// the class jump is used to manage the access to the App and to the Impact
class Jump extends StatelessWidget {
  static const routeDisplayName = 'JumpPage';

  const Jump({Key? key}) : super(key: key);

  // Method used to go to the root (Homepage)
  void _toDownloadPage(BuildContext context) {
    var prefs = Provider.of<Preferences>(context, listen: false);
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: ((context) => ImpactService(prefs))));
  }

  // Method used to go to the ImpactOnBoarding
  void _toImpactPage(BuildContext context) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: ((context) => ImpactOnboarding())));
  }

  // Method used to check the Credendials for the access to the ImpactPage
  void checkAuthentication(BuildContext context) async {
    var prefs = Provider.of<Preferences>(context, listen: false);
    String? username = prefs.username;
    String? password = prefs.password;
    ImpactService service = Provider.of<ImpactService>(context, listen: false);
    bool responseAccessToken = service.checkSavedToken();
    bool refreshAccessToken = service.checkSavedToken(refresh: true);

    if (responseAccessToken || refreshAccessToken) {
      print(
          'Token taken'); // control to inform the programmer that the app download the token
      print(responseAccessToken);
      print(refreshAccessToken);
      Future.delayed(
          const Duration(seconds: 1), () => _toDownloadPage(context));
    } else {
      Future.delayed(const Duration(seconds: 1), () => _toImpactPage(context));
    }
  } // checkAuthentication

  @override
  Widget build(BuildContext context) {
    Future.delayed(
        const Duration(seconds: 2), () => checkAuthentication(context));
    return Material(
      child: Container(
        color: const Color(0xFF83AA99),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const <Widget>[
            Text(
              'SoberMan',
              style: TextStyle(
                  color: Color.fromARGB(255, 197, 141, 20),
                  fontSize: 48,
                  fontWeight: FontWeight.bold),
            ),
            Center(
              child: CircularProgressIndicator(
                strokeWidth: 6,
                valueColor: AlwaysStoppedAnimation<Color>(
                    Color.fromARGB(255, 102, 208, 14)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

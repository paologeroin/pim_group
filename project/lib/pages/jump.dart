import 'package:flutter/material.dart';
import 'package:pim_group/on_boarding/impact_ob.dart';
import 'package:pim_group/pages/HomePage.dart';
import 'package:pim_group/pages/LoginPage.dart';
import 'package:pim_group/pages/root.dart';
import 'package:pim_group/services/impact.dart';
import 'package:pim_group/services/sleepData.dart';
import 'package:pim_group/utils/shared_preferences.dart';
import 'package:provider/provider.dart';

// E' OKAY

// inizializzo la classe Jump (come Splash per i professori) per gestire il fatto di aver già o meno inserito
// le credenziali nell'app e nell'impact per il download dei dati
class Jump extends StatelessWidget {
  static const routeDisplayName = 'JumpPage';

  const Jump({Key? key}) : super(key: key);

  // Metodo per andare dalla JumpPage al nostro root.dart che manderà a sua volta alla Homepage
  void _toDownloadPage(BuildContext context) {
    var prefs = Provider.of<Preferences>(context,
        listen: false); // per usare le SharedPreferences
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: ((context) => ImpactService(prefs))));
  } //_toDownloadPage

  // Metodo per andare alla ImpactPage per scaricare i token
  void _toImpactPage(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: ((context) => ImpactOnboarding()))); // ImpactOnboarding
  }

  // metodo per controllare che sia stata eseguita la autenticazione
  // prima si fa il controllo per la LoginPage e poi per la ImpactPage
  void checkAuthentication(BuildContext context) async {
    var prefs = Provider.of<Preferences>(context,
        listen: false); // per usare le SharedPreferences
    String? username = prefs.username;
    String? password = prefs.password;
    ImpactService service = Provider.of<ImpactService>(context, listen: false);
    bool responseAccessToken = service.checkSavedToken();
    bool refreshAccessToken = service.checkSavedToken(refresh: true);

    // controlliamo se abbiamo dei token validi
    if (responseAccessToken || refreshAccessToken) {
      // se ok mando diretto alla HomePage
      print('ho i token fdp'); // cava prima della consegna ai prof
      print(responseAccessToken);
      print(refreshAccessToken);
      Future.delayed(const Duration(seconds: 1), () => _toDownloadPage(context));
    } else {
      // altrimenti se entro in questo else vuol dire che devo fare accesso alla ImpactPage
      Future.delayed(const Duration(seconds: 1), () => _toImpactPage(context));
    }
    }


  @override
  Widget build(BuildContext context) {
    /* Future.delayed(const Duration(seconds: 2), () => _toLoginPage(context)); */
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

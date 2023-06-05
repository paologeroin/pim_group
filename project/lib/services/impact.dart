import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:dio/dio.dart';
import 'package:pim_group/models/entities_sleep/entities_sleep.dart';
import 'package:pim_group/utils/shared_preferences.dart';
import 'package:pim_group/utils/server_strings.dart';

// Impact è okay

// creo la classe ImpactService
class ImpactService {
  ImpactService(this.prefs);
  Preferences prefs; // inizializzo Preferences

  final Dio _dio = Dio(
      BaseOptions(baseUrl: ServerStrings.backendBaseUrl)); // inizializzo Dio
  // A powerful HTTP client for Dart/Flutter, which supports global configuration,
  // interceptors, FormData, request cancellation, file uploading/downloading, timeout, and custom adapters etc

  // per recuperare i Token, inizializzo come String perchè dovrà restituire il token
  String? retrieveSavedToken(bool refresh) {
    if (refresh) {
      // se refresh = true allora vuol dire che bisogna refreshare
      // i token, perchè access Token è scaduto e quindi ritorna il token di refresh (che è salvato nelle shared Preferences)
      return prefs.impactRefreshToken;
    } else {
      // altrimenti l'access token è valido e ritorna l'access token stesso (che è salvato nelle shared Preferences)
      return prefs.impactAccessToken;
    }
  }

  // per controllare il tok
  bool checkSavedToken({bool refresh = false}) {
    // inizializzo refresh come false
    // perchè all'inizio si controlla se abbiamo i token. Se vediamo che token == null,
    // allora devo refresharli perche non li ho, e quindi ritorna false
    String? token = retrieveSavedToken(refresh);
    // Controllo se ho i token
    if (token == null) {
      return false; // ritorna false perchè non ho i token
    }
    try {
      // controllo se i token sono validi
      return ImpactService.checkToken(token);
    } catch (_) {
      // se non sono validi, ritorno false
      return false;
    }
    //n the try-catch statement, you place the code that may cause an exception in the try block.
    // If an exception occurs, the program jumps to the catch block immediately and skips the remaining code in the try block.
  }

  // Metodo che effettivamente controlla i token, se sono scaduti o no.
  // Si usa un metodo statico perchè potremmo voler controllare i token fuori dalla classe stessa
  static bool checkToken(String token) {
    //Check if the token is expired
    if (JwtDecoder.isExpired(token)) {
      // controllo se il token è scaduto, se è scaduto allora qua è true e si entra nell'if
      return false; // si ritorna false
    }
    // altrimenti si va avanti e si controlla se il ruolo connesso al token è patient
    Map<String, dynamic> decodedToken = JwtDecoder.decode(
        token); // decoded token è la componente decode del token
    // questa parte di token contiene che ruolo ha l'user che accede con questo token (patient è quello che serve a noi)

    // Controllo che l'user sia un patient
    if (decodedToken['role'] == null) {
      // ritorno false role del token è null --> dovrebbe essere null se non ho il token, non sono sicuro però
      return false; // ritorno false, perchè non va bene, il ruolo deve essere patient, non null
    } else {
      // altrimenti se role è != da null entro in questo else e controllo se l'user è effettivamente un patient
      if (decodedToken['role'] != ServerStrings.patientRoleIdentifier) {
        // qua è true se l'user non è un patient
        return false; // se l'user non è un patient ritorno false
      } //else
    } //if-else

    return true; // quindi se il token è valido e se l'user è effettivamente un patient ritorno true
  } //checkToken

  // Eseguo la chiamata per ottenere i token
  Future<bool> getTokens(String username, String password) async {
    // inizializzo username e password
    try {
      // QUA INSERISCI cose della TOKENPAGE  PER ACCEDERE AI TOKEN SE VEDI CHE PROPRIO NON VA, perche è qua che fa la chiamata
      // provo a fare la chiamata
      Response response = await _dio.post(
          '${ServerStrings.authServerUrl}token/',
          data: {
            'username': username,
            'password': password
          }, // inizializzo username e password
          options: Options(
              contentType: 'application/json',
              followRedirects: false,
              validateStatus: (status) => true,
              headers: {"Accept": "application/json"}));

      if (ImpactService.checkToken(response.data[
              'access']) && // se entrambi i token di accesso & refresh sono okay entro nell'if, qui nella funzione checkToken ho controllato anche il ruolo del patient connesso al
          ImpactService.checkToken(response.data['refresh'])) {
        // se entrambi i token di accesso & refresh sono okay entro nell'if, qui nella funzione checkToken
        // controllo anche il ruolo del patient connesso ai token
        prefs.impactRefreshToken = response.data[
            'refresh']; // salvo il refresh token nelle shared preferences perchè è ok
        prefs.impactAccessToken = response.data[
            'access']; // salvo l'access token nelle shared preferences perchè è ok
        return true; // ritorno true vuol dire che è okay
      } else {
        return false; // vuol dire che uno dei due token non è okay (probabilmente l'access token)
      }
    } catch (e) {
      // entro in catch se non ha funzionato qualcosa nella chiamata all'impact
      print(e); // stampo 'e' e ritorno false, qualcosa non è andato
      return false;
    }
  }

  Future<bool> refreshTokens() async {
    String? refToken = await retrieveSavedToken(true);
    try {
      Response response = await _dio.post(
          '${ServerStrings.authServerUrl}refresh/',
          data: {'refresh': refToken},
          options: Options(
              contentType: 'application/json',
              followRedirects: false,
              validateStatus: (status) => true,
              headers: {"Accept": "application/json"}));

      if (ImpactService.checkToken(response.data['access']) &&
          ImpactService.checkToken(response.data['refresh'])) {
        prefs.impactRefreshToken = response.data['refresh'];
        prefs.impactAccessToken = response.data['access'];
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> updateBearer() async {
    if (!await checkSavedToken()) {
      await refreshTokens();
    }
    String? token = await prefs.impactAccessToken;
    if (token != null) {
      _dio.options.headers = {'Authorization': 'Bearer $token'};
    }
  }

Future<List<Sleep>> getDataFromDay(DateTime dateOfSleep) async {
  await updateBearer();
  
  // Calcola startTime ed endTime basandomi sulla data di riferimento
  DateTime startTime = DateTime(dateOfSleep.year, dateOfSleep.month, dateOfSleep.day, 0, 0, 0);
  DateTime endTime = DateTime(dateOfSleep.year, dateOfSleep.month, dateOfSleep.day, 23, 59, 59);
  
  Response r = await _dio.get(
    '/data/v1/sleep/${prefs.username}/daterange/start_date/${DateFormat('y-M-d').format(startTime)}/end_date/${DateFormat('y-M-d').format(endTime)}/'
  );

  // Verifica se la richiesta ha avuto successo
  if (r.statusCode == 200) {
    // Recupera i dati dal corpo della risposta
    List<dynamic> sleepData = r.data['data'];

    // Mappa i dati recuperati in oggetti Sleep
    List<Sleep> sleepList = sleepData.map((data) {
      return Sleep(
        null, // id generato automaticamente dal database
        DateTime.parse(data['dateOfSleep']),
        DateTime.parse(data['startTime']),
        DateTime.parse(data['endTime']),
        data['duration'],
        data['minutesToFallAsleep'],
        data['minutesAsleep'],
        data['minutesAwake'],
        data['efficiency'],
        data['mainSleep'],
        data['levelName'],
      );
    }).toList();

    return sleepList;
  } else {
    // La richiesta non è andata a buon fine, gestisci l'errore di conseguenza
    throw Exception('Failed to retrieve sleep data');
  }
}


// DA SISTEMARE: ma da fare per tutti i dati????
  // Future<List<Sleep>> getDataFromDay(DateTime dateOfSleep) async {
  //   await updateBearer();
  //   Response r = await _dio.get(
  //       '/data/v1/sleep/${prefs.username}/daterange/start_date/${DateFormat('y-M-d').format(startTime)}/end_date/${DateFormat('y-M-d').format(endTime)}/');
  //   List<dynamic> data = r.data['data'];
  //   List<Sleep> sleepData = [];
  //   for (var daydata in data) {
  //     String day = daydata['date'];
  //     for (var dataday in daydata['data']) {
  //       String hour = dataday['time'];
  //       String datetime = '${day}T$hour';
  //       DateTime endTime = _truncateSeconds(DateTime.parse(datetime));
  //       Sleep sleepDataNew = Sleep(null,
  //           dateOfSleep, // dateOfSleep
  //           startTime, // Inserisci un valore appropriato per startTime
  //           endTime, // endTime - Assumendo che endTime sia uguale a timestamp
  //           dataday['value'], // duration
  //           0, // minutesToFallAsleep - Inserisci un valore appropriato
  //           0, // minutesAsleep - Inserisci un valore appropriato
  //           0, // minutesAwake - Inserisci un valore appropriato
  //           0, // efficiency - Inserisci un valore appropriato
  //           false, // mainSleep - Inserisci un valore appropriato
  //           '', // levelName - Inserisci un valore appropriato);
  //       );
  //       if (!sleepData.any((e) => e.dateOfSleep.isAtSameMomentAs(sleepDataNew.dateOfSleep))) {
  //         sleepData.add(sleepDataNew);
  //       }
  //     }
  //   }
  //   var sleepDataList = sleepData.toList()..sort((a, b) => a.dateOfSleep.compareTo(b.dateOfSleep));
  //   return sleepDataList;
  // }

  // DateTime _truncateSeconds(DateTime input) {
  //   return DateTime(
  //       input.year, input.month, input.day, input.hour, input.minute);
  // }

}//ImpactService

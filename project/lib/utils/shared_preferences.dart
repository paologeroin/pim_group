import 'package:shared_preferences/shared_preferences.dart';

// SHARED_PREFERENCES OKAY

// inizializzo la classe preferences
class Preferences {
  // singleton design pattern
  Future<void> init() async {
    _pref = await SharedPreferences
        .getInstance(); // richiamo la getInstance come scritto nella teoria
  }

  late SharedPreferences
      _pref; // si usa late per dire al codice che la variabile verrà inizializzata in seguito

  Future<bool> resetSettings() async {
    // per resettare le shared preferences, utilizzato quando dobbiamo aggiornare i token ad esempio
    return _pref.clear();
  }

  // metodo per gestire i valori di default delle preferenze senza il bisogno di chiamare il metodo getType specifico di SharedPreferences
  dynamic _getFromDisk(String key, {dynamic defaultVal}) {
    // defaultVal è una variabile dinamica, quindi cambia in base a delle certe condizioni (in teoria)
    var value = _pref.get(key); // value prende il valore di key
    if (value == null) {
      // se value == null ritorno il valore di default
      _saveToDisk(key,
          defaultVal); // metodo spiegato in seguito, assegna a key il valore di default value chiamando il nome corretto del metodo
      return defaultVal; // ritorno il valore di default
    } else if (value is List) {
      // se value è una lista e quindi se key era una lista
      var val = _pref.getStringList(key); // si assegna a val il valore di key
      return val; // ritorno la lista di valori presenti in key
    }
    return value; // altrimenti se value non è nullo e non è una lista lo ritorno direttamente
  }

  // metodo per chiamare la tipologia di metodo corretto per il tipo che è content di SharedPreferences, per salvare il valore correttamente
  void _saveToDisk<T>(String key, T content) {
    if (content is String) {
      // se è una stringa
      _pref.setString(key, content);
    }
    if (content is bool) {
      // se è un bool (true o false)
      _pref.setBool(key, content);
    }
    if (content is int) {
      // se è un int
      _pref.setInt(key, content);
    }
    if (content is double) {
      // se è un double
      _pref.setDouble(key, content);
    }
    if (content is List<String>) {
      // se è una stringa
      _pref.setStringList(key, content);
    }
    if (content == null) {
      // se è nullo si rimuove il valore
      _pref.remove(key);
    }
  }

  // Here we define all the keys we will need in the Preferences. We will then access the value with the getter as Preferences.key
  // The getter allows us to forget the specific string used as key in the SharedPreferences and get a list of all saved preferences as variables of the class

  String? get impactRefreshToken =>
      _getFromDisk('impactRT'); // per il refresh token
  set impactRefreshToken(String? newImpactRefreshToken) =>
      _saveToDisk("impactRT", newImpactRefreshToken);

  String? get impactAccessToken =>
      _getFromDisk('impactAccessToken'); // per l'access token
  set impactAccessToken(String? newImpactAccessToken) =>
      _saveToDisk("impactAccessToken", newImpactAccessToken);

  String? get username => _getFromDisk('username'); // per l'username
  set username(String? newusername) => _saveToDisk("username", newusername);

  String? get password => _getFromDisk('password'); // per la password
  set password(String? newpassword) => _saveToDisk("password", newpassword);
}

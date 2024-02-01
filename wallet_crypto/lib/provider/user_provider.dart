import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet_crypto/view/home/home.dart';
part 'user_provider.g.dart';

// Provider rassemblant toute la logique liée à l'utilisateur
@riverpod
class UserControl extends _$UserControl {
  // Token local destiné à l'user connecté
  String token = 'ROMSPKTJMS131308DTMSPT';
  @override
  bool build() => false;

// connection locale pour tester l'état du provider
  void connection(String name, String password, BuildContext context) {
    if (name == "romain" && password == 'roms') {
      state = true;
      _saveToken(token);

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      state = false;
    }
  }

  // Méthode pour sauvegarder le token dans SharedPreferences
  _saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userToken', token);
  }

  // Méthode pour charger le token depuis SharedPreferences
  Future<void> checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('userToken'));
    if (prefs.getString('userToken') == token) {
      state = true;
    } else {
      state = false;
    }
  }

// methode remplacant l'état par false et clear le storage
  Future<void> disconnect(BuildContext context) async {
    state = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => HomePage()));
  }
}

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wallet_crypto/model/crypto.dart';
import 'package:wallet_crypto/model/data.dart';
import 'package:wallet_crypto/service/crypto_service.dart';
import 'package:wallet_crypto/view/crypto/crypto_detail.dart';

part 'crypto_provider.g.dart';

// Provider s'occupant de la logique concernant l'objet Crypto
@riverpod
class CryptoControl extends _$CryptoControl {
  late Future<Data> dataCrypt;
  final client = ApiClient(Dio(BaseOptions(contentType: "application/json")));
  List<Crypto> cryptoss = [];
  int counter = 0;

// Méthode d'initialisation du provider (obligatoire concernant une classe)
  @override
  Future<Data> build() async {
    dataCrypt = client.getCrypto();
    return dataCrypt;
  }

// Algo de tri et renvoi une liste en fonction de la recherche
  Future<void> searchCrypto(String srch) async {
    // premiere utilisation de recherche, rempli ma lsite vide cryptoss par toutes les cryptos pour ensuite pouvoir la renvoyer si la recherche correspond pas
    if (counter == 0 && state.value?.data != null) {
      cryptoss = state.value!.data;
      counter++;
    }
    List<Crypto> filterList = [];
    bool isContain = false;
    state.value?.data.forEach((element) {
      if (element.id.contains(srch.toLowerCase()) ||
          element.symbol.toLowerCase().contains(srch.toLowerCase())) {
        filterList.add(element);
        isContain = true;
      }
    });

    if (isContain) {
      state.value?.data = filterList;
    } else if (srch == '' || srch == ' ' || srch.isEmpty) {
      state.value?.data = cryptoss;
      isContain = false;
    } else {
      state.value?.data = cryptoss;
      isContain = false;
    }
    ;
    // Méthode d'actualisation de l'état avec les nouvelles valeurs
    ref.notifyListeners();
  }

// Navigation vers la page de détail !! toujours passer le contexte en parametre !!
  void goDetail(BuildContext context, Crypto crypto) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => CryptoDetail(crypto: crypto)));
  }
}

import 'package:wallet_crypto/model/crypto.dart';

// Modele de donnée concernant représentant  l'objet json
class Data {
  List<Crypto> data;

  Data({required this.data});

  factory Data.fromJson(Map<String, dynamic> json) {
    final cryptosData = json['data'] as List<dynamic>?;

    if (cryptosData != null) {
      final cryptos =
          cryptosData.map((crypto) => Crypto.fromJson(crypto)).toList();
      return Data(data: cryptos);
    } else {
      return Data(data: []);
    }
  }
}

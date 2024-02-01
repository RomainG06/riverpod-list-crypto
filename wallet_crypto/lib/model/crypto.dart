class Crypto {
  final String id;
  final String symbol;
  final String name;
  final String? supply;
  final String? maxSupply;
  final String volumeUsd24Hr;
  final String priceUsd;
  final String changePercent24Hr;
  final String? vwap24Hr;

  Crypto(
      {required this.id,
      required this.symbol,
      required this.name,
      required this.supply,
      required this.maxSupply,
      required this.volumeUsd24Hr,
      required this.priceUsd,
      required this.changePercent24Hr,
      required this.vwap24Hr});

  factory Crypto.fromJson(Map<String, dynamic> json) {
    return Crypto(
        id: json['id'],
        symbol: json['symbol'],
        name: json['name'],
        supply: json['supply'],
        maxSupply: json['maxSupply'],
        volumeUsd24Hr: json['volumeUsd24Hr'],
        priceUsd: json['priceUsd'],
        changePercent24Hr: json['changePercent24Hr'],
        vwap24Hr: json['vwap24Hr']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'symbol': symbol,
      'name': name,
      'supply': supply,
      'maxSupply': maxSupply,
      'volumeUsd24Hr': volumeUsd24Hr,
      'priceUsd': priceUsd,
      'changePercent24Hr': changePercent24Hr,
      'vwap24Hr': vwap24Hr
    };
  }
}

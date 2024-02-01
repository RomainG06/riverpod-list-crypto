import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallet_crypto/provider/user_provider.dart';

import '../../model/crypto.dart';

class CryptoDetail extends ConsumerWidget {
  const CryptoDetail({super.key, required this.crypto});

  final Crypto crypto;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isConnected = ref.watch(userControlProvider);
    double dollar = double.parse(crypto.priceUsd);
    String roundedUSD = dollar.toStringAsFixed(2);
    double dollar24 = double.parse(crypto.volumeUsd24Hr);
    String roundedDollar24 = dollar24.toStringAsFixed(2);
    double dollarpercentage24 = double.parse(crypto.changePercent24Hr);
    String roundepercentage24 = dollarpercentage24.toStringAsFixed(2);
    if (crypto != null) {
      return Card(
        elevation: 8,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  crypto.symbol,
                  style: const TextStyle(fontSize: 30),
                ),
                Text(crypto.name, style: const TextStyle(fontSize: 25)),
                Text("$roundedUSD USD", style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 40),
                crypto.volumeUsd24Hr != null
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Text(
                              'Volume en dollar dernière 24h:  ',
                            ),
                            Text(
                              roundedDollar24,
                            ),
                          ],
                        ),
                      )
                    : Container(),
                crypto.changePercent24Hr != null
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Text(
                              'Pourcentage variation dernière 24h:  ',
                            ),
                            Text(
                              "$roundepercentage24 %",
                            ),
                          ],
                        ),
                      )
                    : Container(),
                isConnected
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.red),
                                      ),
                                      onPressed: null,
                                      child: const Text("Vendre")),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.green),
                                      ),
                                      onPressed: null,
                                      child: const Text("Acheter")),
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                              onPressed: () => ref
                                  .read(userControlProvider.notifier)
                                  .disconnect(context),
                              child: const Text("Déconnection"))
                        ],
                      )
                    : Container()
              ],
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}

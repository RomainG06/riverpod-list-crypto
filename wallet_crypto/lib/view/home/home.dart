import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallet_crypto/provider/crypto_provider.dart';
import 'package:wallet_crypto/provider/user_provider.dart';
import 'package:wallet_crypto/view/user/user.dart';

class HomePage extends ConsumerWidget {
  HomePage({super.key});
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cryptos = ref.watch(cryptoControlProvider);
    ref.read(userControlProvider.notifier).checkToken();
    final isConnected = ref.watch(userControlProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Center(child: Text("Wallet Crypto")),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.075,
              child: Row(
                children: [
                  isConnected
                      ? const Padding(
                          padding: EdgeInsets.all(20),
                          child: Icon(
                            Icons.verified_user,
                            color: Colors.green,
                          ),
                        )
                      : IconButton(
                          alignment: Alignment.topLeft,
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserPage())),
                          icon:
                              const Icon(Icons.supervised_user_circle_rounded)),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 250,
                          child: TextField(
                              controller: _searchController,
                              decoration: const InputDecoration(
                                  hintText: 'Rechercher une cryptomonnaie',
                                  hintStyle: TextStyle(fontSize: 10))),
                        ),
                        IconButton(
                            onPressed: () => ref
                                .read(cryptoControlProvider.notifier)
                                .searchCrypto(_searchController.text),
                            icon: const Icon(Icons.search))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            cryptos.when(
              data: ((data) {
                if (data.data.isNotEmpty) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.75,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 10,
                        child: Scrollbar(
                          controller: _scrollController,
                          trackVisibility: true,
                          child: ListView.separated(
                            controller: _scrollController,
                            padding: const EdgeInsets.only(
                                top: 10, left: 10, right: 10, bottom: 10),
                            shrinkWrap: true,
                            itemCount: data.data.length,
                            itemBuilder: (context, index) {
                              final crypto = data.data[index];
                              double price = double.parse(crypto.priceUsd);
                              String roundedUSD = price.toStringAsFixed(2);
                              return Card(
                                child: ListTile(
                                  leading: Text(crypto.symbol),
                                  title: Text(
                                    crypto.name,
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  subtitle: Text("$roundedUSD USD"),
                                  onTap: () => ref
                                      .read(cryptoControlProvider.notifier)
                                      .goDetail(context, crypto),
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const SizedBox(height: 16),
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return const Text("Erreur chargement");
                }
              }),
              loading: () =>
                  const Center(child: CircularProgressIndicator.adaptive()),
              error: (Object error, StackTrace stackTrace) {
                return Text(error.toString());
              },
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallet_crypto/provider/user_provider.dart';

class UserPage extends ConsumerWidget {
  UserPage({super.key});

  final TextEditingController inputname = TextEditingController();
  final TextEditingController inputPassword = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(userControlProvider);
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                    controller: inputname,
                    decoration: const InputDecoration(
                        hintText: 'Entrez votre pseudo...',
                        hintStyle: TextStyle(fontSize: 10))),
                TextField(
                    controller: inputPassword,
                    decoration: const InputDecoration(
                        hintText: 'Entrez votre mot de passe...',
                        hintStyle: TextStyle(fontSize: 10))),
                TextButton(
                    onPressed: () => ref
                        .read(userControlProvider.notifier)
                        .connection(
                            inputname.text, inputPassword.text, context),
                    child: const Text("Se connecter"))
              ],
            ),
          )
        ],
      ),
    );
  }
}

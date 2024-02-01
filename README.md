# riverpod-list-crypto

# Application développé avec Flutter avec le gestionnaire d'état Riverpod

Architecture MVVM 

- Riverpod Providers pour la logique 
- Modele
- Service REST avec Retrofit utilisant l'annotation
- View Widgets Stateless ( Consummer widget )
- Stockage SharedPreferences (gestion connexion ) 

## Les Ecrans 

- Liste des cryptos
- Detail crypto
- Formulaire connexion

## Packages utilisés 

  - dio: ^5.4.0
  - retrofit: ^4.0.3
  - retrofit_generator: ^8.0.6
  - flutter_riverpod: ^2.4.9
  - riverpod_annotation: ^2.3.3
  - shared_preferences: ^2.2.2
  - mockito: ^5.4.4

## Details

- Connexion : ID = romain, PSWD = roms
- API : https://api.coincap.io/v2/assets

## Commande a utiliser 

- dart run build_runner watch (génerer les fichiers .g !! ne pas oublier d'utiliser 'part 'nameclass.g.dart';' pour ensuite génerer le fichier !!
- flutter pub get
  

  



 

# Recouvrement Mobile Money CUF - Application Flutter

Application mobile de recouvrement des recettes Mobile Money pour la Commune Urbaine de Fianarantsoa (CUF). Développée avec Flutter, elle met en relation les **Citoyens** (demandeurs d'autorisation d'implantation de kiosques Mobile Money) et les **Agents Communaux** (instruction, recouvrement et contrôle de conformité).

## Contexte du projet

Ce projet s'inscrit dans le cadre de la modernisation du processus de gestion et de recouvrement des taxes relatives aux kiosques Mobile Money sur le territoire de la Commune Urbaine de Fianarantsoa. Il vise à :

- Dématérialiser le circuit de demande d'autorisation d'implantation d'un kiosque Mobile Money
- Garantir la traçabilité des décisions (instruction, approbation, rejet, demande de corrections)
- Assurer le recouvrement des droits d'installation et des taxes annuelles de renouvellement
- Sécuriser le contrôle terrain via scan QR code des kiosques
- Faciliter le suivi des dossiers et l'information des demandeurs

## Architecture technique

L'application adopte une architecture **feature-first** avec **BLoC** (Business Logic Component) pour la gestion d'état :

```text
lib/
├── core/           # Services partagés (localisation FR/MG, DI, sécurité, utils...)
├── data/           # Couche données (modèles Isar, repositories locaux, API XML-RPC)
├── features/       # Fonctionnalités métier (auth, agent, citoyen, shared)
└── main.dart/app.dart
```

### Stack technologique

| Composant | Technologie | Détails |
|---|---|---|
| Framework | [Flutter](https://flutter.dev/) | 3.47.4 (stable) - Dart 3.13.3 |
| Gestion d'état | [flutter_bloc](https://bloclibrary.dev/) | BLoC/Cubit pattern |
| Base de données locale | [Isar DB](https://isar.dev/) | Offline-first (dossiers, notifications, encaissements...) |
| Réseau | [XML-RPC](https://xmlrpc.com/) + [http](https://pub.dev/packages/http) | Communication avec backend CUF |
| Scan QR | [mobile_scanner](https://pub.dev/packages/mobile_scanner) | Caméra + import depuis galerie |
| Génération QR | [qr_flutter](https://pub.dev/packages/qr_flutter) | Export PNG haute résolution |
| Géolocalisation | [geolocator](https://pub.dev/packages/geolocator) | Captation GPS pour implantation & signalement |
| Capture d'images | [image_picker](https://pub.dev/packages/image_picker) + [flutter_image_compress](https://pub.dev/packages/flutter_image_compress) | Photos CIN (recto/verso), photo emplacement |
| Impression thermique | [blue_thermal_printer](https://pub.dev/packages/blue_thermal_printer) | Quittances d'encaissement (fork local) |
| Stockage | [shared_preferences](https://pub.dev/packages/shared_preferences) | Préférences utilisateur (langue, brouillons...) |
| Sécurité | [local_auth](https://pub.dev/packages/local_auth) | Verrouillage biométrique/automatique |
| Connectivité | [connectivity_plus](https://pub.dev/packages/connectivity_plus) | Détection réseau (offline-first) |

## Fonctionnalités principales

### Espace Citoyen
- **Authentification** : Inscription par OTP SMS + création PIN
- **Demande d'autorisation** : Formulaire en 3 étapes (Identité, Caractéristiques du kiosque, Implantation GPS) avec import des photos CIN (caméra/galerie)
- **Suivi de dossier** : État d'instruction (En cours / Approuvé / Rejeté) avec motif en cas de rejet
- **Mes paiements** : Historique des droits d'installation et renouvellements annuels
- **Notifications** : Alertes sur décisions, taxes en retard et **anomalies signalées par l'agent** (persistantes)
- **Téléchargement QR** : Export réel du QR code du kiosque (PNG) vers `Download/CUF/` (Android API 29+) ou local
- **Bilingue** : Interface Français / Malagasy

### Espace Agent Communal
- **Tableau de bord** : Vue synthétique sur les dossiers à instruire, kiosques récents et situation
- **Instruction des dossiers** : Consultation complète du dossier demandeur (identité, CIN recto/verso, infos kiosque, pièces jointes, GPS), approbation / demande de corrections / rejet
- **Scan QR Code** : 
  - Scan en temps réel via caméra
  - **Import depuis galerie** avec décodage automatique (gestion cas sans QR / plusieurs QR / erreur)
- **Fiche kiosque** : Informations détaillées, situation fiscale, encaissement, voisinage, signalement d'anomalie
- **Encaissement** : Perception du droit d'installation ou du renouvellement annuel avec génération de quittance
- **Signalement d'anomalie** : Déclaration terrain (kiosque non déclaré, non-conformité, déplacement) avec géolocalisation → **notification automatique au demandeur**
- **Kiosques redevables** : Liste des kiosques en retard de paiement
- **Profil & session** : Gestion de session agent
- **Bilingue** : Interface Français / Malagasy

### Fonctionnalités transverses
- **Mode offline-first** : Mise en file d'attente (sync queue) pour soumission si réseau indisponible
- **Vérification zone interdite** : Contrôle géographique lors de la demande (si applicable)
- **Verrouillage automatique** : Protection de l'application après inactivité
- **Thématisation CUF** : Charte graphique dédiée
- **Export QR réel** : Vérification d'existence effective du fichier + repli sur copie locale

## Internationalisation (FR/MG)

L'application supporte deux langues : **Français** et **Malgache**.

- Dictionnaire complet dans `lib/core/localization/app_localizations.dart`
- Fallbacks pour Material/Cupertino/Widgets Localizations en malgache
- Persistance de la préférence linguistique (`shared_preferences`)
- Bouton de bascule FR/MG disponible dans l'ensemble des écrans principaux

## Export QR Code - Fonctionnement

L'export du QR code génère un fichier PNG réel et vérifié :

1. Génération de l'image à partir du widget autocollant (pixelRatio 3.0)
2. Sauvegarde locale dans `documents/CUF_QR/` (toujours effectuée)
3. Sur Android :
   - API 29+ : Copie vers `Download/CUF/` via `MediaStore.Downloads` (sans permission WRITE_EXTERNAL_STORAGE)
   - API 26-28 : Écriture directe dans `Download/CUF/` (permission déclarée)
4. **Anti-doublon** : Ajout automatique de `(1)`, `(2)...` si fichier existe déjà
5. **Vérification stricte** : Le chemin retourné ne doit pointer vers aucun fichier inexistant (repli sur copie locale si incohérent)

Implémentation : `lib/core/utils/qr_file_export_io.dart` + `android/app/src/main/kotlin/.../MainActivity.kt` (canal natif `cuf_recouvrement/media`)

## Import QR depuis galerie

L'analyse d'image est isolée dans `lib/features/agent/qr_import.dart` pour faciliter les tests :

- **Aucun QR détecté** → Message explicite « Aucun code QR détecté dans cette image »
- **Plusieurs QR distincts** → Demande à l'utilisateur d'utiliser une image plus précise (on ne devine pas)
- **Plusieurs QR identiques** → Traité comme un succès unique
- **Erreur d'analyse** → Message explicite avec possibilité de réessayer
- Même chaîne de traitement que le scan caméra (`_traiterValeur`)

## Notifications d'anomalie (Agent → Citoyen)

Flux complet :

1. **Agent** signale une anomalie depuis la fiche kiosque (`AnomalieScreen`)
2. Création côté backend avec géolocalisation (ou confirmation explicite si GPS indisponible)
3. **Backend** enregistre l'anomalie + crée une **notification persistante** liée au propriétaire du kiosque
4. **Citoyen** reçoit la notification dans « Mes notifications » (fusionnée avec notifications dérivées dossiers/paiements)
5. État **lu/non lu** persiste (même après redémarrage de l'application)
6. Contenu traduisible (FR/MG) au moment d'affichage

## Tests

L'application dispose d'une suite de tests unitaires et widget :

```bash
flutter test
```

Tests clés :
- `qr_export_test.dart` : Export QR réel (fichier existant requis, repli sur copie locale, anti-doublon)
- `notification_persistence_test.dart` : Anomalie → notification persistante, non-duplication, marquage lu/non-lu
- `notification_lu_non_lu_test.dart` : Persistance lu/non-lu, compteur exact, cloisonnement par téléphone
- `isar_local_store_test.dart` : Stockage local Isar
- `demande_cubit_test.dart` : Logique soumission formulaire (transport vs métier)
- `dossier_agent_validation_test.dart` : Instruction des dossiers
- `service_locator_boot_test.dart` : Amorçage DI

Tous les tests passent actuellement.

## Analyse statique

Vérification du code sans exécuter l'application :

```bash
flutter analyze
```

Résultat : **0 erreur** (uniquement des warnings liés aux fichiers générés Isar et lints des packages locaux).

## Build

### APK Debug
```bash
flutter build apk --debug
```

### APK Release
```bash
flutter build apk --release
```

### AAB (Google Play)
```bash
flutter build appbundle --release
```

## Permissions Android

Déclarées dans `android/app/src/main/AndroidManifest.xml` :

- `CAMERA` - Scan QR & capture photos
- `ACCESS_FINE_LOCATION` / `ACCESS_COARSE_LOCATION` - Géolocalisation
- `INTERNET` / `ACCESS_NETWORK_STATE` - Connectivité
- `WRITE_EXTERNAL_STORAGE` - Export QR sur API ≤ 28 (maxSdkVersion=28)
- `BLUETOOTH` / `BLUETOOTH_ADMIN` / `BLUETOOTH_CONNECT` / `BLUETOOTH_SCAN` - Impression thermique
- `READ_EXTERNAL_STORAGE` / `READ_MEDIA_IMAGES` - Import images galerie

## Configuration

### Backend
Le projet utilise un backend XML-RPC embarqué en mode développement (`EmbeddedBackend`) pour faciliter les tests. Les appels sont routés via `CufBackend`.

### Démonstration
Comptes de démonstration fournis par `EmbeddedBackend` :
- **Agent** : `034 00 000 01` / `1234`
- **Citoyen** : `034 00 000 02` / `1234`

## Structure détaillée des fonctionnalités

| Fonctionnalité | Fichier(s) clé(s) |
|---|---|
| Authentification | `lib/features/auth/` |
| Espace Agent | `lib/features/agent/bloc/agent_cubit.dart`, `lib/features/agent/presentation/` |
| Espace Citoyen | `lib/features/citoyen/bloc/demande_cubit.dart`, `lib/features/citoyen/presentation/` |
| Scan QR (caméra+galerie) | `lib/features/agent/presentation/scanner_screen.dart`, `lib/features/agent/qr_import.dart` |
| Export QR réel | `lib/core/utils/qr_file_export_io.dart`, `android/app/src/main/kotlin/com/cuf/cuf_recouvrement_mobile/MainActivity.kt` |
| Localisation FR/MG | `lib/core/localization/app_localizations.dart` |
| Notifications | `lib/core/service/notification_service.dart`, `lib/data/remote/cuf_backend.dart` |
| Stockage local | `lib/data/local/isar_local_store.dart`, `lib/data/models/*.dart` |

## Notes importantes

- **Pas d'invention de données** : Lorsqu'une donnée n'existe pas dans le backend, l'interface indique explicitement `"NON DISPONIBLE DANS LE BACKEND"`
- **Distinction transport/métier** : En cas de panne réseau, repli offline (mise en file). En cas de refus métier, aucun enregistrement local n'est effectué
- **Idempotence** : Le numéro de dossier provisoire est réintroduit dans le payload rejoué pour éviter la duplication
- **Vérification existence fichier** : L'export QR ne prétend jamais réussir si le fichier n'existe pas physiquement
- **Cohérence bilingue** : Tous les libellés dynamiques s'appuient sur `AppLocalizations.traduire()` pour garantir l'homogénéité FR/MG

## Auteurs & Contexte

Projet réalisé dans le cadre du cursus de **Licence 3 DAII** (Développement d'Applications Informatiques et Intelligentes), sous le thème « Recouvrement Mobile Money CUF - Commune Urbaine de Fianarantsoa ».

## Licence

Ce projet est destiné à un usage académique et institutionnel au sein de la CUF.

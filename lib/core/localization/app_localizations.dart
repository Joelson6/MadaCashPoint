import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/// Localisation bilingue Français / Malagasy (exigence non fonctionnelle,
/// section 9). Dictionnaire clé -> {fr, mg}.
class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale) {
    // Mémorise la dernière locale construite : les Cubits et services (sans
    // BuildContext) traduisent via [traduire] dans la langue active.
    localeCourante = locale;
  }

  static Locale localeCourante = const Locale('fr');

  static const supportedLocales = [Locale('fr'), Locale('mg')];

  static AppLocalizations of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations)!;

  bool get isMg => locale.languageCode == 'mg';

  static const _keys = <String, Map<String, String>>{
    // --- Générique ---
    'app_name': {
      'fr': 'Recouvrement Mobile Money CUF',
      'mg': 'Fanangonana Mobile Money CUF',
    },
    'welcome': {'fr': 'Bienvenue', 'mg': 'Tongasoa'},
    'warning': {'fr': 'Attention', 'mg': 'Tandremo'},
    'ok': {'fr': 'OK', 'mg': 'OK'},
    'cancel': {'fr': 'Annuler', 'mg': 'Hamarino'},
    'confirm': {'fr': 'Confirmer', 'mg': 'Hamarino'},
    'retry': {'fr': 'Réessayer', 'mg': 'Andramo indray'},
    'loading': {'fr': 'Chargement…', 'mg': 'Amplasaina…'},
    'save': {'fr': 'Enregistrer', 'mg': 'Tehirizo'},
    'back': {'fr': 'Retour', 'mg': 'Hiverina'},
    'logout': {'fr': 'Se déconnecter', 'mg': 'Hiala'},
    'synchronize': {'fr': 'Synchroniser', 'mg': 'Synchroniser'},
    'language': {'fr': 'Langue / Fiteny', 'mg': 'Fiteny'},
    'mandatory': {'fr': 'Champ obligatoire', 'mg': 'Tsy maintsy fenoina'},

    // --- Connexion ---
    'login_title': {'fr': 'Connexion', 'mg': 'Fidirana'},
    'phone_label': {'fr': 'Numéro de téléphone', 'mg': 'Laharana finday'},
    'phone_hint': {'fr': 'ex. 034 XX XXX XX', 'mg': 'oh. 034 XX XXX XX'},
    'pin_label': {
      'fr': 'Code PIN (4 ou 6 chiffres)',
      'mg': 'Kaody PIN (4 na 6 isa)',
    },
    'pin_hint': {'fr': '••••', 'mg': '••••'},
    'login_btn': {'fr': 'Se connecter', 'mg': 'Hiditra'},
    'register_link': {
      'fr': 'Créer un compte citoyen',
      'mg': 'Mamorona kaonty olom-pirenena',
    },
    'login_error': {
      'fr': 'Identifiants incorrects',
      'mg': 'Diso ny fampahafantarana',
    },
    'role_demandeur': {'fr': 'Espace Citoyen', 'mg': 'Laharana olom-pirenena'},
    'role_agent': {
      'fr': 'Espace Agent Communal',
      'mg': 'Laharana mpiasan\'ny kaominina',
    },

    // --- Inscription / OTP ---
    'register_title': {
      'fr': 'Création de compte citoyen',
      'mg': 'Famoronana kaonty',
    },
    'otp_sent': {
      'fr': 'Un code de vérification a été envoyé par SMS',
      'mg': 'Nalefana tamin\'ny SMS ny kaody mamarana',
    },
    'otp_label': {
      'fr': 'Code de vérification (SMS)',
      'mg': 'Kaody mamarana (SMS)',
    },
    'otp_btn': {
      'fr': 'Vérifier et créer mon compte',
      'mg': 'Hamarino ary hoforonina ny kaonty',
    },
    'otp_demo': {
      'fr': 'Code démo (mode embarqué) : ',
      'mg': 'Kaody démo (mode embarqué) : ',
    },
    'new_pin_label': {'fr': 'Choisir mon code PIN', 'mg': 'Fidio ny kaody PIN'},
    'fullname_label': {
      'fr': 'Nom et prénoms (selon CIN)',
      'mg': 'Anarana sy fanampiny (araka ny CIN)',
    },

    // --- Accueil Citoyen ---
    'citoyen_home_title': {'fr': 'Mon espace citoyen', 'mg': 'Ny laharanako'},
    'new_demande': {
      'fr': 'Demander une autorisation d\'implantation',
      'mg': 'Mangataha alalana hiorina',
    },
    'track_dossier': {'fr': 'Suivre mon dossier', 'mg': 'Araho ny raharahako'},
    'my_payments': {'fr': 'Mes paiements', 'mg': 'Ny fandoavam-bolako'},
    'grille_tarifaire': {
      'fr': 'Grille tarifaire officielle',
      'mg': 'Fandanana ofisialy',
    },
    'status_card': {
      'fr': 'Statut fiscal du kiosque',
      'mg': 'Sata ara-bola ny kioska',
    },

    // --- Formulaire demande (3 étapes) ---
    'demande_title': {
      'fr': 'Nouvelle demande d\'autorisation',
      'mg': 'Fangatahana alalana vaovao',
    },
    'step1': {'fr': 'Identité du demandeur', 'mg': 'Momba ny mpangataka'},
    'step2': {'fr': 'Spécificités du kiosque', 'mg': 'Momba ny kioska'},
    'step3': {'fr': 'Implantation géographique', 'mg': 'Toerana hipetrahana'},
    'cin_label': {
      'fr': 'N° Carte d\'Identité Nationale (CIN)',
      'mg': 'Laharana CIN',
    },
    'cin_date_label': {'fr': 'Date de délivrance', 'mg': 'Daty namoahana'},
    'cin_lieu_label': {'fr': 'Lieu de délivrance', 'mg': 'Toerana namoahana'},
    'quartier_label': {'fr': 'Quartier de résidence', 'mg': 'Tokantrano'},
    'fokontany_label': {'fr': 'Fokontany', 'mg': 'Fokontany'},
    'commercial_name': {
      'fr': 'Nom commercial du kiosque',
      'mg': 'Anarana ara-barotra ny kioska',
    },
    'operators': {'fr': 'Opérateurs exploités', 'mg': 'Mpanome serivisy'},
    'id_type': {'fr': "Type d'identification", 'mg': 'Karazana fanaraha-maso'},
    'length_label': {'fr': 'Longueur (m)', 'mg': 'Lavany (m)'},
    'width_label': {'fr': 'Largeur (m)', 'mg': 'Sakany (m)'},
    'materials': {
      'fr': 'Matériaux de construction',
      'mg': 'Fitaovana fanorenana',
    },
    'location_hint': {
      'fr': 'Emplacement / repères textuels',
      'mg': 'Toerana / torolalana',
    },
    'capture_gps': {
      'fr': 'Capturer la position GPS',
      'mg': 'Raiso ny toerana GPS',
    },
    'gps_captured': {
      'fr': 'Position GPS enregistrée',
      'mg': 'Voaray ny toerana GPS',
    },
    'gps_error': {
      'fr': 'Impossible de récupérer la position. Activez le GPS.',
      'mg': 'Tsy azo ny toerana. Alefaso ny GPS.',
    },
    'photo_cin_recto': {'fr': 'Photo recto CIN', 'mg': 'Sary CIN (recto)'},
    'photo_cin_verso': {'fr': 'Photo verso CIN', 'mg': 'Sary CIN (verso)'},
    'photo_location': {
      'fr': 'Photo de l\'emplacement',
      'mg': 'Sarin\'ny toerana',
    },
    'take_photo': {'fr': 'Prendre une photo', 'mg': 'Raiso sary'},
    'retake': {'fr': 'Reprendre', 'mg': 'Averinao'},
    'validate': {'fr': 'Valider', 'mg': 'Manamarina'},
    'overlay_recto': {
      'fr': 'Zone photo d\'identité (gabarit recto)',
      'mg': 'Toerana sary fampahalalam-panjonana (recto)',
    },
    'overlay_verso': {
      'fr': 'Zone signatures & adresse (gabarit verso)',
      'mg': 'Toerana fanoratana & adiresy (verso)',
    },
    'overlay_emplacement': {
      'fr': 'Kiosque / terrain dans son environnement',
      'mg': 'Kioska / tany amin\'ny fifandraisany',
    },
    'import_gallery': {
      'fr': 'Importer depuis la galerie',
      'mg': 'Haka sary avy amin\'ny album',
    },
    'photo_delete': {'fr': 'Supprimer la photo', 'mg': 'Fafy ny sary'},
    'photo_tap_hint': {
      'fr': 'Touchez : photo ou galerie',
      'mg': 'Tadiavo : sary na album',
    },
    'photo_removed': {'fr': 'Photo supprimée', 'mg': 'Voafafy ny sary'},
    'photo_too_large': {
      'fr': 'Photo trop volumineuse : impossible de la réduire sous 300 Ko. '
          'Reprenez la photo de plus près.',
      'mg': 'Loatra be ny sary : tsy ahafahana hampiheny ho anelanelana '
          '300 Ko. Averinao atao akaiky kokoa.',
    },
    'next_step': {'fr': 'Suivant', 'mg': 'Manaraka'},
    'prev_step': {'fr': 'Précédent', 'mg': 'Teo aloha'},
    'submit_local_title': {
      'fr': 'Demande enregistrée localement',
      'mg': 'Voatahiry eo an-toerana ny fangatahana',
    },
    'submit_server_title': {'fr': 'Demande soumise', 'mg': 'Nalefa ny fangatahana'},
    'submit_local_body': {
      'fr': 'Votre dossier est conservé sur cet appareil et sera transmis '
          'automatiquement dès le retour du réseau. Ce numéro est provisoire.',
      'mg': 'Tehirizina eo amin\'io milina io ny raharahanao ary halefa '
          'inao raha miverina ny netwaka. Laharana vaovao io.',
    },
    'elements_pending': {
      'fr': '{0} élément(s) en file d\'attente.',
      'mg': '{0} zavatra miandry.',
    },
    'fokontany_colon': {'fr': 'Fokontany : {0}', 'mg': 'Fokontany : {0}'},
    'location_allowed': {
      'fr': 'Emplacement autorisé',
      'mg': 'Tena ekena ny toerana',
    },
    'id_type_indiv': {
      'fr': 'Individuel (kioska an\'ny olona iray miasa irery)',
      'mg': 'Individuel (kioska an\'ny olona iray miasa irery)',
    },
    'id_type_franchise': {
      'fr': 'Franchise (kioska miasa amin\'ny anaran\'ny orinasa iray)',
      'mg': 'Franchise (kioska miasa amin\'ny anaran\'ny orinasa iray)',
    },
    'session_missing': {
      'fr': 'Session expirée : reconnectez-vous avant d\'envoyer.',
      'mg': 'Lasa ny fidirana : hiditra indray alohan\'ny fanerena.',
    },
    'map_load_failed': {
      'fr': 'Impossible de charger les zones interdites.',
      'mg': 'Tsy nahomby ny fakana ny faritra voarara.',
    },
    'phone_format_error': {
      'fr': 'Numéro invalide (9 chiffres requis, ex. 034 12 345 67)',
      'mg': 'Laharana tsy marina (mila isa 9, oh. 034 12 345 67)',
    },
    'request_otp': {
      'fr': 'Recevoir le code SMS',
      'mg': 'Mahazo ny kaody SMS',
    },
    'nom_label': {'fr': 'Nom (selon CIN)', 'mg': 'Anarana (araka ny CIN)'},
    'prenom_label': {'fr': 'Prénoms', 'mg': 'Fanampiny'},
    'otp_length': {'fr': 'Code à 6 chiffres', 'mg': 'Kaody isa 6'},
    'pin_digits': {
      'fr': '9 chiffres requis (ex. 034 12 345 67)',
      'mg': 'Mila isa 9 (oh. 034 12 345 67)',
    },
    'renewal_amount': {'fr': 'Renouvellement annuel', 'mg': 'Fanavaozana isan-taona'},
    'qr_not_captured': {
      'fr': 'Impossible de générer l\'image du QR code.',
      'mg': 'Tsy nahomby ny famoronana ny sary QR.',
    },
    'zone_blocked': {
      'fr': 'Demande bloquée — zone interdite',
      'mg': 'Voasakana — faritra sivana',
    },
    'submit_btn': {'fr': 'Soumettre ma demande', 'mg': 'Alefa ny fangatahana'},
    'submit_success': {
      'fr': 'Demande soumise avec succès',
      'mg': 'Nalefa soa aman-tsara ny fangatahana',
    },
    'submit_offline': {
      'fr': 'Demande enregistrée hors ligne — à synchroniser',
      'mg': 'Voatahiry eo an-toerana — miandry synchronization',
    },

    // --- Suivi dossier ---
    'track_title': {
      'fr': 'Suivi de mon dossier',
      'mg': 'Fanaraha-maso ny raharaha',
    },
    'status_en_cours': {'fr': 'En cours d\'instruction', 'mg': 'Am-ponja'},
    'status_approved': {'fr': 'Approuvé', 'mg': 'Ekena'},
    'status_rejected': {'fr': 'Rejeté', 'mg': 'Nolavina'},
    'droit_install': {
      'fr': 'Droit d\'installation',
      'mg': 'Hakam-bola fanorenana',
    },
    'empty_dossier': {
      'fr': 'Aucun dossier pour le moment',
      'mg': 'Tsy mbola misy antontan-taratasy',
    },

    // --- Agent ---
    'agent_home_title': {'fr': 'Agent communal', 'mg': 'Mpiasan\'ny kaominina'},
    'scan_kiosque': {'fr': 'Scanner un kiosque', 'mg': 'Scanner ny kioska'},
    'scan_hint': {
      'fr': 'Scannez le QR Code apposé sur le kiosque',
      'mg': 'Scannera ny QR Code eo amin\'ny kioska',
    },
    'pending_sync': {
      'fr': 'éléments en attente de synchronisation',
      'mg': 'zavatra miandry synchronization',
    },
    'no_session': {
      'fr': 'Agent non connecté',
      'mg': 'Tsy tafiditra ny mpitandrina',
    },
    'recent_kiosques': {
      'fr': 'Kiosques contrôlés récemment',
      'mg': 'Kioska vao voasaina',
    },
    'kiosques_redevables': {
      'fr': 'Kiosques redevables',
      'mg': 'Kioska tsy voaloa',
    },
    'redevables_hint': {
      'fr': 'Recouvrement sur le terrain : kiosques en retard de paiement',
      'mg': 'Fanangonana eny an-kalalahana : kioska tara fandoavana',
    },
    'redevables_summary': {
      'fr': '{0} kiosque(s) redevable(s) · dette totale {1}',
      'mg': '{0} kioska tsy voaloa · trosa rehetra {1}',
    },
    'redevables_empty': {
      'fr': 'Aucun kiosque redevable pour le moment.',
      'mg': 'Tsy misy kioska tsy voaloa amin\'izao fotoana izao.',
    },

    // --- Instruction des dossiers par l'agent communal (§ 4.4) ---
    'dossiers_title': {
      'fr': 'Dossiers à instruire',
      'mg': 'Taratasy mitarika ny fanapahana',
    },
    'dossiers_hint': {
      'fr': 'Approuver, corriger ou rejeter les demandes de la commune',
      'mg': 'Hamerina, hanova na hanao fanafihana ny fangatahana',
    },
    'dossiers_summary': {
      'fr': '{0} dossier(s) · {1} en attente de décision',
      'mg': '{0} taratasy · {1} miandry fanapahana',
    },
    'dossiers_empty': {
      'fr': 'Aucun dossier dans la commune',
      'mg': 'Tsy misy taratasy ao amin\'ny kaominina',
    },
    'dossiers_empty_filter': {
      'fr': 'Aucun dossier dans ce filtre',
      'mg': 'Tsy misy taratasy amin\'ity famintinana ity',
    },
    'filter_all': {'fr': 'Tous', 'mg': 'Rehetra'},
    'dossier_decision': {
      'fr': 'Décision sur le dossier',
      'mg': 'Fanapahana ny taratasy',
    },
    'dossier_not_found': {
      'fr': 'Dossier introuvable dans la liste',
      'mg': 'Tsy hita ny taratasy ao anatin\'ny lisitra',
    },
    'label_nom_prenoms': {'fr': 'Nom & prénoms', 'mg': 'Anarana & fanampiny'},
    'label_date_soumission': {
      'fr': 'Date de soumission',
      'mg': 'Daty nampidirana',
    },
    'label_statut_droit': {
      'fr': 'Statut du droit',
      'mg': 'Toetra ny hakam-bola',
    },
    'label_droit_montant': {
      'fr': 'Montant du droit',
      'mg': 'Havanan\'ny hakam-bola',
    },
    'label_kiosque_code': {'fr': 'Code kiosque', 'mg': 'Kaody kioska'},
    'label_autorisation': {
      'fr': 'N° d\'autorisation',
      'mg': 'Laharana fanolerana',
    },
    'label_georestriction': {
      'fr': 'Contrôle de zone',
      'mg': 'Fandraisana faritra',
    },
    'label_note': {'fr': 'Note / motif', 'mg': 'Fanazavana / antony'},
    'pieces_jointes': {'fr': 'Pièces jointes', 'mg': 'Fandrahoana'},
    'decision_approve': {'fr': 'Approuver', 'mg': 'Hamerina'},
    'decision_corrections': {
      'fr': 'Demander des corrections',
      'mg': 'Mitaky fanovana',
    },
    'decision_reject': {'fr': 'Rejeter', 'mg': 'Hanao fanafihana'},
    'decision_approve_title': {
      'fr': 'Approuver ce dossier ?',
      'mg': 'Hamerina ity taratasy ity ?',
    },
    'decision_approve_body': {
      'fr': 'La fiche kiosque sera créée automatiquement : le kiosque devient '
          'scannable et le droit d\'installation devient exigible.',
      'mg': 'Hatroka ho azy ny kaominina kioska : afaka mitsipika sy '
          'mandray ny hakam-bola ny kioska.',
    },
    'decision_corrections_title': {
      'fr': 'Corrections à apporter',
      'mg': 'Fanovana tokony atao',
    },
    'decision_corrections_hint': {
      'fr': 'Consigne transmise au demandeur (10 caractères min.)',
      'mg': 'Torolàlana alefa any amin\'ny mpangataka (10 litera farany)',
    },
    'decision_reject_title': {
      'fr': 'Motif du rejet',
      'mg': 'Anton\'ny fanafihana',
    },
    'decision_reject_hint': {
      'fr': 'Motif obligatoire, transmis au demandeur (10 caractères min.)',
      'mg': 'Ilaina ny antony alefa any amin\'ny mpangataka (10 litera farany)',
    },
    'decision_note_required': {
      'fr': 'Ce motif est obligatoire.',
      'mg': 'Ilaina ity antony ity.',
    },
    'decision_pending': {
      'fr': 'Décision en cours…',
      'mg': 'Mandritra ny fanapahana…',
    },
    'statut_vert': {'fr': 'EN RÈGLE', 'mg': 'AMPOIZANA'},
    'statut_orange': {
      'fr': 'DROIT D\'INSTALLATION EN ATTENTE',
      'mg': 'MIANDRAKY NY HAKAM-BOLA',
    },
    'statut_rouge': {'fr': 'REDEVABLE', 'mg': 'TSY VOALOA'},
    'debt': {'fr': 'Dette cumulée', 'mg': 'Trosa'},
    'fiche_technique': {
      'fr': 'Fiche d\'identité technique',
      'mg': 'Momba ny kioska',
    },
    'etat_financier': {'fr': 'État financier', 'mg': 'Toetran\'ny vola'},
    'neighbors': {'fr': 'Kiosques voisins', 'mg': 'Kioska akaiky'},
    'encaisse': {'fr': 'Encaisser une taxe', 'mg': 'Raiso ny vola'},
    'report_anomaly': {
      'fr': 'Signaler une anomalie',
      'mg': 'Hitantara ny tsy ara-dalàna',
    },
    'kiosque_not_found': {
      'fr': 'Kiosque non déclaré dans le système',
      'mg': 'Kioska tsy voasoratra',
    },
    'amount_label': {'fr': 'Montant perçu (Ar)', 'mg': 'Vola voaray (Ar)'},
    'tax_nature': {'fr': 'Nature de la taxe', 'mg': 'Karazana hetra'},
    'tax_installation': {
      'fr': 'Droit d\'installation (150 000 Ar)',
      'mg': 'Hakam-bola fanorenana (150 000 Ar)',
    },
    'tax_renouvellement': {
      'fr': 'Renouvellement annuel (120 000 Ar)',
      'mg': 'Fanavaozana isan-taona (120 000 Ar)',
    },
    'receipt': {'fr': 'Quittance', 'mg': 'Tsitapaka'},
    'print_receipt': {
      'fr': 'Imprimer la quittance',
      'mg': 'Ataraina ny tsitapaka',
    },
    'printing': {'fr': 'Impression…', 'mg': 'Ataraina…'},
    'print_fallback': {
      'fr': 'Impression simulée (aucune imprimante connectée)',
      'mg': 'Inimpression noforonina (tsy misy imprimanta)',
    },
    'anomaly_types': {
      'fr': 'Type d\'anomalie',
      'mg': 'Karazana tsy ara-dalàna',
    },
    'anom_undeclared': {
      'fr': 'Kiosque non déclaré (absence de QR/contrat)',
      'mg': 'Kioska tsy voasoratra',
    },
    'anom_nonconform': {
      'fr': 'Non-conformité physique',
      'mg': 'Tsy mifanaraka amin\'ny dossier',
    },
    'anom_moved': {
      'fr': 'Déplacement du kiosque (GPS différent)',
      'mg': 'Nifindra ny kioska',
    },
    'anom_details': {'fr': 'Description / observation', 'mg': 'Fanazavana'},
    'location_blocked_msg': {
      'fr': 'Implantation dans une zone interdite',
      'mg': 'Tsy azo hipetraka eo',
    },

    // --- QR Code de référence (autocollant kiosque) ---
    'kiosque_qr': {'fr': 'Code QR du kiosque', 'mg': 'QR Code ny kioska'},
    'qr_subtitle': {
      'fr': 'Autocollant QR — code de référence scannable',
      'mg': 'QR Code — kaody fitadiavana ny kioska',
    },
    'qr_save': {'fr': 'Enregistrer le QR (PNG)', 'mg': 'Tehirizo ny QR (PNG)'},
    'qr_saved': {'fr': 'QR enregistré', 'mg': 'Voatahiry ny QR'},
    'qr_scannable': {
      'fr': 'Scannez ce code dans l\'espace agent : il charge la fiche kiosque',
      'mg': 'Scaneo ity kaody ity ao amin\'ny laharan\'ny mpiasa : hampiditra ny mombamomba ny kioska',
    },
    'qr_web_hint': {
      'fr': 'L\'export PNG est disponible sur Android / bureau.',
      'mg': 'Azo atao amin\'ny Android / solosaina ny fisokafana PNG.',
    },
    'map_offline': {
      'fr': 'Hors ligne : la carte OpenStreetMap nécessite une connexion internet (forfait de données).',
      'mg': 'Tsy misy tambazotra : mila internet (forfait) ny carte OpenStreetMap.',
    },
    'map_here': {'fr': 'Vous êtes ici', 'mg': 'Eto ianao'},
    'map_kiosque': {'fr': 'Kiosque', 'mg': 'Kioska'},

    // --- Mes paiements (section 5.4 / 4.2) ---
    'payments_title': {'fr': 'Mes paiements', 'mg': 'Ny fandoavam-bolako'},
    'payments_total_paid': {'fr': 'Total réglé', 'mg': 'Voaloa rehetra'},
    'payments_total_due': {'fr': 'Reste à payer', 'mg': 'Mbola tsy voaloa'},
    'payments_empty': {
      'fr': 'Aucun paiement enregistré pour le moment.\nVos taxes apparaîtront ici après paiement auprès de l\'agent communal.',
      'mg': 'Tsy mbola misy fandoavam-bola.\nHisetra eo ny hetranao aorian\'ny fandoavana amin\'ny mpiasan\'ny kaominina.',
    },
    'payments_type_installation': {
      'fr': 'Droit d\'installation',
      'mg': 'Hakam-bola fanorenana',
    },
    'payments_type_renewal': {
      'fr': 'Renouvellement annuel',
      'mg': 'Fanavaozana isan-taona',
    },
    'payments_status_paid': {'fr': 'Réglé', 'mg': 'Voaloa'},
    'payments_status_due': {'fr': 'À payer', 'mg': 'Tsy voaloa'},
    'payments_status_acjour': {'fr': 'À jour', 'mg': 'Ampy'},
    'payments_status_retard': {'fr': 'En retard', 'mg': 'Tara'},
    'payments_exercise': {'fr': 'Exercice', 'mg': 'Taona'},
    'payments_quittance': {'fr': 'Quittance', 'mg': 'Tsitapaka'},
    'payments_due_date': {'fr': 'Échéance', 'mg': 'Daty fandoavana'},
    'payments_via_agent': {
      'fr': 'Le paiement s\'effectue en espèces auprès de l\'agent communal.',
      'mg': 'Ny fandoavana dia atao amin\'ny mpiasan\'ny kaominina.',
    },
    'renewal_history': {
      'fr': 'Historique des renouvellements',
      'mg': 'Tantaran\'ny fanavaozana',
    },
    'overdue_months': {'fr': 'mois de retard', 'mg': 'volana tara'},
    'renewal_current_year': {
      'fr': 'Exercice en cours',
      'mg': 'Taona ankehitriny',
    },

    // --- Notifications (section 12) ---
    'notifications_title': {'fr': 'Notifications', 'mg': 'Fampandrenesana'},
    'notifications_empty': {
      'fr': 'Aucune notification pour le moment.',
      'mg': 'Tsy misy fampandrenesana.',
    },
    'notifications_mark_read': {
      'fr': 'Tout marquer comme lu',
      'mg': 'Hamarino hoe voavaky daholo',
    },
    'notifications_unread': {'fr': 'non lue(s)', 'mg': 'tsy voavaky'},
    'notifications_mark_one_read': {'fr': 'Marquer comme lu', 'mg': 'Hamarino ho voavaky'},
    'notif_anomaly_title': {
      'fr': 'Anomalie signalée par l\'agent communal',
      'mg': 'Nanao fanambarana ny mpiasa ny olana',
    },
    'notif_anomaly_message': {
      'fr': 'Une anomalie de type « {0} » a été signalée sur votre kiosque '
          '{1} le {2}.\n\nMessage de l\'agent : {3}\n\nAction attendue : '
          'corrigez la situation constatée ou contactez la Commune Urbaine '
          'de Fianarantsoa.',
      'mg': 'Nisy olana karazana « {0} » voasaina eo amin\'ny kioskanao {1} '
          'amin\'ny {2}.\n\nHafatran\'ny mpiasa : {3}\n\nZavatra tokony '
          'atao : amaro ny olana na mifandray amin\'ny Kaominina.',
    },
    'anomaly_type_label': {'fr': 'Type : {0}', 'mg': 'Karazana : {0}'},
    'load_notifications_failed': {
      'fr': 'Impossible de charger les notifications.',
      'mg': 'Tsy nahomby ny fakana ny fampandrenesana.',
    },

    // --- Carte des zones d'exclusion (section 5.3) ---
    'map_title': {'fr': 'Zone d\'exclusion', 'mg': 'Faritra voarara'},
    'show_map': {'fr': 'Voir la carte', 'mg': 'Jereo ny sarintany'},
    'hide_map': {'fr': 'Masquer la carte', 'mg': 'Afeno ny sarintany'},
    'you_are_here': {'fr': 'Vous êtes ici', 'mg': 'Eto ianao'},
    'forbidden_zone': {'fr': 'Zone interdite', 'mg': 'Faritra voarara'},
    'map_hint': {
      'fr': 'Repositionnez votre projet hors de la zone rouge.',
      'mg': 'Ampifindrao ny tetikasanao any ivelan\'ny faritra mena.',
    },

    // --- Formulaire : validation & brouillon ---
    'field_required': {'fr': 'Champ obligatoire', 'mg': 'Tsy maintsy fenoina'},
    'cin_invalid': {
      'fr': 'N° CIN invalide (6 caractères min, chiffres/lettres)',
      'mg': 'CIN tsy marina',
    },
    'invalid_number': {'fr': 'Valeur numérique invalide', 'mg': 'Tsy isa io'},
    'must_be_positive': {
      'fr': 'Supérieur à 0 requis',
      'mg': 'Mila lehibe noho ny 0',
    },
    'draft_restored': {
      'fr': 'Brouillon restauré',
      'mg': 'Voatsitsy ny drafitra',
    },
    'select_fokontany': {
      'fr': 'Sélectionnez un Fokontany',
      'mg': 'Fidio ny Fokontany',
    },
    'select_materials': {
      'fr': 'Sélectionnez un matériau',
      'mg': 'Fidio ny fitaovana',
    },
    'select_one_operator': {
      'fr': 'Sélectionnez au moins un opérateur',
      'mg': 'Misafidiana mpanome iray farafahakeliny',
    },
    'select_type_identification': {
      'fr': 'Choisissez le type d\'identification',
      'mg': 'Fidio ny karazana fanazavana',
    },
    'emplacement_required': {
      'fr': 'Décrivez l\'emplacement (10 caractères min.)',
      'mg': 'Soraty ny toerana (firenena 10 farafahakeliny)',
    },
    'dimensions_required': {
      'fr': 'Longueur et largeur obligatoires',
      'mg': 'Mila halavana sy lafiny',
    },
    'photo_emplacement_required': {
      'fr': 'Photo de l\'emplacement obligatoire',
      'mg': 'Mila sarin\'ny toerana',
    },
    'form_incomplete': {
      'fr': 'Formulaire incomplet : corrigez les champs signalés.',
      'mg': 'Tsy feno : amaro ny samy misy olana.',
    },
    'prerequisites_before_submit': {
      'fr': 'Avant l\'envoi : position GPS capturée, zone autorisée, photo de l\'emplacement.',
      'mg': 'Alohatra ny fanerena : GPS voaraiso, toerana noana, sarin\'ny toerana.',
    },

    // --- Verrouillage / sécurité ---
    'locked_title': {
      'fr': 'Application verrouillée',
      'mg': 'Voahidy ny aplikasi',
    },
    'unlock_pin': {
      'fr': 'Saisir votre PIN pour déverrouiller',
      'mg': 'Ampidiro ny PIN hialana',
    },
    'biometric': {'fr': 'Empreinte digitale', 'mg': 'Dian-tanana'},

    // --- Divers ---
    'session_required': {
      'fr': 'Session requise: reconnectez-vous.',
      'mg': 'Mila fidirana indray.',
    },
    'wait_progress': {'fr': 'Veuillez patienter…', 'mg': 'Andraso kely…'},
    'result_ok': {'fr': 'Opération réussie', 'mg': 'Vita soa aman-tsara'},
    'kodiac': {
      'fr': 'Commune Urbaine de Fianarantsoa',
      'mg': 'Kaominina Fianarantsoa',
    },
    'gps': {'fr': 'GPS', 'mg': 'GPS'},
    'owner': {'fr': 'Propriétaire', 'mg': 'Tompony'},
    'authorization': {'fr': 'Autorisation', 'mg': 'Fahazoan-dalana'},
    'dates': {'fr': 'Date', 'mg': 'Daty'},
    'number': {'fr': 'N°', 'mg': 'N°'},
    'distance': {'fr': 'Distance', 'mg': 'Halavirana'},
    'status': {'fr': 'Statut', 'mg': 'Sata'},
    'operators_label': {'fr': 'Opérateurs', 'mg': 'Mpanome'},
    'materials_label': {'fr': 'Matériaux', 'mg': 'Fitaovana'},
    'dimensions': {'fr': 'Dimensions (L x l)', 'mg': 'Halehibe (L x l)'},
    'occupation': {'fr': 'Occupation du sol', 'mg': 'Fisahanan\'ny tany'},
    'fokontany_list': {'fr': 'Fokontany', 'mg': 'Fokontany'},

    // --- Agent : accueil, profil, synchronisation ---
    'profile': {'fr': 'Profil', 'mg': 'Mombamomba'},
    'profile_title': {'fr': 'Profil et session', 'mg': 'Mombamomba sy fidirana'},
    'profile_role': {'fr': 'Rôle', 'mg': 'Lohahevitra'},
    'profile_token': {'fr': 'Jeton de session', 'mg': 'Famintinana session'},
    'profile_cache_section': {'fr': 'Cache local', 'mg': 'Cache an-teraina'},
    'agent_session': {'fr': 'Session : {0}…', 'mg': 'Fidirana : {0}…'},
    'agent_cache': {
      'fr': 'État du cache local (Isar)',
      'mg': 'Toe-javatra cache an-teraina (Isar)',
    },
    'agent_cache_count': {
      'fr': 'Kiosques en cache : {0}',
      'mg': 'Kiosque ao amin\'ny cache : {0}',
    },
    'agent_cache_hint': {
      'fr': 'Liste des kiosques ouverts/récemment scannés sur cet appareil '
          '(données hors-ligne).',
      'mg': 'Lisitry ny kiosque nosafidiana tamin\'ity fitaovana ity '
          '(data oflaine).',
    },
    'recent_empty': {
      'fr': 'Aucun kiosque récent pour le moment.',
      'mg': 'Tsy misy kiosque vao ankehitriny.',
    },
    'sync_short': {'fr': 'Synchro', 'mg': 'Hafarana'},
    'load_failed': {
      'fr': 'Échec du chargement des données.',
      'mg': 'Tsy nahomby ny fakana ny angona.',
    },
    'search_hint': {'fr': 'Rechercher…', 'mg': 'Tadiavo…'},
    'search_no_result': {
      'fr': 'Aucun résultat pour cette recherche.',
      'mg': 'Tsy misy valiny amin\'ity karangana ity.',
    },
    'sync_done': {
      'fr': '{0} opérations synchronisées.',
      'mg': 'Nisy {0} asa nifehy.',
    },
    'encaissement_offline': {
      'fr': 'Encaissement enregistré hors-ligne : quittance locale émise, '
          'synchronisation dès le retour du réseau.',
      'mg': 'Tehirizina oflaine ny fandoavana : nahatratra tetikasa '
          'an-teraina, hifehy raha miverina ny netwaka.',
    },
    'anomaly_reported': {
      'fr': 'Anomalie signalée avec succès.',
      'mg': 'Voaray soa aman-tsara ny olana.',
    },
    'anomaly_reported_offline': {
      'fr': 'Anomalie enregistrée hors-ligne : synchronisation dès le retour '
          'du réseau.',
      'mg': 'Tehirizina oflaine ny olana : hifehy raha miverina ny netwaka.',
    },

    // --- Agent : signalement d'anomalie (§ 6.5) ---
    'anom_gps_missing_title': {'fr': 'GPS non capturé', 'mg': 'Tsy nahatratra ny GPS'},
    'anom_gps_missing_body': {
      'fr': 'Impossible de récupérer la position. L\'anomalie sera signalée '
          'sans coordonnées GPS, ce qui réduit la traçabilité de '
          'l\'opération (sections 4.3 / 10 du cahier des charges). '
          'Continuer malgré tout ?',
      'mg': 'Tsy afaka mandaka ny toerana. Hitera ny olana tsy misy GPS, '
          'mamphefi ny fijerena ny asa (§ 4.3 / 10). Tohizo ve?',
    },
    'anom_continue_no_gps': {'fr': 'Continuer sans GPS', 'mg': 'Tohizo tsy misy GPS'},
    'anom_type': {'fr': 'Type d\'anomalie', 'mg': 'Karazana olana'},
    'anom_hint': {
      'fr': 'Décrivez l\'anomalie constatée…',
      'mg': 'Soraty ny olana hita…',
    },
    'gps_pending': {'fr': 'GPS en cours…', 'mg': 'GPS mipetraka…'},
    'gps_missing_short': {
      'fr': 'GPS non capturé — traçabilité réduite',
      'mg': 'GPS tsy nahatratra — kely ny fijerena',
    },
    'gps_warning': {
      'fr': 'L\'anomalie sera signalée sans coordonnées GPS. Une '
          'confirmation sera demandée à l\'envoi.',
      'mg': 'Hitera ny olana tsy misy GPS. Hisafidy ianao alohan\'ny '
          'fandefasana.',
    },

    // --- Agent : scanner QR (§ 6.1) ---
    'scan_import': {'fr': 'Lire un QR depuis la galerie', 'mg': 'Mamaky QR avy amin\'ny album'},
    'scan_processing': {'fr': 'Analyse du code…', 'mg': 'Anaovanana ny kaody…'},
    'scan_no_qr': {
      'fr': 'Aucun code QR détecté dans cette image.',
      'mg': 'Tsy misy QR hita ao anatin\'ity sary ity.',
    },
    'scan_multiple_qr': {
      'fr': 'Plusieurs codes QR détectés : utilisez une image plus précise '
          'ou le scan caméra.',
      'mg': 'Misy QR maro : ampio sary marina kokoa na ampiasao ny '
          'fisakanana amin\'ny foto-panandroana.',
    },
    'scan_read_error': {
      'fr': 'Impossible d\'analyser cette image.',
      'mg': 'Tsy afaka anaovanana ity sary ity.',
    },
    'scan_permission_denied': {
      'fr': 'Autorisation caméra refusée. Autorisez la caméra dans les '
          'paramètres puis réessayez.',
      'mg': 'Tsy ahafahana ny fahazotoana. Alefao ny foto-panandroana ao '
          'amin\'ny fametrana ary averinao.',
    },
    'scan_unsupported': {
      'fr': 'Le scan QR n\'est pas pris en charge sur cet appareil.',
      'mg': 'Tsy manohana ny fisakanana QR io milina io.',
    },
    'scan_camera_error': {
      'fr': 'Caméra indisponible',
      'mg': 'Tsy ahafahana mampiasa foto-panandroana',
    },
    'scan_unknown_kiosk_title': {
      'fr': 'Kiosque non déclaré',
      'mg': 'Kioske tsy voasoratra',
    },
    'scan_unknown_kiosk_body': {
      'fr': 'Le code « {0} » ne correspond à aucune fiche enregistrée.\n\n'
          'Signaler ce kiosque comme non déclaré ?',
      'mg': 'Ny kaody « {0} » dia tsy mifandray amin\'ny angona misy.\n\n'
          'Hilaza ve ny kioske ho tsy voasoratra?',
    },
    'scan_qr_unassigned': {
      'fr': 'QR Code scanné non attribué à une fiche autorisée.',
      'mg': 'QR nanaovana tsy mifandray amin\'ny angona fahazoan-dalana.',
    },

    // --- Agent : encaissement (§ 6.4) ---
    'enc_gps_missing_body': {
      'fr': 'Impossible de récupérer la position. La quittance sera émise '
          'sans coordonnées GPS, ce qui réduit la traçabilité de '
          'l\'encaissement (sections 4.3 / 10 du cahier des charges). '
          'Continuer malgré tout ?',
      'mg': 'Tsy afaka mandaka ny toerana. Hanao tetikasa tsy misy GPS io, '
          'mamphefi ny fijerena (§ 4.3 / 10). Tohizo ve?',
    },
    'enc_amount_invalid': {
      'fr': 'Montant invalide : saisissez un nombre entier positif.',
      'mg': 'Tsy mety ny vidy : ampidiro isa manankena.',
    },
    'enc_nature_installation': {
      'fr': 'Droit d\'installation — {0} Ar',
      'mg': 'Fahazoan-dalana handamina — {0} Ar',
    },
    'enc_nature_renewal': {
      'fr': 'Renouvellement annuel — {0} Ar',
      'mg': 'Fanavaozana isan-taona — {0} Ar',
    },
    'enc_amount_label': {
      'fr': 'Montant perçu (Ar)',
      'mg': 'Vidin\'ny angona no raisina (Ar)',
    },
    'enc_gps_warning': {
      'fr': 'La quittance sera émise sans coordonnées GPS. Une '
          'confirmation sera demandée à la validation.',
      'mg': 'Hanao tetikasa tsy misy GPS. Hisafidy ianao alohan\'ny '
          'fanamarinana.',
    },
    'enc_recording': {'fr': 'Enregistrement…', 'mg': 'Mitahiry…'},
    'enc_validate': {
      'fr': 'Valider l\'encaissement',
      'mg': 'Manamarina ny fandoavana',
    },
    'timestamp': {'fr': 'Horodatage : {0}', 'mg': 'Fotoana : {0}'},
    'receipt_printed': {'fr': 'Quittance imprimée ✅', 'mg': 'Voasoratra ny tetikasa ✅'},
    'close': {'fr': 'Fermer', 'mg': 'Hidio'},
    'print': {'fr': 'Imprimer', 'mg': 'Soratra'},

    // --- Agent : tableau de bord kiosque (§ 6.2) ---
    'kiosque_fiche': {'fr': 'Fiche du kiosque', 'mg': 'Tolom-boninahitra kioske'},
    'dash_empty': {
      'fr': 'Aucun kiosque chargé.',
      'mg': 'Tsy misy kioske natao.',
    },
    'dash_cash': {
      'fr': '150 000 Ar / 120 000 Ar — espèces',
      'mg': '150 000 Ar / 120 000 Ar — vola baraka',
    },
    'dash_phone': {'fr': 'Tél.', 'mg': 'Fonona'},
    'dash_type': {'fr': 'Type', 'mg': 'Karazana'},
    'dash_general_state': {'fr': 'Etat général', 'mg': 'Toe-javatra ankapobeny'},
    'dash_landmark': {'fr': 'Repère', 'mg': 'Toerana fantatra'},
    'dash_auth_no': {'fr': 'N° Autorisation', 'mg': 'Laharana fahazoan-dalana'},
    'dash_auth_date': {'fr': 'Date autorisation', 'mg': 'Daty nahazoan-dalana'},
    'dash_avis_no': {'fr': 'N° Avis de paiement', 'mg': 'Laharana fanomezana'},
    'dash_quittance_no': {'fr': 'N° Quittance', 'mg': 'Laharana tetikasa'},
    'dash_quittance_date': {'fr': 'Date Quittance', 'mg': 'Daty tetikasa'},
    'dash_droit_stat': {
      'fr': 'Droit installation',
      'mg': 'Sata fahazoan-dalana',
    },
    'dash_taxe_stat': {
      'fr': 'Taxe mensuelle',
      'mg': 'Loha vidy isam-bolana',
    },
    'dash_delay_months': {'fr': 'Mois de retard', 'mg': 'Volana goana'},
    'months': {'fr': 'mois', 'mg': 'volana'},
    'dash_total_debt': {'fr': 'Total dette', 'mg': 'Totalan\'ny zavatrandro'},
    'dash_encaisse_hint': {
      'fr': 'L\'encaissement immédiat réduit la dette à {0} Ar.',
      'mg': 'Raha mandeha ny fandoavana dia hihena ny zavatrandro ho {0} Ar.',
    },
    'dash_offline_hint': {
      'fr': 'Encaissement hors ligne possible.',
      'mg': 'Afaka mandeha oflaine ny fandoavana.',
    },
    'dash_case_current': {'fr': 'Dossier en cours', 'mg': 'Dangana mandeha'},
    'dash_avis': {'fr': 'Avis de paiement', 'mg': 'Hafatra fanomezana'},

    // --- QR kiosque (export + écran partagé agent/demandeur) ---
    'qr_title_line': {
      'fr': 'RECOUVREMENT MOBILE MONEY',
      'mg': 'FANANGONANA MOBILE MONEY',
    },
    'qr_kioske_line': {
      'fr': 'Kiosque Mobile Money',
      'mg': 'Kioske Mobile Money',
    },
    'qr_export_error': {
      'fr': 'Erreur d\'export : {0}',
      'mg': 'Tsy nahomby ny fampidirana : {0}',
    },

    // --- Citoyen : suivi de dossier (§ 5.4) ---
    'case_number': {'fr': 'N° dossier', 'mg': 'Laharana angona'},
    'statut_droit': {'fr': 'Statut droit', 'mg': 'Sata fahazoan-dalana'},
    'paid_yes': {'fr': 'Payé ✓', 'mg': 'Voalà ✓'},
    'status_waiting': {'fr': 'En attente', 'mg': 'Miandry'},
    'rejection_reason': {'fr': 'Motif : {0}', 'mg': 'Antony : {0}'},
    'receipt_label': {'fr': 'Quittance {0}', 'mg': 'Tetikasa {0}'},
    'paid_status_ok': {'fr': 'À jour ✓', 'mg': 'Umbana ✓'},
    'paid_status_late': {'fr': 'En retard', 'mg': 'Goana'},

    // --- Agent : détail dossier (§ 4.4) ---
    'label_date_creation': {'fr': 'Date de création', 'mg': 'Daty namoronana'},
    'non_disponible_backend': {
      'fr': 'NON DISPONIBLE DANS LE BACKEND',
      'mg': 'TSY MISY AMIN\'NY BACKEND',
    },
    'photos_label': {'fr': 'Photos du dossier', 'mg': 'Sarin\'ny angona'},
    'photo_zoom_hint': {
      'fr': 'Touchez une photo pour l\'agrandir',
      'mg': 'Tadiavo sary iray hamafina ny habenany',
    },
    'photo_absent': {'fr': 'Aucune photo', 'mg': 'Tsy misy sary'},
  };

  String t(String key, {List<Object?> args = const []}) =>
      traduire(key, args: args);

  /// Traduction sans contexte (Cubits, services de notification…), dans la
  /// dernière locale construite par le délégué de localisation.
  static String traduire(String key, {List<Object?> args = const []}) {
    final map = _keys[key] ?? {'fr': key, 'mg': key};
    var text = localeCourante.languageCode == 'mg'
        ? (map['mg'] ?? map['fr']!)
        : map['fr']!;
    for (var i = 0; i < args.length; i++) {
      text = text.replaceAll('{$i}', '${args[i]}');
    }
    return text;
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['fr', 'mg'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    // SynchronousFuture pour éviter le flicker au premier rendu.
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}

// ===========================================================================
// DELEGUES DE REPLI POUR LE MALGACHE ('mg')
// ===========================================================================
// `flutter_localizations` ne fournit ni MaterialLocalizations, ni
// WidgetsLocalizations, ni CupertinoLocalizations en malgache. Comme
// `MaterialApp` n'ajoute plus ses delegates par défaut dès qu'une liste
// explicite est fournie, basculer en 'mg' retirait MaterialLocalizations de
// l'arbre : le build échouait et l'application affichait un écran vide.
//
// Ces delegates réutilisent les localisations Material françaises pour 'mg' :
// les libellés de l'application restent bien malgaches (via
// [AppLocalizationsDelegate]), seul le texte système du framework est français.
class MaterialLocalizationsFallbackDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const MaterialLocalizationsFallbackDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'mg';

  @override
  Future<MaterialLocalizations> load(Locale locale) =>
      GlobalMaterialLocalizations.delegate.load(const Locale('fr'));

  @override
  bool shouldReload(MaterialLocalizationsFallbackDelegate old) => false;
}

class WidgetsLocalizationsFallbackDelegate
    extends LocalizationsDelegate<WidgetsLocalizations> {
  const WidgetsLocalizationsFallbackDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'mg';

  @override
  Future<WidgetsLocalizations> load(Locale locale) =>
      GlobalWidgetsLocalizations.delegate.load(const Locale('fr'));

  @override
  bool shouldReload(WidgetsLocalizationsFallbackDelegate old) => false;
}

class CupertinoLocalizationsFallbackDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const CupertinoLocalizationsFallbackDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'mg';

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      GlobalCupertinoLocalizations.delegate.load(const Locale('fr'));

  @override
  bool shouldReload(CupertinoLocalizationsFallbackDelegate old) => false;
}

/// Liste de delegates prête à l'emploi pour le [MaterialApp] de l'application.
const List<LocalizationsDelegate<dynamic>> appLocalizationsDelegates = [
  AppLocalizationsDelegate(),
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
  MaterialLocalizationsFallbackDelegate(),
  WidgetsLocalizationsFallbackDelegate(),
  CupertinoLocalizationsFallbackDelegate(),
];

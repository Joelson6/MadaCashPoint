import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cuf_recouvrement_mobile/core/localization/app_localizations.dart';
import 'package:cuf_recouvrement_mobile/core/utils/validators.dart';
import 'package:cuf_recouvrement_mobile/data/remote/kiosque_mapper.dart';
import 'package:cuf_recouvrement_mobile/data/models/kiosque.dart';

void main() {
  group('Validators (section 4.1)', () {
    test('numéro de téléphone malgache normalisé', () {
      expect(PhoneValidator.normalize('034 12 345 67'), '0341234567');
      expect(PhoneValidator.normalize('+261341234567'), '0341234567');
      expect(PhoneValidator.normalize('261341234567'), '0341234567');
      expect(PhoneValidator.isValid('020123456'), isFalse);
    });

    test('normalisation téléphone 10 chiffres', () {
      expect(PhoneValidator.normalize('0340000002'), '0340000002');
      expect(PhoneValidator.normalize('0' '340000002'), '0340000002');
      expect(PhoneValidator.normalize('261340000002'), '0340000002');
      expect(PhoneValidator.normalize('+261340000002'), '0340000002');
    });

    test('PIN 4 ou 6 chiffres uniquement', () {
      expect(PinValidator.isValid('1234'), isTrue);
      expect(PinValidator.isValid('123456'), isTrue);
      expect(PinValidator.isValid('12345'), isFalse);
      expect(PinValidator.isValid('abc4'), isFalse);
    });
  });

  group('Situation fiscale (section 8.3 / 7.2)', () {
    Kiosque kiosque({String droit = 'PAYE', String taxe = 'A_JOUR'}) {
      return Kiosque(codeKiosque: '1S008')
        ..statutDroitInstallation = droit
        ..statutTaxeMensuelle = taxe
        ..totalDetteAriary = taxe == 'REDEVABLE' ? 80000 : 0;
    }

    test('en règle => vert', () {
      expect(couleurFiscaleKiosque(kiosque()), StatutFiscalCouleur.vert);
    });

    test('droit installation en attente => orange', () {
      expect(
        couleurFiscaleKiosque(kiosque(droit: 'EN_ATTENTE')),
        StatutFiscalCouleur.orange,
      );
    });

    test('redevable => rouge (même avec droit payé)', () {
      expect(
        couleurFiscaleKiosque(kiosque(taxe: 'REDEVABLE')),
        StatutFiscalCouleur.rouge,
      );
    });
  });

  group('Mapping fiche JSON (section 8.2)', () {
    test('structure de la fiche + voisins', () {
      final k = Kiosque(codeKiosque: '1S008')
        ..campagneRecensement = 'Mobile Money CUF2026'
        ..proprietaireNom = 'RAMANANTENASOA MANAMPINIAINA clandreasy'
        ..gpsLatitude = -21.4673152
        ..gpsLongitude = 47.0667377
        ..fokontany = 'Ankidona'
        ..statutDroitInstallation = 'PAYE'
        ..statutTaxeMensuelle = 'REDEVABLE';

      final voisin = Kiosque(codeKiosque: '1S009')
        ..fokontany = 'Ankidona'
        ..gpsLatitude = -21.4673152 + 0.0001
        ..gpsLongitude = 47.0667377
        ..statutDroitInstallation = 'PAYE'
        ..statutTaxeMensuelle = 'REDEVABLE';

      final fiche = kiosqueVersFiche(k, voisins: [voisin]);
      final principal = fiche['kiosque_principal'] as Map;
      expect(principal['code_kiosque'], '1S008');
      expect(principal['campagne_recensement'], 'Mobile Money CUF2026');

      final sf = principal['situation_fiscale'] as Map;
      expect(sf['statut_droit_installation'], 'PAYE');

      final voisins = fiche['kiosques_voisins'] as List;
      expect(voisins, hasLength(1));
      final v = voisins.first as Map;
      expect(v['code_kiosque'], '1S009');
      expect(v['couleur_statut_fiscal'], 'rouge');
      expect((v['distance_estimee_metres'] as num), greaterThan(0));
    });

    test('distance Haversine ~ quelques mètres', () {
      final d = distanceMetres(
        -21.4673152,
        47.0667377,
        -21.4673152 + 0.0001,
        47.0667377,
      );
      expect(d, inInclusiveRange(5, 20));
    });
  });

  test('Traductions FR/MG disponibles', () {
    final fr = AppLocalizations(const Locale('fr'));
    final mg = AppLocalizations(const Locale('mg'));
    expect(fr.t('login_btn'), isNotEmpty);
    expect(mg.t('login_btn'), isNotEmpty);
    expect(mg.isMg, isTrue);
  });
}

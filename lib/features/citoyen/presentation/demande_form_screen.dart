import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/config/app_config.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/security/secure_store.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/document_capture.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/utils/validators.dart';
import '../../auth/bloc/auth_cubit.dart';
import '../../shared/widgets/shared_widgets.dart';
import '../bloc/demande_cubit.dart';
import '../widgets/exclusion_zone_map.dart';

/// Formulaire séquentiel de demande d'autorisation d'implantation en 3 étapes
/// (section 5.1) : Identité ➜ Spécificités commerciales ➜ Implantation GPS.
class DemandeFormScreen extends StatefulWidget {
  const DemandeFormScreen({super.key});

  @override
  State<DemandeFormScreen> createState() => _DemandeFormScreenState();
}

class _DemandeFormScreenState extends State<DemandeFormScreen> {
  // Une clé de formulaire PAR ÉTAPE : le `Stepper` vertical construit le
  // contenu de toutes les étapes dans l'arbre, donc une clé partagée
  // provoquerait « Multiple widgets used the same GlobalKey » et
  // `_formKey.currentState` désignerait la mauvaise étape à valider.
  final _formKeyStep0 = GlobalKey<FormState>();
  final _formKeyStep1 = GlobalKey<FormState>();
  final _formKeyStep2 = GlobalKey<FormState>();
  final controllers = <String, TextEditingController>{};
  bool _showMap = false;

  TextEditingController _c(String key) {
    final c = controllers.putIfAbsent(
      key,
      () => TextEditingController(text: _field(key)),
    );
    // Synchronise le contrôleur avec l'état du Cubit (restauration d'un
    // brouillon, navigation entre étapes) sans écraser la frappe en cours.
    final value = _field(key);
    if (value != c.text && c.text.isEmpty) {
      c.text = value;
    }
    return c;
  }

  String _field(String key) {
    final v = context.read<DemandeCubit>().state.fields[key];
    return v == null ? '' : '$v';
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final cubit = context.read<DemandeCubit>();
      // Restauration du brouillon éventuel (offline-first, section 11).
      final hasDraft = SecureStore.instance.loadDraftDemande() != null;
      if (hasDraft && cubit.state.fields.isEmpty && cubit.state.step == 0) {
        cubit.loadDraft();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context).t('draft_restored')),
            duration: const Duration(seconds: 2),
          ),
        );
      }
      cubit.loadZonesInterdites();
    });
  }

  @override
  void dispose() {
    for (final c in controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _captureGps(DemandeCubit cubit) async {
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!mounted) return;
      if (!serviceEnabled) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context).t('gps_error'))),
        );
        return;
      }
      var perm = await Geolocator.checkPermission();
      if (perm == LocationPermission.denied) {
        perm = await Geolocator.requestPermission();
      }
      if (perm == LocationPermission.deniedForever) {
        await Geolocator.openAppSettings();
        return;
      }
      final pos = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );
      if (!mounted) return;
      cubit.setGps(pos.latitude, pos.longitude);
      await cubit.checkLocationAllowance();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${AppLocalizations.of(context).t('gps_error')} ($e)'),
        ),
      );
    }
  }

  Future<void> _capturePhoto(
    String key, {
    ImageSource source = ImageSource.camera,
  }) async {
    final l = AppLocalizations.of(context);
    String? path;
    try {
      path = await DocumentCaptureService.capture(
        context,
        source: source,
        title: key == 'photo_cin_recto'
            ? l.t('photo_cin_recto')
            : key == 'photo_cin_verso'
            ? l.t('photo_cin_verso')
            : l.t('photo_location'),
        overlayLabel: key == 'photo_cin_recto'
            ? l.t('overlay_recto')
            : key == 'photo_cin_verso'
            ? l.t('overlay_verso')
            : l.t('overlay_emplacement'),
        overlayHint: source == ImageSource.gallery
            ? l.t('import_gallery')
            : l.t('take_photo'),
      );
    } on DocumentTooLargeException {
      // Aucune pièce jointe n'est enregistrée : on ne valide jamais un chemin
      // non contrôlé. L'utilisateur doit le savoir pour reprendre la photo.
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l.t('photo_too_large'))),
      );
      return;
    }
    if (path != null) {
      if (!mounted) return;
      context.read<DemandeCubit>().setField(key, path);
    }
  }

  /// Import d'une pièce CIN déjà photographiée (galerie) — section 5.2.
  Future<void> _importPhoto(String key) =>
      _capturePhoto(key, source: ImageSource.gallery);

  /// Suppression d'une pièce jointe : le champ repasse vide (et le fichier
  /// local est retiré pour ne pas le laisser orphelin).
  Future<void> _removePhoto(String key) async {
    final l = AppLocalizations.of(context);
    final cubit = context.read<DemandeCubit>();
    final chemin = (cubit.state.fields[key] ?? '').toString();
    cubit.setField(key, '');
    if (!kIsWeb && chemin.isNotEmpty) {
      try {
        final f = File(chemin);
        if (f.existsSync()) f.deleteSync();
      } catch (_) {
        // Un fichier déjà disparu n'est pas une erreur bloquante.
      }
    }
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(l.t('photo_removed'))));
  }

  bool _step0Valid() {
    final f = context.read<DemandeCubit>().state.fields;
    return (f['nom_prenoms'] ?? '').toString().isNotEmpty &&
        (f['cin'] ?? '').toString().isNotEmpty &&
        (f['fokontany'] ?? '').toString().isNotEmpty;
  }

  double _num(Object? v) =>
      v is num ? v.toDouble() : (double.tryParse('$v') ?? 0);

  /// Valeur d'un menu déroulant, uniquement si elle figure dans la liste.
  ///
  /// Sans cette garde, un brouillon daté d'une version précédente de la
  /// configuration provoque l'assertion « exactly one item with value » au
  /// build : le formulaire ne s'affiche plus du tout.
  String? _menu(String champ, List<String> possibles) {
    final v = _field(champ);
    return possibles.contains(v) ? v : null;
  }

  /// Message précis de ce qui manque à l'étape 2, `null` si tout est bon.
  ///
  /// Les valeurs arrivent soit d'un `TextFormField` (double), soit du
  /// brouillon JSON (int/double) : elles sont toujours relues via [num] ou
  /// un `tryParse`, jamais via un cast strict.
  String? _erreurEtape1(AppLocalizations l) {
    final f = context.read<DemandeCubit>().state.fields;
    if ((f['nom_commercial'] ?? '').toString().trim().isEmpty) {
      return l.t('field_required');
    }
    final ops = f['operateurs'];
    if (ops is! List || ops.isEmpty) return l.t('select_one_operator');
    if ((f['type_identification'] ?? '').toString().isEmpty) {
      return l.t('select_type_identification');
    }
    if (double.tryParse('${f['kiosque_longueur']}') == null ||
        double.tryParse('${f['kiosque_largeur']}') == null) {
      return l.t('invalid_number');
    }
    if (_num(f['kiosque_longueur']) <= 0 || _num(f['kiosque_largeur']) <= 0) {
      return l.t('must_be_positive');
    }
    if ((f['materiaux_construction'] ?? '').toString().isEmpty) {
      return l.t('select_materials');
    }
    return null;
  }

  /// Valide l'étape courante (validators Flutter) PUIS la cohérence métier
  /// (opérateurs, type d'identification…), avant de passer à l'étape suivante.
  /// Le message annonce précisément ce qui manque.
  VoidCallback? _validerEtape(
    BuildContext context,
    DemandeCubit cubit,
    int etape,
  ) {
    return () {
      FocusScope.of(context).unfocus();
      final l = AppLocalizations.of(context);
      final formOk =
          (etape == 0 ? _formKeyStep0 : _formKeyStep1).currentState
              ?.validate() ??
          false;
      final manquant = etape == 0
          ? (_step0Valid() ? null : l.t('field_required'))
          : _erreurEtape1(l);
      if (formOk && manquant == null) {
        cubit.nextStep();
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(manquant ?? l.t('form_incomplete'))),
      );
    };
  }

  /// Soumission finale : les TROIS étapes sont validées (une étape déjà
  /// parcourue peut contenir un champ vidé entre-temps) puis la cohérence
  /// métier et les prérequis GPS/photo. Sans quoi rien n'est envoyé.
  void _soumettre(DemandeCubit cubit) {
    FocusScope.of(context).unfocus();
    final l = AppLocalizations.of(context);
    final ok0 = _formKeyStep0.currentState?.validate() ?? false;
    final ok1 = _formKeyStep1.currentState?.validate() ?? false;
    final ok2 = _formKeyStep2.currentState?.validate() ?? false;
    final manquant = !_step0Valid()
        ? l.t('field_required')
        : (_erreurEtape1(l) ?? (!ok2 ? l.t('emplacement_required') : null)) ??
              ((ok0 && ok1) ? null : l.t('form_incomplete'));
    if (manquant != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(manquant)));
      return;
    }
    final session = context.read<AuthCubit>().state.session;
    if (session == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l.t('session_missing'))));
      return;
    }
    cubit.submit(session.telephone);
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l.t('demande_title')),
        actions: const [LanguageSwitchButton()],
      ),
      body: BlocConsumer<DemandeCubit, DemandeState>(
        listener: (context, state) {
          if (state.error != null && state.error!.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error!),
                backgroundColor: Colors.red.shade700,
              ),
            );
            context.read<DemandeCubit>().resetError();
          }
          if (state.success) {
            // Deux succès distincts : dossier confirmé par le serveur, ou
            // dossier seulement local en attente d'envoi. Annoncer « Demande
            // soumise » dans les deux cas serait un mensonge dans le second.
            final enAttente = state.pendingSync > 0;
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (ctx) => AlertDialog(
                icon: Icon(
                  enAttente ? Icons.cloud_upload : Icons.task_alt,
                  color: enAttente
                      ? AppTheme.statutOrange
                      : AppTheme.statutVert,
                  size: 48,
                ),
                title: Text(
                  enAttente ? l.t('submit_local_title') : l.t('submit_server_title'),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      enAttente ? l.t('submit_local_body') : l.t('submit_success'),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '${l.t('case_number')} : ${state.codeDossier ?? '-'}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${l.t('droit_install')} : ${Formatters.ariary(state.fields['montant_droit_installation'] ?? AppConfig.droitInstallationAriary)}',
                    ),
                    if (enAttente) ...[
                      const SizedBox(height: 8),
                      Text(
                        l.t('elements_pending', args: [state.pendingSync]),
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ],
                ),
                actions: [
                  FilledButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                      context.read<DemandeCubit>().reset();
                      Navigator.of(context).pop(true);
                    },
                    child: Text(l.t('close')),
                  ),
                ],
              ),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<DemandeCubit>();
          final step = state.step;

          return Stepper(
            currentStep: step,
            type: StepperType.vertical,
            onStepContinue: step == 0
                ? _validerEtape(context, cubit, 0)
                : step == 1
                ? _validerEtape(context, cubit, 1)
                : null,
            onStepCancel: step > 0 ? cubit.prevStep : null,
            controlsBuilder: (ctx, details) {
              // Le Stepper construit les contrôles des TROIS étapes (son
              // AnimatedCrossFade garde les deux branches en mémoire) : sans
              // cette garde, chaque étape afficherait ses propres boutons et
              // « Soumettre » apparaîtrait trois fois de suite.
              if (details.stepIndex != details.currentStep) {
                return const SizedBox.shrink();
              }
              final index = details.stepIndex;
              // `Wrap` et non `Row` : le bloc d'aide sous le bouton de
              // soumission doit pouvoir passer à la ligne.
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    if (index < 2)
                      FilledButton(
                        onPressed: _validerEtape(context, cubit, index),
                        child: Text(l.t('next_step')),
                      ),
                    if (index == 2) _buildSubmit(cubit),
                    if (index > 0)
                      TextButton(
                        onPressed: cubit.prevStep,
                        child: Text(l.t('prev_step')),
                      ),
                  ],
                ),
              );
            },
            steps: [
              Step(
                title: Text(l.t('step1')),
                isActive: step >= 0,
                state: _stepState(step, 0),
                content: _step0Form(context, cubit, l),
              ),
              Step(
                title: Text(l.t('step2')),
                isActive: step >= 1,
                state: _stepState(step, 1),
                content: _step1Form(context, cubit, l),
              ),
              Step(
                title: Text(l.t('step3')),
                isActive: step >= 2,
                state: _stepState(step, 2),
                content: _step2Form(context, cubit, l),
              ),
            ],
          );
        },
      ),
    );
  }

  StepState _stepState(int current, int index) {
    if (index < current) return StepState.complete;
    if (index == current) return StepState.editing;
    return StepState.indexed;
  }

  Widget _step0Form(
    BuildContext context,
    DemandeCubit cubit,
    AppLocalizations l,
  ) {
    return Form(
      key: _formKeyStep0,
      child: Column(
        children: [
          TextFormField(
            controller: _c('nom_prenoms'),
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              labelText: l.t('fullname_label'),
              hintText: 'ex. RASOLOARISON Jean Claude',
              prefixIcon: const Icon(Icons.person),
            ),
            validator: (v) => (v == null || v.trim().isEmpty)
                ? l.t('field_required')
                : (v.trim().length < 3 ? l.t('field_required') : null),
            onChanged: (v) => cubit.setField('nom_prenoms', v),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _c('cin'),
            textCapitalization: TextCapitalization.characters,
            decoration: InputDecoration(
              labelText: l.t('cin_label'),
              hintText: 'ex. 201 012 345 678',
              prefixIcon: const Icon(Icons.badge),
            ),
            validator: (v) =>
                CinValidator.isValid(v ?? '') ? null : l.t('cin_invalid'),
            onChanged: (v) => cubit.setField('cin', v),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _c('cin_date'),
            decoration: InputDecoration(
              labelText: l.t('cin_date_label'),
              hintText: 'ex. 2020-03-15',
              prefixIcon: const Icon(Icons.event),
            ),
            validator: (v) {
              if (v == null || v.trim().isEmpty) return l.t('field_required');
              final d = DateTime.tryParse(v.trim());
              return d == null ? l.t('cin_invalid') : null;
            },
            onChanged: (v) => cubit.setField('cin_date', v),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _c('cin_lieu'),
            decoration: InputDecoration(
              labelText: l.t('cin_lieu_label'),
              hintText: 'ex. Fianarantsoa',
              prefixIcon: const Icon(Icons.place),
            ),
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? l.t('field_required') : null,
            onChanged: (v) => cubit.setField('cin_lieu', v),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _c('quartier'),
            decoration: InputDecoration(
              labelText: l.t('quartier_label'),
              prefixIcon: const Icon(Icons.home_work),
            ),
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? l.t('field_required') : null,
            onChanged: (v) => cubit.setField('quartier', v),
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            initialValue: _menu('fokontany', AppConfig.fokontanyOfficiels),
            decoration: InputDecoration(
              labelText: l.t('fokontany_label'),
              prefixIcon: const Icon(Icons.map),
            ),
            items: AppConfig.fokontanyOfficiels
                .map((f) => DropdownMenuItem(value: f, child: Text(f)))
                .toList(),
            validator: (v) =>
                (v == null || v.isEmpty) ? l.t('select_fokontany') : null,
            onChanged: (v) => cubit.setField('fokontany', v ?? ''),
          ),
        ],
      ),
    );
  }

  Widget _step1Form(
    BuildContext context,
    DemandeCubit cubit,
    AppLocalizations l,
  ) {
    final f = cubit.state.fields;
    final operateurs = (f['operateurs'] as List?) ?? [];

    return Form(
      key: _formKeyStep1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _c('nom_commercial'),
            decoration: InputDecoration(
              labelText: l.t('commercial_name'),
              hintText: 'ex. Kiosque Mirindra',
              prefixIcon: const Icon(Icons.storefront),
            ),
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? l.t('field_required') : null,
            onChanged: (v) => cubit.setField('nom_commercial', v),
          ),
          const SizedBox(height: 14),
          Text(
            l.t('operators'),
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          for (final op in AppConfig.operateurs)
            CheckboxListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              title: Text(op),
              value: operateurs.contains(op),
              onChanged: (v) {
                final list = operateurs.where((e) => e != op).toList();
                if (v == true) list.add(op);
                cubit.setField('operateurs', list);
              },
            ),
          const SizedBox(height: 8),
          Text(
            l.t('id_type'),
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          // RadioGroup (Flutter >= 3.32) porte la valeur du groupe : les
          // RadioListTile n'ont plus ni groupValue ni onChanged.
          RadioGroup<String>(
            groupValue: (f['type_identification'] ?? '').toString(),
            onChanged: (v) => cubit.setField('type_identification', v ?? ''),
            child: Column(
              children: [
                RadioListTile<String>(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: Text(l.t('id_type_indiv')),
                  value: AppConfig.typeIndividuel,
                ),
                RadioListTile<String>(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: Text(l.t('id_type_franchise')),
                  value: AppConfig.typeFranchise,
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _c('kiosque_longueur'),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: InputDecoration(
                    labelText: l.t('length_label'),
                    prefixIcon: const Icon(Icons.straighten),
                  ),
                  validator: (v) {
                    final val = double.tryParse(v ?? '');
                    if (val == null) return l.t('invalid_number');
                    if (val <= 0) return l.t('must_be_positive');
                    return null;
                  },
                  onChanged: (v) => cubit.setField(
                    'kiosque_longueur',
                    double.tryParse(v) ?? 0,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  controller: _c('kiosque_largeur'),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: InputDecoration(
                    labelText: l.t('width_label'),
                    prefixIcon: const Icon(Icons.straighten),
                  ),
                  validator: (v) {
                    final val = double.tryParse(v ?? '');
                    if (val == null) return l.t('invalid_number');
                    if (val <= 0) return l.t('must_be_positive');
                    return null;
                  },
                  onChanged: (v) => cubit.setField(
                    'kiosque_largeur',
                    double.tryParse(v) ?? 0,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            initialValue: _menu(
              'materiaux_construction',
              AppConfig.materiauxConstructions,
            ),
            decoration: InputDecoration(
              labelText: l.t('materials'),
              prefixIcon: const Icon(Icons.construction),
            ),
            items: AppConfig.materiauxConstructions
                .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                .toList(),
            validator: (v) =>
                (v == null || v.isEmpty) ? l.t('select_materials') : null,
            onChanged: (v) => cubit.setField('materiaux_construction', v ?? ''),
          ),
        ],
      ),
    );
  }

  Widget _step2Form(
    BuildContext context,
    DemandeCubit cubit,
    AppLocalizations l,
  ) {
    final f = cubit.state.fields;
    return Form(
      key: _formKeyStep2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l.t('fokontany_colon', args: [f['fokontany'] ?? '—']),
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _c('emplacement_repere'),
            maxLength: 250,
            minLines: 2,
            maxLines: 3,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              counterText: '',
              labelText: '${l.t('location_hint')} *',
              hintText: 'ex. Akaikin\'ny tetezana Antanifotsy Andrainjato',
              prefixIcon: const Icon(Icons.location_on_outlined),
            ),
            validator: (v) {
              final t = (v ?? '').trim();
              if (t.isEmpty) return l.t('emplacement_required');
              if (t.length < 10) return l.t('emplacement_required');
              return null;
            },
            onChanged: (v) => cubit.setField('emplacement_repere', v),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                // Recapture possible : un relevé GPS erroné (intérieur,
                // position lente) ne doit pas imposer de tout recommencer.
                child: OutlinedButton.icon(
                  onPressed: () => _captureGps(cubit),
                  icon: const Icon(Icons.gps_fixed),
                  label: Text(
                    cubit.state.gpsCaptured
                        ? l.t('gps_captured')
                        : l.t('capture_gps'),
                  ),
                ),
              ),
            ],
          ),
          if (cubit.state.gpsCaptured) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  '${(cubit.state.gpsLat ?? 0).toStringAsFixed(6)}, '
                  '${(cubit.state.gpsLon ?? 0).toStringAsFixed(6)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: () => setState(() => _showMap = !_showMap),
                  icon: Icon(_showMap ? Icons.map_outlined : Icons.map),
                  label: Text(l.t(_showMap ? 'hide_map' : 'show_map')),
                ),
              ],
            ),
            if (cubit.state.geoAllowed == true)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  '✓ ${l.t('location_allowed')}',
                  style: const TextStyle(color: AppTheme.statutVert),
                ),
              ),
            if (cubit.state.geoAllowed == false)
              Container(
                margin: const EdgeInsets.only(top: 6),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppTheme.statutRouge.withValues(alpha: 0.08),
                  border: Border.all(color: AppTheme.statutRouge, width: 1.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.location_off, color: AppTheme.statutRouge),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '${l.t('location_blocked_msg')}\n'
                        '${cubit.state.geoMessage ?? ''}',
                        style: const TextStyle(
                          color: AppTheme.statutRouge,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            // Carte des zones d'exclusion (section 5.3) : affichée automatiquement
            // en cas de blocage, ou à la demande via le bouton « Voir la carte ».
            if (_showMap || cubit.state.geoAllowed == false)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ExclusionZoneMap(
                      latitude: cubit.state.gpsLat ?? 0,
                      longitude: cubit.state.gpsLon ?? 0,
                      zones: cubit.state.zonesInterdites,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      l.t('map_hint'),
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppTheme.statutRouge,
                      ),
                    ),
                  ],
                ),
              ),
          ],
          const SizedBox(height: 16),
          Text(
            l.t('pieces_jointes'),
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: PhotoCaptureField(
                  label: l.t('photo_cin_recto'),
                  path: (f['photo_cin_recto'] ?? '').toString().isEmpty
                      ? null
                      : f['photo_cin_recto'] as String?,
                  onCapture: () => _capturePhoto('photo_cin_recto'),
                  onImport: () => _importPhoto('photo_cin_recto'),
                  onDelete: () => _removePhoto('photo_cin_recto'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: PhotoCaptureField(
                  label: l.t('photo_cin_verso'),
                  path: (f['photo_cin_verso'] ?? '').toString().isEmpty
                      ? null
                      : f['photo_cin_verso'] as String?,
                  onCapture: () => _capturePhoto('photo_cin_verso'),
                  onImport: () => _importPhoto('photo_cin_verso'),
                  onDelete: () => _removePhoto('photo_cin_verso'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          PhotoCaptureField(
            label: '${l.t('photo_location')} (${l.t('mandatory').toLowerCase()})',
            path: (f['photo_emplacement'] ?? '').toString().isEmpty
                ? null
                : f['photo_emplacement'] as String?,
            onCapture: () => _capturePhoto('photo_emplacement'),
            onImport: () => _importPhoto('photo_emplacement'),
            onDelete: () => _removePhoto('photo_emplacement'),
          ),
        ],
      ),
    );
  }

  /// Blocages empêchant l'envoi : liste explicite, affichée sous le bouton
  /// pour éviter qu'un bouton grisé reste incompréhensible.
  List<String> _blocagesSoumission(DemandeCubit cubit, AppLocalizations l) {
    final blocages = <String>[];
    if (!cubit.state.gpsCaptured) {
      blocages.add(l.t('capture_gps'));
    } else if (cubit.state.geoAllowed != true) {
      blocages.add(l.t('forbidden_zone'));
    }
    if ((cubit.state.fields['photo_emplacement'] ?? '').toString().isEmpty) {
      blocages.add(l.t('photo_emplacement_required'));
    }
    final erreurEtape = _erreurEtape1(l);
    if (erreurEtape != null) blocages.add(erreurEtape);
    return blocages;
  }

  Widget _buildSubmit(DemandeCubit cubit) {
    final l = AppLocalizations.of(context);
    final blocages = _blocagesSoumission(cubit, l);
    final allowSubmit = blocages.isEmpty && !cubit.state.submitting;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        FilledButton.icon(
          onPressed: allowSubmit ? () => _soumettre(cubit) : null,
          icon: cubit.state.submitting
              ? const SizedBox(
                  height: 18,
                  width: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : const Icon(Icons.send),
          label: Text(l.t('submit_btn')),
        ),
        if (blocages.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              '${l.t('prerequisites_before_submit')}\n'
              '• ${blocages.join('\n• ')}',
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(color: Colors.grey.shade700),
            ),
          ),
      ],
    );
  }
}

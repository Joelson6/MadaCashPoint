import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/utils/validators.dart';
import '../../shared/widgets/shared_widgets.dart';
import '../bloc/auth_cubit.dart';
import '../bloc/auth_state.dart';

/// Auto-inscription du citoyen (section 4.2) :
/// 1. saisie du numéro → OTP SMS obligatoire,
/// 2. saisie OTP + PIN + identité → création du compte.
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const route = '/register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _phoneCtrl = TextEditingController();
  final _otpCtrl = TextEditingController();
  final _pinCtrl = TextEditingController();
  final _nomCtrl = TextEditingController();
  final _prenomCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _phoneCtrl.dispose();
    _otpCtrl.dispose();
    _pinCtrl.dispose();
    _nomCtrl.dispose();
    _prenomCtrl.dispose();
    super.dispose();
  }

  Future<void> _requestOtp(AuthCubit cubit) async {
    if (!PhoneValidator.isValid(_phoneCtrl.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Numéro invalide (9 chiffres requis)')),
      );
      return;
    }
    await cubit.requestOtp(_phoneCtrl.text);
  }

  Future<void> _create(AuthCubit cubit) async {
    if (!_formKey.currentState!.validate()) return;
    await cubit.registerCitoyen({
      'telephone': _phoneCtrl.text,
      'otp': _otpCtrl.text,
      'pin': _pinCtrl.text,
      'nom': '${_nomCtrl.text.trim()} ${_prenomCtrl.text.trim()}'.trim(),
      'prenom': _prenomCtrl.text.trim(),
    });
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l.t('register_title')),
        actions: const [LanguageSwitchButton()],
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.isAuthenticated) {
            // `/register` a été empilée par-dessus la route `/` (voir
            // `LoginScreen`) : sans ce retour à la racine, l'utilisateur
            // resterait bloqué sur le formulaire d'inscription alors que la
            // session vient d'être créée.
            Navigator.of(context).popUntil((route) => route.isFirst);
            return;
          }
          if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error!),
                backgroundColor: Colors.red.shade700,
              ),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<AuthCubit>();
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Échec de création (OTP refusé, numéro déjà enregistré,
                      // réseau…) : l'erreur est affichée SUR ce formulaire et
                      // l'utilisateur reste sur l'inscription pour corriger.
                      // Aucun retour automatique vers la connexion.
                      if (state.error != null && !state.isAuthenticated) ...[
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.red.shade300),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.error_outline,
                                size: 20,
                                color: Colors.red.shade700,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  state.error!,
                                  style: TextStyle(
                                    color: Colors.red.shade800,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                      TextFormField(
                      controller: _phoneCtrl,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      maxLength: 10,
                      enabled: !state.otpPending,
                      decoration: InputDecoration(
                        labelText: l.t('phone_label'),
                        hintText: l.t('phone_hint'),
                        counterText: '',
                        prefixIcon: const Icon(Icons.phone),
                      ),
                    ),
                    if (!state.otpPending) ...[
                      const SizedBox(height: 8),
                      OutlinedButton.icon(
                        onPressed: state.loading
                            ? null
                            : () => _requestOtp(cubit),
                        icon: const Icon(Icons.sms),
                        label: Text('Recevoir le code SMS'),
                      ),
                    ] else ...[
                      const SizedBox(height: 16),
                      if (state.demoOtp != null)
                        Card(
                          color: Colors.amber.shade50,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              '${l.t('otp_demo')}${state.demoOtp}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.brown,
                              ),
                            ),
                          ),
                        ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _otpCtrl,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        maxLength: 6,
                        decoration: InputDecoration(
                          labelText: l.t('otp_label'),
                          counterText: '',
                          prefixIcon: const Icon(Icons.password),
                        ),
                        validator: (v) =>
                            (v ?? '').length != 6 ? 'Code à 6 chiffres' : null,
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _nomCtrl,
                        textCapitalization: TextCapitalization.words,
                        decoration: const InputDecoration(
                          labelText: 'Nom (selon CIN)',
                          prefixIcon: Icon(Icons.badge),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _prenomCtrl,
                        textCapitalization: TextCapitalization.words,
                        decoration: const InputDecoration(
                          labelText: 'Prénoms',
                          prefixIcon: Icon(Icons.person),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _pinCtrl,
                        obscureText: true,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        maxLength: 6,
                        decoration: InputDecoration(
                          labelText: l.t('new_pin_label'),
                          counterText: '',
                          prefixIcon: const Icon(Icons.lock_outline),
                        ),
                        validator: (v) => PinValidator.isValid(v ?? '')
                            ? null
                            : l.t('mandatory'),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: state.loading ? null : () => _create(cubit),
                        child: Text(l.t('otp_btn')),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

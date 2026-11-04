import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/validators.dart';
import '../../shared/widgets/shared_widgets.dart';
import '../bloc/auth_cubit.dart';
import '../bloc/auth_state.dart';
import 'register_screen.dart';

/// Écran de connexion universelle : numéro de téléphone + PIN (section 4.1).
/// `user_login(phone_number, pin_code)`.
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static const route = '/login';

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final phoneCtrl = TextEditingController();
    final pinCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();

    Future<void> submit(AuthCubit cubit) async {
      if (!formKey.currentState!.validate()) return;
      await cubit.login(phoneCtrl.text, pinCtrl.text);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l.t('app_name')),
        automaticallyImplyLeading: false,
        actions: const [LanguageSwitchButton()],
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.error != null && state.session == null) {
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
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Icon(
                        Icons.account_balance,
                        color: AppTheme.primaryNavy,
                        size: 72,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l.t('kodiac'),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: phoneCtrl,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        maxLength: 10,
                        decoration: InputDecoration(
                          labelText: l.t('phone_label'),
                          hintText: l.t('phone_hint'),
                          counterText: '',
                          prefixIcon: const Icon(Icons.phone),
                        ),
                        validator: (v) => PhoneValidator.isValid(v ?? '')
                            ? null
                            : '10 chiffres requis',
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: pinCtrl,
                        obscureText: true,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        maxLength: 6,
                        decoration: InputDecoration(
                          labelText: l.t('pin_label'),
                          hintText: l.t('pin_hint'),
                          counterText: '',
                          prefixIcon: const Icon(Icons.lock_outline),
                        ),
                        validator: (v) => PinValidator.isValid(v ?? '')
                            ? null
                            : l.t('mandatory'),
                        onFieldSubmitted: (_) => submit(cubit),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: state.loading ? null : () => submit(cubit),
                        child: state.loading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : Text(l.t('login_btn')),
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: state.loading
                            ? null
                            : () =>
                                  Navigator.of(context)
                                      .pushNamed(RegisterScreen.route),
                        child: Text(l.t('register_link')),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

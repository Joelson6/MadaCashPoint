import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/utils/form_rules.dart';
import '../../../core/utils/input_formatters.dart';

/// Champ texte auto-validant et auto-formaté
class AutoTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;
  final IconData? prefixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final int maxLength;
  final bool enabled;
  final TextCapitalization textCapitalization;
  final int maxLines;

  const AutoTextField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.prefixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.maxLength = 250,
    this.enabled = true,
    this.textCapitalization = TextCapitalization.none,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      maxLines: maxLines,
      inputFormatters: [
        if (inputFormatters != null) ...inputFormatters!,
        LengthLimitingTextInputFormatter(maxLength),
      ],
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        counterText: '',
      ),
      validator: validator,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      enabled: enabled,
      textCapitalization: textCapitalization,
    );
  }
}

/// Champ téléphone MG auto-formaté et validé (10 chiffres, préfixes opérateurs)
class AutoPhoneField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const AutoPhoneField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return AutoTextField(
      controller: controller,
      label: label,
      hint: hint ?? '034XXXXXXX',
      prefixIcon: Icons.phone,
      keyboardType: TextInputType.phone,
      inputFormatters: AutoInputFormatters.phoneMg(),
      textCapitalization: TextCapitalization.none,
      maxLength: 10,
      validator: validator ?? (v) => FormRules.phone(v, l),
      onChanged: onChanged,
    );
  }
}

/// Champ PIN auto-formaté (4 ou 6 chiffres)
class AutoPinField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;
  final String? Function(String?)? validator;
  final void Function(String)? onFieldSubmitted;

  const AutoPinField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.validator,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return AutoTextField(
      controller: controller,
      label: label,
      hint: hint ?? '••••',
      prefixIcon: Icons.lock_outline,
      obscureText: true,
      keyboardType: TextInputType.number,
      inputFormatters: AutoInputFormatters.pin(),
      maxLength: 6,
      validator: validator ?? (v) => FormRules.pin(v, l),
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}

/// Champ CIN auto-formaté (12 chiffres uniquement)
class AutoCinField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const AutoCinField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return AutoTextField(
      controller: controller,
      label: label,
      hint: hint ?? '0123456789',
      prefixIcon: Icons.badge,
      keyboardType: TextInputType.number,
      inputFormatters: AutoInputFormatters.cin(),
      textCapitalization: TextCapitalization.none,
      maxLength: 12,
      validator: validator ?? (v) => FormRules.cin(v, l),
      onChanged: onChanged,
    );
  }
}

/// Champ Nom en MAJUSCULES automatique
class AutoNomField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const AutoNomField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return AutoTextField(
      controller: controller,
      label: label,
      hint: hint ?? 'RAKOTO',
      prefixIcon: Icons.person,
      inputFormatters: AutoInputFormatters.nomMajuscules(),
      textCapitalization: TextCapitalization.characters,
      maxLength: 60,
      validator: validator ?? (v) => FormRules.nom(v, l),
      onChanged: onChanged,
    );
  }
}

/// Champ Prénom avec capitalisation automatique (première lettre majuscule)
class AutoPrenomField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const AutoPrenomField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return AutoTextField(
      controller: controller,
      label: label,
      hint: hint ?? 'Jean Paul',
      prefixIcon: Icons.person_outline,
      inputFormatters: AutoInputFormatters.prenom(),
      textCapitalization: TextCapitalization.words,
      maxLength: 60,
      validator: validator ?? (v) => FormRules.prenom(v, l),
      onChanged: onChanged,
    );
  }
}

/// Champ montant Ariary
class AutoAmountField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const AutoAmountField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return AutoTextField(
      controller: controller,
      label: label,
      hint: hint ?? '150000',
      prefixIcon: Icons.payments,
      keyboardType: TextInputType.number,
      inputFormatters: AutoInputFormatters.amount(),
      maxLength: 12,
      validator: validator ?? (v) => FormRules.montantPositif(v, l),
      onChanged: onChanged,
    );
  }
}

/// Champ Date avec sélecteur calendrier automatique
class AutoDateField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final DateTime? initialDate;
  final String? Function(String?)? validator;
  final void Function(DateTime)? onDateSelected;

  const AutoDateField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.firstDate,
    this.lastDate,
    this.initialDate,
    this.validator,
    this.onDateSelected,
  });

  Future<void> _selectDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate ?? now,
      firstDate: firstDate ?? DateTime(1950),
      lastDate: lastDate ?? DateTime(now.year + 10),
      locale: Localizations.localeOf(context),
    );
    if (picked != null) {
      final formatted = '${picked.year.toString().padLeft(4, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
      controller.text = formatted;
      onDateSelected?.call(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return TextFormField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint ?? 'YYYY-MM-DD',
        prefixIcon: const Icon(Icons.event),
        suffixIcon: IconButton(
          icon: const Icon(Icons.calendar_today),
          onPressed: () => _selectDate(context),
        ),
      ),
      validator: validator ?? (v) => FormRules.dateIso(v, l),
      onTap: () => _selectDate(context),
    );
  }
}

/// Dropdown auto-validé
class AutoDropdownField<T> extends StatelessWidget {
  final T? value;
  final String label;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?) onChanged;
  final String? Function(T?)? validator;
  final IconData? prefixIcon;

  const AutoDropdownField({
    super.key,
    required this.value,
    required this.label,
    required this.items,
    required this.onChanged,
    this.validator,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      initialValue: value,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
      ),
      items: items,
      onChanged: onChanged,
      validator: validator,
    );
  }
}

/// Groupe de cases à cocher obligatoires (opérateurs)
class AutoCheckboxGroup extends StatelessWidget {
  final String title;
  final List<String> options;
  final List<String> selected;
  final void Function(String, bool) onToggle;
  final String? errorText;

  const AutoCheckboxGroup({
    super.key,
    required this.title,
    required this.options,
    required this.selected,
    required this.onToggle,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        for (final opt in options)
          CheckboxListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            title: Text(opt),
            value: selected.contains(opt),
            onChanged: (v) => onToggle(opt, v ?? false),
          ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 4),
            child: Text(
              errorText!,
              style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: 12),
            ),
          ),
      ],
    );
  }
}

/// Groupe radio auto-validé
class AutoRadioGroup<T> extends StatelessWidget {
  final String title;
  final T? groupValue;
  final List<RadioOption<T>> options;
  final void Function(T?) onChanged;

  const AutoRadioGroup({
    super.key,
    required this.title,
    required this.groupValue,
    required this.options,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        RadioGroup<T>(
          groupValue: groupValue,
          onChanged: onChanged,
          child: Column(
            children: [
              for (final opt in options)
                RadioListTile<T>(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: Text(opt.label),
                  value: opt.value,
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class RadioOption<T> {
  final T value;
  final String label;
  const RadioOption({required this.value, required this.label});
}

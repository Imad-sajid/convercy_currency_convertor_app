import 'package:Convertify/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class CurrencyInput extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final void Function(String)? onChanged;

  const CurrencyInput({
    super.key,
    required this.label,
    required this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.green,
      controller: controller,
      onChanged: onChanged, // Ensure onChanged is correctly passed
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context).translate('amount_placeholder'),
        labelStyle: const TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      ),
      keyboardType: TextInputType.number,
      style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
    );
  }
}

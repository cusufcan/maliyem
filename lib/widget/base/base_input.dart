import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/base_size.dart';
import 'package:gelir_gider_takibi/constant/base_string.dart';
import 'package:gelir_gider_takibi/model/account.dart';

class BaseInput extends StatelessWidget {
  const BaseInput({
    super.key,
    required this.controller,
    this.label = BaseString.label,
    this.radius = BaseSize.semiMed,
    this.color,
    this.autoFocus = false,
    this.type = TextInputType.text,
    this.action = TextInputAction.done,
    this.maxLength = 20,
    this.isAccount = false,
    this.isAccountEdit = false,
    this.onChanged,
    this.accounts,
    this.editAccount,
  });

  final TextEditingController controller;
  final String label;
  final double radius;
  final Color? color;
  final bool autoFocus;
  final TextInputType type;
  final TextInputAction action;
  final int maxLength;
  final bool isAccount;
  final List<Account>? accounts;
  final bool isAccountEdit;
  final Account? editAccount;
  final void Function(String value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      keyboardType: type,
      textInputAction: action,
      controller: controller,
      autofocus: autoFocus,
      maxLength: maxLength,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return BaseString.emptyInput;
        } else {
          if (isAccount) {
            for (var account in accounts!) {
              if (account.name.toLowerCase() == value.toLowerCase()) {
                return BaseString.accountExist;
              }
            }
          } else if (isAccountEdit) {
            for (var account in accounts!) {
              if (account.name.toLowerCase() == value.toLowerCase() &&
                  editAccount!.name.toLowerCase() != value.toLowerCase()) {
                return BaseString.accountExist;
              }
            }
          }
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(
            color: color ?? Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}

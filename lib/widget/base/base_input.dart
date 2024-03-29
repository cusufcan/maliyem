import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/service/provider/index.dart';
import 'package:provider/provider.dart';

import '../../constant/index.dart';
import '../../model/index.dart';

class BaseInput extends StatelessWidget {
  const BaseInput({
    super.key,
    required this.controller,
    this.label = BaseString.label,
    this.radius = BaseSize.sm,
    this.color,
    this.autoFocus = false,
    this.type = TextInputType.text,
    this.action = TextInputAction.done,
    this.maxLength = 20,
    this.isAccountAdd = false,
    this.isAccountEdit = false,
    this.isCategoryEdit = false,
    this.isCategoryAdd = false,
    this.editCategory,
    this.onChanged,
    this.onTap,
    this.onEditingComplete,
    this.onTapOutside,
    this.editAccount,
    this.prefix,
    this.prefixIcon,
    this.suffix,
    this.suffixIcon,
    this.focusNode,
    this.contentPadding,
  });

  final TextEditingController controller;
  final String label;
  final double radius;
  final Color? color;
  final bool autoFocus;
  final TextInputType type;
  final TextInputAction action;
  final int maxLength;
  final bool isAccountAdd;
  final bool isAccountEdit;
  final Account? editAccount;
  final bool isCategoryEdit;
  final Category? editCategory;
  final bool isCategoryAdd;
  final void Function(String value)? onChanged;
  final void Function()? onTap;
  final void Function()? onEditingComplete;
  final void Function(PointerDownEvent event)? onTapOutside;
  final FocusNode? focusNode;
  final Widget? prefix;
  final Widget? prefixIcon;
  final Widget? suffix;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserModel>(
      builder: (context, value, child) {
        return TextFormField(
          onChanged: onChanged,
          keyboardType: type,
          textInputAction: action,
          controller: controller,
          autofocus: autoFocus,
          maxLength: maxLength,
          onTap: onTap,
          focusNode: focusNode,
          onEditingComplete: onEditingComplete,
          onTapOutside: onTapOutside,
          validator: (text) {
            if (text == null || text.isEmpty) {
              return BaseString.emptyInput;
            } else {
              if (isAccountAdd) {
                for (var account in value.user.accounts!) {
                  if (account.name.toLowerCase() == text.toLowerCase()) {
                    return BaseString.accountExist;
                  }
                }
              } else if (isAccountEdit) {
                for (var account in value.user.accounts!) {
                  if (account.name.toLowerCase() == text.toLowerCase() &&
                      editAccount!.name.toLowerCase() != text.toLowerCase()) {
                    return BaseString.accountExist;
                  }
                }
              }

              if (isCategoryAdd) {
                for (var category in value.user.categories!) {
                  if (category.name.toLowerCase() == text.toLowerCase()) {
                    return BaseString.categoryExist;
                  }
                }
              } else if (isCategoryEdit) {
                for (var category in value.user.categories!) {
                  if (category.name.toLowerCase() == text.toLowerCase() &&
                      editCategory!.name.toLowerCase() != text.toLowerCase()) {
                    return BaseString.categoryExist;
                  }
                }
              }
            }
            return null;
          },
          decoration: InputDecoration(
            prefix: prefix,
            prefixIcon: prefixIcon,
            suffix: suffix,
            suffixIcon: suffixIcon,
            contentPadding: contentPadding,
            labelText: label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide: BorderSide(
                color: color ?? Theme.of(context).primaryColor,
              ),
            ),
          ),
        );
      },
    );
  }
}

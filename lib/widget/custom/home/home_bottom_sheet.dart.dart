import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/base_size.dart';
import 'package:gelir_gider_takibi/constant/base_string.dart';
import 'package:gelir_gider_takibi/constant/enum/shared_enum.dart';
import 'package:gelir_gider_takibi/helper/date_helper.dart';
import 'package:gelir_gider_takibi/helper/input_helper.dart';
import 'package:gelir_gider_takibi/model/account.dart';
import 'package:gelir_gider_takibi/model/category.dart';
import 'package:gelir_gider_takibi/model/user.dart';
import 'package:gelir_gider_takibi/service/shared/shared_manager.dart';
import 'package:gelir_gider_takibi/widget/base/base_elevated_button.dart';
import 'package:gelir_gider_takibi/widget/base/base_height_box.dart';
import 'package:gelir_gider_takibi/widget/base/base_input.dart';
import 'package:gelir_gider_takibi/widget/base/base_text.dart';
import 'package:gelir_gider_takibi/widget/custom/accounts/accounts_bottom_sheet.dart';
import 'package:gelir_gider_takibi/widget/custom/custom_category_bottom_sheet.dart';
import 'package:gelir_gider_takibi/widget/custom/custom_horizontal_list_view.dart';
import 'package:gelir_gider_takibi/widget/custom/custom_scroll_date_picker.dart';

class HomeBottomSheet extends StatefulWidget {
  const HomeBottomSheet({
    super.key,
    required this.sharedManager,
    required this.user,
    required this.onSave,
    required this.amount,
    required this.isIncome,
  });

  final SharedManager sharedManager;
  final User user;
  final void Function(DateTime date, int categoryIdx, int accountIdx) onSave;
  final TextEditingController amount;
  final bool isIncome;

  @override
  State<HomeBottomSheet> createState() => _HomeBottomSheetState();
}

class _HomeBottomSheetState extends State<HomeBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  int categoriesActive = 0;
  int accountsActive = 0;
  DateTime? date;

  @override
  Widget build(BuildContext context) {
    _saveData();
    return Padding(
      padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + BaseSize.med,
            top: BaseSize.semiLg,
          ) +
          const EdgeInsets.symmetric(
            horizontal: BaseSize.med,
          ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            BaseText(
              widget.isIncome ? BaseString.income : BaseString.expense,
              alignment: Alignment.centerLeft,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const BaseHeightBox(height: BaseSize.semiMed),
            BaseInput(
              autoFocus: true,
              maxLength: BaseSize.intMax,
              controller: widget.amount,
              label: BaseString.amount,
              type: TextInputType.number,
              action: TextInputAction.next,
            ),
            const BaseHeightBox(height: BaseSize.semiMed),
            CustomHorizontalListView(
              user: widget.user,
              title: BaseString.account,
              isColor: true,
              visible: widget.user.accounts.isNotEmpty,
              count: widget.user.accounts.length,
              active: accountsActive,
              onTap: _changeAccountActive,
              list: widget.user.accounts,
              onBtnTap: _showAccountSheet,
            ),
            Visibility(
              visible: widget.user.categories.isNotEmpty,
              child: const BaseHeightBox(),
            ),
            CustomHorizontalListView(
              user: widget.user,
              title: BaseString.category,
              visible: widget.user.categories.isNotEmpty,
              count: widget.user.categories.length,
              active: categoriesActive,
              onTap: _changeCategoryActive,
              list: widget.user.categories,
              onBtnTap: _showCategorySheet,
            ),
            const BaseHeightBox(height: BaseSize.semiMed),
            CustomScrollDatePicker(
              date: date,
              onChanged: _onDateChanged,
            ),
            const BaseHeightBox(height: BaseSize.sm),
            BaseElevatedButton(
              onPressed: _bottomSheetOnComplete,
              text: BaseString.add,
            ),
          ],
        ),
      ),
    );
  }

  void _changeAccountActive(int index) {
    accountsActive = index;
    setState(() {});
  }

  void _changeCategoryActive(int index) {
    categoriesActive = index;
    setState(() {});
  }

  void _bottomSheetOnComplete() {
    if (_formKey.currentState!.validate()) {
      widget.onSave(
        clearHour(date ?? DateTime.now()),
        categoriesActive,
        accountsActive,
      );
      clearInputs([widget.amount]);
      date = DateTime.now();
      Navigator.of(context).pop();
    }
  }

  void _showAccountSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return AccountsBottomSheet(
          accounts: widget.user.accounts,
          onSave: (value, colorString) {
            _addAccount(
              Account(
                name: value,
                balance: BaseSize.none,
                monthlyIncome: BaseSize.none,
                monthlyExpense: BaseSize.none,
                color: colorString,
              ),
            );
          },
        );
      },
    );
  }

  void _showCategorySheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return CustomCategoryBottomSheet(
          isCategoryAdd: true,
          user: widget.user,
          onSave: (value) {
            _addCategory(
              Category(name: value),
            );
          },
        );
      },
    );
  }

  _addCategory(Category category) {
    widget.user.categories.add(category);
    setState(() {});
  }

  _addAccount(Account account) {
    widget.user.accounts.add(account);
    setState(() {});
  }

  void _onDateChanged(DateTime value) {
    date = value;
    setState(() {});
  }

  void _saveData() {
    widget.sharedManager.setString(
      SharedEnum.save,
      jsonEncode(widget.user.toJson()),
    );
  }
}

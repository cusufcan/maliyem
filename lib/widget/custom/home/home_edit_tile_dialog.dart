import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/base_color.dart';
import 'package:gelir_gider_takibi/constant/base_size.dart';
import 'package:gelir_gider_takibi/constant/base_string.dart';
import 'package:gelir_gider_takibi/helper/input_helper.dart';
import 'package:gelir_gider_takibi/model/account.dart';
import 'package:gelir_gider_takibi/model/category.dart';
import 'package:gelir_gider_takibi/model/change.dart';
import 'package:gelir_gider_takibi/model/user.dart';
import 'package:gelir_gider_takibi/widget/base/base_elevated_button.dart';
import 'package:gelir_gider_takibi/widget/base/base_height_box.dart';
import 'package:gelir_gider_takibi/widget/base/base_input.dart';
import 'package:gelir_gider_takibi/widget/custom/accounts/accounts_bottom_sheet.dart';
import 'package:gelir_gider_takibi/widget/custom/custom_category_bottom_sheet.dart';
import 'package:gelir_gider_takibi/widget/custom/custom_horizontal_list_view.dart';
import 'package:gelir_gider_takibi/widget/custom/custom_scroll_date_picker.dart';

class HomeEditTileDialog extends StatefulWidget {
  const HomeEditTileDialog({
    super.key,
    required this.change,
    required this.onSave,
    required this.user,
  });

  final User user;
  final Change change;
  final void Function(Change newChange) onSave;

  @override
  State<HomeEditTileDialog> createState() => _HomeEditTileDialogState();
}

class _HomeEditTileDialogState extends State<HomeEditTileDialog> {
  final TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int accountsActive = 0;
  int categoriesActive = 0;

  DateTime date = DateTime.now();

  @override
  void initState() {
    super.initState();
    controller.text = widget.change.amount.toString();
    accountsActive = widget.user.accounts.indexWhere(
      (element) => element.name == widget.change.account,
    );
    categoriesActive = widget.user.categories.indexWhere(
      (element) => element.name == widget.change.category,
    );
    date = DateTime.parse(widget.change.date);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            BaseInput(
              autoFocus: true,
              maxLength: BaseSize.intMax,
              controller: controller,
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
              color: BaseColor.dialog,
            ),
            const BaseHeightBox(height: BaseSize.sm),
            BaseElevatedButton(
              onPressed: _bottomSheetOnComplete,
              text: BaseString.update,
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
      widget.onSave(Change(
        account: widget.user.accounts[accountsActive].name,
        category: widget.user.categories[categoriesActive].name,
        amount: double.parse(controller.text),
        date: date.toString(),
        isIncome: widget.change.isIncome,
      ));
      clearInputs([controller]);
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
}

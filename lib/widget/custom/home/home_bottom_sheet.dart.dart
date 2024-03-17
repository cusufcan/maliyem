import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/base_size.dart';
import 'package:gelir_gider_takibi/constant/base_string.dart';
import 'package:gelir_gider_takibi/helper/date_helper.dart';
import 'package:gelir_gider_takibi/helper/input_helper.dart';
import 'package:gelir_gider_takibi/model/account.dart';
import 'package:gelir_gider_takibi/model/category.dart';
import 'package:gelir_gider_takibi/service/provider/home_sheet_model.dart';
import 'package:gelir_gider_takibi/service/provider/user_model.dart';
import 'package:gelir_gider_takibi/widget/base/base_elevated_button.dart';
import 'package:gelir_gider_takibi/widget/base/base_height_box.dart';
import 'package:gelir_gider_takibi/widget/base/base_input.dart';
import 'package:gelir_gider_takibi/widget/base/base_text.dart';
import 'package:gelir_gider_takibi/widget/custom/accounts/accounts_bottom_sheet.dart';
import 'package:gelir_gider_takibi/widget/custom/custom_category_bottom_sheet.dart';
import 'package:gelir_gider_takibi/widget/custom/custom_horizontal_list_view.dart';
import 'package:gelir_gider_takibi/widget/custom/custom_scroll_date_picker.dart';
import 'package:provider/provider.dart';

class HomeBottomSheet extends StatefulWidget {
  const HomeBottomSheet({
    super.key,
    required this.onSave,
    required this.amount,
    required this.isIncome,
  });

  final void Function(DateTime date, int categoryIdx, int accountIdx) onSave;
  final TextEditingController amount;
  final bool isIncome;

  @override
  State<HomeBottomSheet> createState() => _HomeBottomSheetState();
}

class _HomeBottomSheetState extends State<HomeBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<UserModel>(
      builder: (context, value, child) {
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
                  prefix: const Text("${BaseString.tl} "),
                  type: TextInputType.number,
                  action: TextInputAction.next,
                ),
                const BaseHeightBox(height: BaseSize.semiMed),
                Consumer<HomeSheetModel>(
                  builder: (context, homeSheetModel, child) {
                    return CustomHorizontalListView(
                      title: BaseString.account,
                      isColor: true,
                      visible: value.user.accounts!.isNotEmpty,
                      count: value.user.accounts!.length,
                      active: homeSheetModel.accountsActive,
                      onTap: homeSheetModel.changeAccountActive,
                      list: value.user.accounts!,
                      onBtnTap: _showAccountSheet,
                    );
                  },
                ),
                Visibility(
                  visible: value.user.categories!.isNotEmpty,
                  child: const BaseHeightBox(),
                ),
                Consumer<HomeSheetModel>(
                  builder: (context, homeSheetModel, child) {
                    return CustomHorizontalListView(
                      title: BaseString.category,
                      visible: value.user.categories!.isNotEmpty,
                      count: value.user.categories!.length,
                      active: homeSheetModel.categoriesActive,
                      onTap: homeSheetModel.changeCategoryActive,
                      list: value.user.categories!,
                      onBtnTap: _showCategorySheet,
                    );
                  },
                ),
                const BaseHeightBox(height: BaseSize.semiMed),
                Consumer<HomeSheetModel>(
                  builder: (context, homeSheetModel, child) {
                    return CustomScrollDatePicker(
                      date: homeSheetModel.date,
                      onChanged: (date) => homeSheetModel.changeDate(date),
                    );
                  },
                ),
                const BaseHeightBox(height: BaseSize.sm),
                Consumer<HomeSheetModel>(
                  builder: (context, homeSheetModel, child) {
                    return BaseElevatedButton(
                      onPressed: () {
                        _bottomSheetOnComplete(
                          homeSheetModel.date,
                          homeSheetModel.accountsActive,
                          homeSheetModel.categoriesActive,
                        );
                        homeSheetModel.clearValues();
                      },
                      text: BaseString.add,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _bottomSheetOnComplete(
    DateTime date,
    int accountsActive,
    int categoriesActive,
  ) {
    if (_formKey.currentState!.validate()) {
      widget.onSave(
        clearHour(date),
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
      useSafeArea: true,
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Consumer<UserModel>(
          builder: (context, value, child) {
            return AccountsBottomSheet(
              onAccountSave: (name, amount, colorString) {
                value.addAccount(
                  Account(
                    name: name,
                    balance: double.parse(amount),
                    monthlyIncome: BaseSize.none,
                    monthlyExpense: BaseSize.none,
                    color: colorString,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  void _showCategorySheet() {
    showModalBottomSheet(
      useSafeArea: true,
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Consumer<UserModel>(
          builder: (context, value, child) {
            return CustomCategoryBottomSheet(
              isCategoryAdd: true,
              onSave: (name) {
                value.addCategory(
                  Category(name: name),
                );
              },
            );
          },
        );
      },
    );
  }
}

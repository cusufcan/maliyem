import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/base_color.dart';
import 'package:gelir_gider_takibi/constant/base_size.dart';
import 'package:gelir_gider_takibi/constant/base_string.dart';
import 'package:gelir_gider_takibi/helper/input_helper.dart';
import 'package:gelir_gider_takibi/model/account.dart';
import 'package:gelir_gider_takibi/model/category.dart';
import 'package:gelir_gider_takibi/model/change.dart';
import 'package:gelir_gider_takibi/model/user.dart';
import 'package:gelir_gider_takibi/service/provider/index.dart';
import 'package:gelir_gider_takibi/widget/base/base_elevated_button.dart';
import 'package:gelir_gider_takibi/widget/base/base_height_box.dart';
import 'package:gelir_gider_takibi/widget/base/base_input.dart';
import 'package:gelir_gider_takibi/widget/custom/accounts/accounts_bottom_sheet.dart';
import 'package:gelir_gider_takibi/widget/custom/custom_category_bottom_sheet.dart';
import 'package:gelir_gider_takibi/widget/custom/custom_horizontal_list_view.dart';
import 'package:gelir_gider_takibi/widget/custom/custom_scroll_date_picker.dart';
import 'package:provider/provider.dart';

class HomeEditTileDialog extends StatefulWidget {
  const HomeEditTileDialog({
    super.key,
    required this.change,
    required this.onSave,
  });

  final Change change;
  final void Function(Change newChange) onSave;

  @override
  State<HomeEditTileDialog> createState() => _HomeEditTileDialogState();
}

class _HomeEditTileDialogState extends State<HomeEditTileDialog> {
  final TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    controller.text = widget.change.amount.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserModel>(
      builder: (context, value, child) {
        Future.delayed(Duration.zero).whenComplete(
          () => Provider.of<HomeDialogModel>(
            context,
            listen: false,
          ).changeDate(
            DateTime.parse(widget.change.date),
          ),
        );

        Future.delayed(Duration.zero).whenComplete(
          () => Provider.of<HomeDialogModel>(
            context,
            listen: false,
          ).changeAccountActive(
            value.user.accounts!.indexWhere(
              (element) => element.name == widget.change.account,
            ),
          ),
        );

        Future.delayed(Duration.zero).whenComplete(
          () => Provider.of<HomeDialogModel>(
            context,
            listen: false,
          ).changeCategoryActive(
            value.user.categories!.indexWhere(
              (element) => element.name == widget.change.category,
            ),
          ),
        );

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
                Consumer<HomeDialogModel>(
                  builder: (context, homeDialogModel, child) {
                    return CustomHorizontalListView(
                      title: BaseString.account,
                      isColor: true,
                      count: value.user.accounts!.length,
                      active: homeDialogModel.accountsActive,
                      onTap: (i) => homeDialogModel.changeAccountActive(i),
                      list: value.user.accounts!,
                      onBtnTap: _showAccountSheet,
                    );
                  },
                ),
                Visibility(
                  visible: value.user.categories!.isNotEmpty,
                  child: const BaseHeightBox(),
                ),
                Consumer<HomeDialogModel>(
                  builder: (context, homeDialogModel, child) {
                    return CustomHorizontalListView(
                      title: BaseString.category,
                      count: value.user.categories!.length,
                      active: homeDialogModel.categoriesActive,
                      onTap: (i) => homeDialogModel.changeCategoryActive(i),
                      list: value.user.categories!,
                      onBtnTap: _showCategorySheet,
                    );
                  },
                ),
                const BaseHeightBox(height: BaseSize.semiMed),
                Consumer<HomeDialogModel>(
                  builder: (context, homeDialogModel, child) {
                    return CustomScrollDatePicker(
                      date: homeDialogModel.date,
                      onChanged: (date) => homeDialogModel.changeDate(date),
                      color: MediaQuery.of(context).platformBrightness !=
                              Brightness.dark
                          ? BaseColor.dialog
                          : null,
                    );
                  },
                ),
                const BaseHeightBox(height: BaseSize.sm),
                Consumer<HomeDialogModel>(
                  builder: (context, homeDialogModel, child) {
                    return BaseElevatedButton(
                      onPressed: () {
                        _bottomSheetOnComplete(
                          value.user,
                          homeDialogModel.accountsActive,
                          homeDialogModel.categoriesActive,
                          homeDialogModel.date,
                        );
                        homeDialogModel.clearValues();
                      },
                      text: BaseString.update,
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
    User user,
    int accountsActive,
    int categoriesActive,
    DateTime date,
  ) {
    if (_formKey.currentState!.validate()) {
      widget.onSave(
        Change(
          account: user.accounts![accountsActive].name,
          category: user.categories![categoriesActive].name,
          amount: double.parse(controller.text.trim()),
          date: date.toString(),
          isIncome: widget.change.isIncome,
        ),
      );
      clearInputs([controller]);
      date = DateTime.now();
      Navigator.of(context).pop();
    }
  }

  void _showAccountSheet() {
    showModalBottomSheet(
      useSafeArea: true,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(BaseSize.semiMed),
          topRight: Radius.circular(BaseSize.semiMed),
        ),
      ),
      builder: (context) {
        return Consumer<UserModel>(
          builder: (context, value, child) {
            return AccountsBottomSheet(
              onAccountSave: (name, amount, colorString) {
                value.addAccount(
                  Account(
                    name: name,
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
      },
    );
  }

  void _showCategorySheet() {
    showModalBottomSheet(
      useSafeArea: true,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(BaseSize.semiMed),
          topRight: Radius.circular(BaseSize.semiMed),
        ),
      ),
      builder: (context) {
        return Consumer<UserModel>(
          builder: (context, value, child) {
            return CustomCategoryBottomSheet(
              onSave: (name) {
                value.addCategory(Category(name: name));
              },
            );
          },
        );
      },
    );
  }
}

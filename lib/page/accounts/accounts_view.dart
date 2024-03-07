import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/enum/shared_enum.dart';
import 'package:gelir_gider_takibi/service/shared/shared_manager.dart';

import '../../constant/index.dart';
import '../../helper/index.dart';
import '../../model/index.dart';
import '../../widget/base/index.dart';
import '../../widget/custom/accounts/index.dart';

part 'accounts_view_model.dart';

class AccountsView extends StatefulWidget {
  const AccountsView({
    Key? key,
    required this.sharedManager,
    required this.user,
    required this.accounts,
  }) : super(key: key);

  final SharedManager sharedManager;
  final User user;
  final List<Account> accounts;

  @override
  State<AccountsView> createState() => _AccountsViewState();
}

class _AccountsViewState extends _AccountsViewModel {
  @override
  Widget build(BuildContext context) {
    _saveData();
    return Scaffold(
      appBar: AccountsAppBar(
        sharedManager: widget.sharedManager,
        user: widget.user,
      ),
      body: SingleChildScrollView(
        padding: BasePadding.home,
        physics: BasePhysics.base,
        key: BaseKey.accounts,
        child: Form(
          key: _formKey,
          child: ListView.builder(
            itemCount: widget.accounts.length,
            physics: BasePhysics.base,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return AccountsListTile(
                account: widget.accounts[index],
                onLongPress: () => _openEditDialog(index),
                onDelete: widget.accounts.length > 1 &&
                        !isAccountsHaveChange(
                            widget.user, widget.accounts[index])
                    ? () => _openDeleteDialog(index)
                    : null,
              );
            },
          ),
        ),
      ),
    );
  }
}

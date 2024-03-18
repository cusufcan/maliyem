import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/service/provider/user_model.dart';
import 'package:provider/provider.dart';

import '../../constant/index.dart';
import '../../helper/index.dart';
import '../../widget/base/index.dart';
import '../../widget/custom/accounts/index.dart';

part 'accounts_view_model.dart';

class AccountsView extends StatefulWidget {
  const AccountsView({
    Key? key,
  }) : super(key: key);

  @override
  State<AccountsView> createState() => _AccountsViewState();
}

class _AccountsViewState extends _AccountsViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const ValueKey(BaseKey.accounts),
      appBar: const AccountsAppBar(),
      body: Consumer<UserModel>(
        builder: (context, value, child) {
          return ListView.builder(
            padding: BasePadding.home,
            itemCount: value.user.accounts!.length,
            physics: BasePhysics.base,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return AccountsListTile(
                account: value.user.accounts![index],
                onLongPress: () => _openEditDialog(index),
                onDelete: value.user.accounts!.length > 1 &&
                        !isAccountsHaveChange(
                            value.user, value.user.accounts![index])
                    ? () => _openDeleteDialog(index)
                    : null,
              );
            },
          );
        },
      ),
    );
  }
}

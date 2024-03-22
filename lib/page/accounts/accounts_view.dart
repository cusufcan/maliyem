import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/service/provider/index.dart';
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

class _AccountsViewState extends _AccountsViewModel
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<UserModel>(
      builder: (context, value, child) {
        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: BasePadding.home,
          itemCount: value.user.accounts!.length,
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
    );
  }

  @override
  bool get wantKeepAlive => true;
}

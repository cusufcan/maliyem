import 'package:flutter/material.dart';

import 'index.dart';

class BaseIcon {
  static const income = Icon(Icons.file_download_outlined);
  static const expense = Icon(Icons.file_upload_outlined);

  static const incomeWhite = Icon(
    Icons.file_download_outlined,
    color: BaseColor.white,
  );
  static const expenseWhite = Icon(
    Icons.file_upload_outlined,
    color: BaseColor.white,
  );

  static const home = Icon(Icons.home);
  static const homeOutlined = Icon(Icons.home_outlined);

  static const wallet = Icon(Icons.account_balance_wallet);
  static const walletOutlined = Icon(Icons.account_balance_wallet_outlined);

  static const add = Icon(Icons.add);
  static const remove = Icon(Icons.remove);

  static const category = Icon(Icons.category_outlined);
  static const graph = Icon(Icons.bar_chart_outlined);
}

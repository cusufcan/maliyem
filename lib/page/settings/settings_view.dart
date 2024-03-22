import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/index.dart';
import 'package:gelir_gider_takibi/service/provider/index.dart';
import 'package:gelir_gider_takibi/service/provider/settings_model.dart';
import 'package:gelir_gider_takibi/widget/base/index.dart';
import 'package:gelir_gider_takibi/widget/custom/settings/settings_appbar.dart';
import 'package:provider/provider.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SettingsAppBar(),
      body: Consumer<SettingsModel>(
        builder: (context, settingsModel, child) {
          return ListView(
            padding: BasePadding.home,
            children: [
              ListTile(
                title: const Text('Karanlık Tema'),
                trailing: Switch(
                  value: settingsModel.isDarkMode,
                  // onChanged: (value) => settingsModel.changeTheme(value),
                  onChanged: (value) {},
                ),
              ),
              BaseElevatedButton(
                text: 'Verileri Temizle',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => BaseAlertDialog(
                      title: BaseString.sureAboutDeleteTitle,
                      desc: BaseString.sureAboutDeleteDesc,
                      onPressed: () {
                        final manager =
                            Provider.of<UserModel>(context, listen: false)
                                .sharedManager;
                        settingsModel.clearAllData(context, manager);
                        Navigator.of(context).pop();

                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(BaseSize.sm),
                            ),
                            title: const Text(BaseString.successs),
                            content: const Text(BaseString.allDataDeleted),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text(
                                  BaseString.close,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

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
        builder: (ctx, settings, child) {
          settings.controller.text =
              Provider.of<UserModel>(ctx, listen: false).user.name;
          return Padding(
            padding: BasePadding.home,
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      BaseInput(
                        controller: settings.controller,
                        label: BaseString.username,
                        prefixIcon: BaseIcon.user,
                        focusNode: settings.focusNode,
                        onTap: () => settings.addFocus(),
                        onEditingComplete: () {
                          settings.clearFocus(context);
                          settings.changeUserName(context);
                        },
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: BaseSize.sm),
                          child: IconButton(
                            onPressed: () => settings.iconOnClick(ctx),
                            icon: settings.focusNode.hasFocus
                                ? BaseIcon.ok
                                : BaseIcon.edit,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                BaseElevatedButton(
                  text: BaseString.deleteData,
                  backgroundColor: BaseColor.expense,
                  onPressed: () {
                    showDialog(
                      context: ctx,
                      builder: (context) => BaseAlertDialog(
                        title: BaseString.sureAboutDeleteTitle,
                        desc: BaseString.sureAboutDeleteDesc,
                        onPressed: () {
                          final manager =
                              Provider.of<UserModel>(context, listen: false)
                                  .sharedManager;
                          settings.clearAllData(context, manager);
                          Navigator.of(context).pop();

                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(BaseSize.sm),
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
                const BaseHeightBox(),
              ],
            ),
          );
        },
      ),
    );
  }
}

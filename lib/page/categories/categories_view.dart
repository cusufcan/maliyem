import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/base_key.dart';
import 'package:gelir_gider_takibi/constant/base_padding.dart';
import 'package:gelir_gider_takibi/constant/base_physics.dart';
import 'package:gelir_gider_takibi/constant/base_size.dart';
import 'package:gelir_gider_takibi/constant/base_string.dart';
import 'package:gelir_gider_takibi/constant/enum/shared_enum.dart';
import 'package:gelir_gider_takibi/helper/account_helper.dart';
import 'package:gelir_gider_takibi/model/category.dart';
import 'package:gelir_gider_takibi/model/user.dart';
import 'package:gelir_gider_takibi/service/shared/shared_manager.dart';
import 'package:gelir_gider_takibi/widget/base/base_alert_dialog.dart';
import 'package:gelir_gider_takibi/widget/base/base_text.dart';
import 'package:gelir_gider_takibi/widget/custom/categories/categories_appbar.dart';
import 'package:gelir_gider_takibi/widget/custom/categories/categories_edit_tile_dialog.dart';
import 'package:gelir_gider_takibi/widget/custom/categories/categories_list_tile.dart';

part 'categories_view_model.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({
    Key? key,
    required this.sharedManager,
    required this.user,
    required this.categories,
  }) : super(key: key);

  final SharedManager sharedManager;
  final User user;
  final List<Category> categories;

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends CategoriesViewModel {
  @override
  Widget build(BuildContext context) {
    _saveData();
    return Scaffold(
      appBar: const CategoriesAppBar(),
      body: SingleChildScrollView(
        padding: BasePadding.home,
        physics: BasePhysics.base,
        key: BaseKey.accounts,
        child: Form(
          key: _formKey,
          child: ListView.builder(
            itemCount: widget.categories.length,
            physics: BasePhysics.base,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return CategoriesListTile(
                category: widget.categories[index],
                onTap: () => _openEditDialog(index),
                onDelete: widget.categories.length > 1 &&
                        !isCategoryHaveChange(
                            widget.user, widget.categories[index])
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

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/enum/shared_enum.dart';
import 'package:gelir_gider_takibi/service/shared/shared_manager.dart';

import '../../constant/index.dart';
import '../../helper/index.dart';
import '../../model/index.dart';
import '../../widget/base/index.dart';
import '../../widget/custom/categories/index.dart';
import '../../widget/custom/index.dart';

part 'categories_view_model.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({
    Key? key,
    required this.sharedManager,
    required this.user,
  }) : super(key: key);

  final SharedManager sharedManager;
  final User user;

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends _CategoriesViewModel {
  @override
  Widget build(BuildContext context) {
    _saveData();
    return Scaffold(
      appBar: const CategoriesAppBar(),
      floatingActionButton: CategoriesFab(
        addCategory: _openAddDialog,
      ),
      body: SingleChildScrollView(
        padding: BasePadding.home,
        physics: BasePhysics.base,
        key: BaseKey.accounts,
        child: Form(
          key: _formKey,
          child: ListView.builder(
            itemCount: widget.user.categories.length,
            physics: BasePhysics.base,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return CategoriesListTile(
                category: widget.user.categories[index],
                onLongPress: () => _openEditDialog(index),
                onDelete: widget.user.categories.length > 1 &&
                        !isCategoryHaveChange(
                            widget.user, widget.user.categories[index])
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

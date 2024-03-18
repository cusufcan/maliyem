import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/service/provider/index.dart';
import 'package:provider/provider.dart';

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
  }) : super(key: key);

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends _CategoriesViewModel {
  @override
  Widget build(BuildContext context) {
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
          child: Consumer<UserModel>(
            builder: (context, value, child) {
              return ListView.builder(
                itemCount: value.user.categories!.length,
                physics: BasePhysics.base,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return CategoriesListTile(
                    category: value.user.categories![index],
                    onLongPress: () => _openEditDialog(index),
                    onDelete: value.user.categories!.length > 1 &&
                            !isCategoryHaveChange(
                                value.user, value.user.categories![index])
                        ? () => _openDeleteDialog(index)
                        : null,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

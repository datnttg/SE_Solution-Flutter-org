import 'package:flutter/material.dart';
import 'package:se_solution/screens/product/product_filter_screen/bloc/product_filter_bloc.dart';

import '../../../../utilities/shared_preferences.dart';
import '../../../../utilities/ui_styles.dart';
import '../models/product_filter_item_model.dart';
import 'product_list_item.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key, required this.list, required this.bloc});
  final ProductFilterBloc bloc;
  final List<ProductFilterItemModel> list;

  @override
  Widget build(BuildContext context) {
    if (list.isEmpty) {
      return Center(
        child: SelectableText('(${sharedPrefs.translate('Empty list')})'),
      );
    } else {
      return Container(
        padding: const EdgeInsets.only(top: defaultPadding / 2),
        color: kBgColor,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: list.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(
                    left: defaultPadding, right: defaultPadding),
                child: Container(
                  decoration: BoxDecoration(
                      color: index.isEven ? kBgColorRow1 : null,
                      borderRadius: BorderRadius.circular(defaultRadius)),

                  /// PRODUCT ITEM
                  child: ProductListItem(bloc: bloc, dataItem: list[index]),
                ),
              );
            }),
      );
    }
  }
}

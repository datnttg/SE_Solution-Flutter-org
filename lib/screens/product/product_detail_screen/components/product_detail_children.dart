import 'package:flutter/material.dart';

import '../../../../utilities/ui_styles.dart';
import '../bloc/product_detail_bloc.dart';
import 'product_detail_children_item.dart';

class ProductDetailChildren extends StatelessWidget {
  final ProductDetailBloc bloc;
  const ProductDetailChildren({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBgColor,
      constraints: const BoxConstraints(maxHeight: 360),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: 1,
          itemBuilder: (context, index) {
            return ProductDetailChildrenItem(
              bloc: bloc,
              itemIndex: index,
            );
          }),
    );
  }
}

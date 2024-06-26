import 'package:flutter/material.dart';

import '../../../../utilities/ui_styles.dart';
import '../bloc/product_detail_bloc.dart';
import 'product_detail_children_item.dart';

class ProductDetailChildren extends StatelessWidget {
  final ProductDetailBloc bloc;
  const ProductDetailChildren({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    var a = (bloc.data.children?.isEmpty ?? false);
    var b = !(bloc.data.children?.any((e) => e.childId == null) ?? true);
    var c = bloc.data.children;
    if ((bloc.data.children?.isEmpty ?? false) &&
        !(bloc.data.children?.any((e) => e.childId == null) ?? true)) {
      bloc.data.children?.add(bloc.blankChild);
    }
    return Container(
      color: kBgColor,
      constraints: const BoxConstraints(maxHeight: 360),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: bloc.data.children?.length,
          itemBuilder: (context, index) {
            return ProductDetailChildrenItem(
              bloc: bloc,
              itemIndex: index,
            );
          }),
    );
  }
}

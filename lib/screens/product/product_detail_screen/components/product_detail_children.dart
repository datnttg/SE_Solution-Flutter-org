import 'package:flutter/material.dart';
import 'package:se_solution/utilities/enums/ui_enums.dart';

import '../../../../utilities/ui_styles.dart';
import '../bloc/product_detail_bloc.dart';
import '../models/child_product_model.dart';
import '../models/product_detail_model.dart';
import 'product_detail_children_item.dart';

class ProductDetailChildren extends StatelessWidget {
  final ProductDetailBloc bloc;
  final List<ChildProductModel>? childProducts;

  const ProductDetailChildren(
      {super.key, required this.bloc, this.childProducts});

  @override
  Widget build(BuildContext context) {
    bloc.data.children = childProducts;

    return StreamBuilder<ProductDetailModel>(
      stream: bloc.dataController.stream,
      builder: (context, snapshot) {
        bloc.data.children?.where((e) => e.childId?.isEmpty ?? true).length;
        if ((bloc.screenMode.state == ScreenModeEnum.edit) &&
            (bloc.data.children
                        ?.where((e) => e.childId?.isEmpty ?? true)
                        .length ??
                    0) ==
                0) {
          bloc.data.children?.add(ChildProductModel());
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
      },
    );
  }
}

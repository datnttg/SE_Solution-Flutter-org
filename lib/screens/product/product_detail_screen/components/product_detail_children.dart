import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se_solution/screens/product/product_detail_screen/bloc/product_detail_states.dart';
import 'package:se_solution/utilities/enums/ui_enums.dart';

import '../../../../utilities/ui_styles.dart';
import '../bloc/product_detail_bloc.dart';
import '../models/child_product_model.dart';
import 'product_detail_children_item.dart';

class ProductDetailChildren extends StatelessWidget {
  const ProductDetailChildren({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailBloc, ProductDetailState>(
      builder: (context, state) {
        if ((state.screenMode == ScreenModeEnum.edit) &&
            (state.productDetail.children
                        ?.where((e) => e.childId?.isEmpty ?? true)
                        .length ??
                    0) ==
                0) {
          state.productDetail.children?.add(ChildProductModel());
        }
        return Container(
          color: kBgColor,
          constraints: const BoxConstraints(maxHeight: 360),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: state.productDetail.children?.length,
              itemBuilder: (context, index) {
                return ProductDetailChildrenItem(itemIndex: index);
              }),
        );
      },
    );
  }
}

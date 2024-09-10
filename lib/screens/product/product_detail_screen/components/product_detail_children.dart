import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utilities/enums/ui_enums.dart';
import '../bloc/product_detail_bloc.dart';
import '../bloc/product_detail_states.dart';
import '../models/product_update_model.dart';
import 'product_detail_children_item.dart';

class ProductDetailChildren extends StatelessWidget {
  const ProductDetailChildren({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailBloc, ProductDetailState>(
      builder: (context, state) {
        var children = state.productUpdate.children;
        if ((state.screenMode == ScreenModeEnum.edit) &&
            (children?.where((e) => e.childId?.isEmpty ?? true).length ?? 0) ==
                0 &&
            !(children?.any((e) => e.quantityOfChild == 0) ?? true)) {
          state.productUpdate.children?.add(ChildProductUpdateModel());
        }
        return ListView.builder(
            shrinkWrap: true,
            itemCount: state.productUpdate.children?.length,
            itemBuilder: (context, index) {
              return ProductDetailChildrenItem(itemIndex: index);
            });
      },
    );
  }
}

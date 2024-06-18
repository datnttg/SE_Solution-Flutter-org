import 'package:flutter/material.dart';

import '../../../../utilities/ui_styles.dart';
import '../bloc/product_detail_bloc.dart';
import '../models/product_detail_model.dart';

class ProductDetailChildren extends StatelessWidget {
  final List<ProductDetailModel>? childProducts;
  final ProductDetailBloc bloc;
  const ProductDetailChildren(
      {super.key, this.childProducts, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBgColor,
      constraints: const BoxConstraints(maxHeight: 360),
      child: SizedBox(
        child: SingleChildScrollView(
          child: Container(
            height: 500,
          ),
        ),
      ),
    );
  }
}

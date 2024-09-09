import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utilities/custom_widgets.dart';
import '../../../utilities/shared_preferences.dart';
import 'bloc/product_detail_bloc.dart';
import 'bloc/product_detail_states.dart';
import 'components/product_detail_form.dart';
import 'components/product_detail_children.dart';

class ProductDetailBody extends StatelessWidget {
  const ProductDetailBody({super.key});

  @override
  Widget build(BuildContext context) {
    /// RETURN
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const CGroup(
                  /// PRODUCT DETAIL
                  child: ProductDetailForm(),
                ),
                BlocBuilder<ProductDetailBloc, ProductDetailState>(
                    builder: (context, state) {
                  if (state.productDetail.typeCode == 'BundleProduct') {
                    return CGroup(
                      titleText: sharedPref.translate('Elements'),

                      /// CHILD PRODUCTS
                      child: const ProductDetailChildren(),
                    );
                  } else {
                    return const SizedBox();
                  }
                })
              ],
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se_solution/screens/product/product_detail_screen/bloc/product_detail_bloc.dart';
import 'package:se_solution/screens/product/product_detail_screen/bloc/product_detail_events.dart';
import 'package:se_solution/screens/product/product_detail_screen/bloc/product_detail_states.dart';

import '../../../utilities/custom_widgets.dart';
import '../../../utilities/responsive.dart';
import '../../../utilities/shared_preferences.dart';
import '../../../utilities/ui_styles.dart';
import 'components/product_detail_action_buttons.dart';
import 'components/product_detail_form.dart';
import 'components/product_detail_children.dart';

class ProductDetailBody extends StatefulWidget {
  const ProductDetailBody({super.key, this.productId});

  final String? productId;

  @override
  State<ProductDetailBody> createState() => _ProductDetailBodyState();
}

class _ProductDetailBodyState extends State<ProductDetailBody> {
  @override
  void initState() {
    context
        .read<ProductDetailBloc>()
        .add(InitProductDetailData(productId: widget.productId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// RETURN
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    left: defaultPadding * 2,
                    right: defaultPadding * 2,
                  ),
                  color: kBgColor,

                  /// PRODUCT DETAIL
                  child: ProductDetailForm(),
                ),
                const SizedBox(height: defaultPadding * 2),

                /// CHILD PRODUCTS
                BlocBuilder<ProductDetailBloc, ProductDetailState>(
                    builder: (context, state) {
                  if (state.productDetail.typeCode == 'BundleProduct') {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// TEXT: CHILD
                        Padding(
                          padding: const EdgeInsets.all(defaultPadding),
                          child: CText(
                            sharedPrefs.translate('Elements'),
                            style: const TextStyle(
                                fontSize: largeTextSize,
                                fontWeight: FontWeight.bold),
                          ),
                        ),

                        /// LIST: CHILD
                        Container(
                          color: kBgColor,
                          child: const ProductDetailChildren(),
                        ),
                      ],
                    );
                  } else {
                    return const SizedBox();
                  }
                })
              ],
            ),
          ),
        ),
        !Responsive.isMobileAndPortrait(context)
            ? const SizedBox()
            : Container(
                width: double.infinity,
                color: cAppBarColor,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /// BOTTOM BUTTONS
                    SaveProductButton(),
                    UpdateProductButton(),
                    DiscardProductButton(),
                  ],
                ),
              ),
      ],
    );
  }
}

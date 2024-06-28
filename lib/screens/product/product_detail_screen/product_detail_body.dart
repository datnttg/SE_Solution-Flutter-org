import 'package:flutter/material.dart';

import '../../../utilities/custom_widgets.dart';
import '../../../utilities/responsive.dart';
import '../../../utilities/shared_preferences.dart';
import '../../../utilities/ui_styles.dart';
import 'bloc/product_detail_bloc.dart';
import 'bloc/product_detail_states.dart';
import 'components/product_detail_action_buttons.dart';
import 'components/product_detail_form.dart';
import 'components/product_detail_children.dart';

class ProductDetailBody extends StatelessWidget {
  const ProductDetailBody({super.key, this.productId, required this.bloc});
  final String? productId;
  final ProductDetailBloc bloc;

  @override
  Widget build(BuildContext context) {
    /// RETURN
    return StreamBuilder<ScreenModeState>(
        stream: bloc.uiController.stream,
        builder: (context, snapshot) {
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
                        child: ProductDetailForm(bloc: bloc),
                      ),
                      const SizedBox(height: defaultPadding * 2),

                      /// CHILD PRODUCTS
                      bloc.data.typeCode == 'BundleProduct'
                          ? Column(
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
                                  // padding: const EdgeInsets.all(defaultPadding * 2),
                                  color: kBgColor,
                                  child: ProductDetailChildren(bloc: bloc),
                                ),
                              ],
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
              ),
              !Responsive.isPortrait(context)
                  ? const SizedBox()
                  : Container(
                      width: double.infinity,
                      color: cAppBarColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          /// BOTTOM BUTTONS
                          SaveProductButton(bloc: bloc),
                          UpdateProductButton(bloc: bloc),
                          const DiscardProductButton(),
                        ],
                      ),
                    ),
            ],
          );
        });
  }
}

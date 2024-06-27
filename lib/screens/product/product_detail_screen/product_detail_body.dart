import 'package:flutter/material.dart';

import '../../../utilities/custom_widgets.dart';
import '../../../utilities/enums/ui_enums.dart';
import '../../../utilities/responsive.dart';
import '../../../utilities/shared_preferences.dart';
import '../../../utilities/ui_styles.dart';
import 'bloc/product_detail_bloc.dart';
import 'bloc/product_detail_events.dart';
import 'components/product_detail_action_buttons.dart';
import 'components/product_detail_form.dart';
import 'components/product_detail_children.dart';
import 'models/product_detail_model.dart';
import 'services/fetch_data_service.dart';

class ProductDetailBody extends StatefulWidget {
  const ProductDetailBody({super.key, required this.bloc, this.productId});
  final ProductDetailBloc bloc;
  final String? productId;

  @override
  State<ProductDetailBody> createState() => _ProductDetailBodyState();
}

class _ProductDetailBodyState extends State<ProductDetailBody> {
  Future<void> loadData(String? productId) async {
    var productDetailModel = ProductDetailModel();
    if (productId != null) {
      var productDetail = await fetchProductDetail(productId);
      if (productDetail != null) {
        productDetailModel = productDetail;
      }
    }
    var lstProduct = await fetchProductList();
    var lstUnit = await fetchProductCategory(categoryProperty: 'ProductUnit');
    var lstStatus =
        await fetchProductCategory(categoryProperty: 'ProductStatus');
    var lstCategory =
        await fetchProductCategory(categoryProperty: 'ProductCategory');
    var lstType = await fetchProductCategory(categoryProperty: 'ProductType');
    widget.bloc.eventController.add(LoadData(
      detail: productDetailModel,
      listProduct: lstProduct,
      listUnit: lstUnit,
      listCategory: lstCategory,
      listStatus: lstStatus,
      listType: lstType,
    ));
  }

  @override
  void initState() {
    if (widget.productId?.isEmpty ?? true) {
      widget.bloc.eventController.add(ChangeScreenMode(ScreenModeEnum.edit));
    } else {
      widget.bloc.eventController.add(ChangeScreenMode(ScreenModeEnum.view));
    }
    loadData(widget.productId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.bloc.uiController.stream.listen((data) {
      setState(() {});
    });

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
                  child: ProductDetail(bloc: widget.bloc),
                ),
                const SizedBox(height: defaultPadding * 2),

                /// CHILD PRODUCTS
                widget.bloc.data.typeCode == 'BundleProduct'
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
                            child: ProductDetailChildren(bloc: widget.bloc),
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
                    SaveProductButton(bloc: widget.bloc),
                    UpdateProductButton(bloc: widget.bloc),
                    const DiscardProductButton(),
                  ],
                ),
              ),
      ],
    );
  }
}

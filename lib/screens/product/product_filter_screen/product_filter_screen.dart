import 'package:flutter/material.dart';

import '../../../utilities/custom_widgets.dart';
import '../../../utilities/enums/ui_enums.dart';
import '../../../utilities/responsive.dart';
import '../../../utilities/shared_preferences.dart';
import '../../../utilities/ui_styles.dart';
import '../../common_components/main_menu.dart';
import '../product_detail_screen/bloc/product_detail_bloc.dart';
import '../product_detail_screen/product_detail_body.dart';
import 'bloc/product_filter_bloc.dart';
import 'components/product_filter_action_buttons.dart';
import 'product_filter_body.dart';

class ProductFilterScreen extends StatefulWidget {
  const ProductFilterScreen({super.key});

  @override
  State<ProductFilterScreen> createState() => _ProductFilterScreenState();
}

class _ProductFilterScreenState extends State<ProductFilterScreen> {
  final bloc = ProductFilterBloc();
  final blocDetail = ProductDetailBloc();

  @override
  void dispose() {
    bloc.dispose();
    blocDetail.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// RETURN WIDGET
    return CScaffold(
      drawer: const MainMenu(),
      appBar: AppBar(
        title: Text(sharedPrefs.translate('Product'),
            style: const TextStyle(
                fontSize: mediumTextSize * 1.2, fontWeight: FontWeight.bold)),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.all(defaultPadding),
        //     child: CElevatedButton(
        //       labelText: sharedPrefs.translate('Add'),
        //       onPressed: () async {
        //         final isReload = await Navigator.pushNamed(
        //             context, customRouteMapping.productAdd);
        //         if (isReload == true) {
        //           bloc.loadData();
        //         }
        //       },
        //     ),
        //   )
        // ],
        actions: [
          /// ADD BUTTON
          StreamBuilder(
              stream: blocDetail.uiController.stream,
              builder: (context, snapshot) {
                if (!snapshot.hasData ||
                    snapshot.data?.state == ScreenModeEnum.view) {
                  return AddProductFilterButton(blocFilter: bloc);
                }
                return const SizedBox();
              }),

          /// SAVE BUTTON
          StreamBuilder(
              stream: blocDetail.uiController.stream,
              builder: (context, snapshot) {
                if (snapshot.data?.state == ScreenModeEnum.edit &&
                    !Responsive.isSmallWidth(context)) {
                  return SaveProductFilterButton(
                      blocFilter: bloc, blocDetail: blocDetail);
                }
                return const SizedBox();
              }),

          /// UPDATE BUTTON
          StreamBuilder(
              stream: blocDetail.uiController.stream,
              builder: (context, snapshot) {
                if (snapshot.data?.state == ScreenModeEnum.view &&
                    (bloc.selectedProductId?.isNotEmpty ?? false) &&
                    !Responsive.isSmallWidth(context)) {
                  return UpdateProductFilterButton(blocDetail: blocDetail);
                }
                return const SizedBox();
              }),

          /// DISCARD BUTTON
          StreamBuilder(
              stream: blocDetail.uiController.stream,
              builder: (context, snapshot) {
                if (snapshot.data?.state == ScreenModeEnum.edit) {
                  return BackToProductFilterButton(
                      blocFilter: bloc, blocDetail: blocDetail);
                }
                return const SizedBox();
              }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: defaultPadding * 2),
        child: LayoutBuilder(builder: (context, constraints) {
          return Row(
            children: [
              SizedBox(
                width: constraints.maxWidth < 850 ? constraints.maxWidth : 450,

                /// PRODUCT FILTER BODY
                child: ProductFilterBody(bloc: bloc),
              ),
              Expanded(
                  child: constraints.maxWidth < 850
                      ? const SizedBox()
                      : Padding(
                          padding:
                              const EdgeInsets.only(left: defaultPadding * 2),
                          child: StreamBuilder(
                            stream: bloc.selectionController.stream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data!.productId != null) {
                                  blocDetail.loadData(snapshot.data!.productId);
                                  //TODO: LỖI Ở ĐÂY
                                  return ProductDetailBody(
                                    bloc: blocDetail,
                                    productId: snapshot.data!.productId,
                                  );
                                }
                              }
                              return Center(
                                  child: CText(sharedPrefs
                                      .translate('Please select a product')));
                            },
                          ),
                        )),
            ],
          );
        }),
      ),
    );
  }
}

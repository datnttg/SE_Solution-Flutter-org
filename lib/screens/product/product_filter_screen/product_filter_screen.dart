import 'package:flutter/material.dart';

import '../../../utilities/configs.dart';
import '../../../utilities/custom_widgets.dart';
import '../../../utilities/enums/ui_enums.dart';
import '../../../utilities/responsive.dart';
import '../../../utilities/shared_preferences.dart';
import '../../../utilities/ui_styles.dart';
import '../../common_components/main_menu.dart';
import '../product_detail_screen/bloc/product_detail_bloc.dart';
import '../product_detail_screen/bloc/product_detail_events.dart';
import '../product_detail_screen/product_detail_body.dart';
import 'bloc/product_filter_bloc.dart';
import 'product_filter_body.dart';

class ProductFilterScreen extends StatefulWidget {
  final ProductFilterBloc? blocFilter;
  final ProductDetailBloc? blocDetail;

  const ProductFilterScreen({super.key, this.blocFilter, this.blocDetail});

  @override
  State<ProductFilterScreen> createState() => _ProductFilterScreenState();
}

class _ProductFilterScreenState extends State<ProductFilterScreen> {
  final GlobalKey<NavigatorState> detailNavigatorKey =
      GlobalKey<NavigatorState>();
  late final ProductFilterBloc blocFilter;
  late final ProductDetailBloc blocDetail;

  @override
  void initState() {
    if (widget.blocFilter != null) {
      blocFilter == widget.blocFilter;
    } else {
      blocFilter = ProductFilterBloc();
    }
    if (widget.blocDetail != null) {
      blocDetail == widget.blocDetail;
    } else {
      blocDetail = ProductDetailBloc();
    }
    blocFilter.init();
    blocDetail.init();
    super.initState();
  }

  @override
  void dispose() {
    blocFilter.dispose();
    blocDetail.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    blocFilter.selectionController.stream.listen((event) {
      blocDetail.uiController.add(ChangeScreenMode(ScreenModeEnum.view));
    });
    double screenWidth = MediaQuery.of(context).size.width;

    /// RETURN WIDGET
    return CScaffold(
      drawer: const MainMenu(),
      appBar: AppBar(
        title: Text(sharedPrefs.translate('Product'),
            style: const TextStyle(
                fontSize: mediumTextSize * 1.2, fontWeight: FontWeight.bold)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: CElevatedButton(
              labelText: sharedPrefs.translate('Add'),
              onPressed: () async {
                final isReload = await Navigator.pushNamed(
                    context, customRouteMapping.productAdd);
                if (isReload == true) {
                  blocFilter.loadData();
                }
              },
            ),
          )
        ],
      ),
      body: Row(
        children: [
          Expanded(
            /// FILTER BODY
            child: ProductFilterBody(bloc: blocFilter, blocDetail: blocDetail),
          ),
          // if (!Responsive.isSmallWidth(context))
          //   SizedBox(
          //     width: screenWidth - 450,
          //     child: Padding(
          //       padding: const EdgeInsets.only(left: defaultPadding * 2),
          //
          //       /// DETAIL BODY
          //       child: blocFilter.selectionState ==
          //               SelectionState(productId: null)
          //           ? const SizedBox(child: Text('data'))
          //           : ProductDetailBody(bloc: blocDetail),
          //     ),
          //   ),

          StreamBuilder<ChangeProductDetailEvents>(
              stream: blocDetail.uiController.stream,
              builder: (context, snapshot) {
                return Offstage(
                  offstage: Responsive.isSmallWidth(context),
                  child: SizedBox(
                    width: screenWidth - 450,
                    child: Padding(
                      padding: const EdgeInsets.only(left: defaultPadding * 2),
                      child: blocFilter.selectionState.productId == null
                          ? Center(
                              child:
                                  Text(sharedPrefs.translate('Select an item')))
                          : ProductDetailBody(
                              bloc: blocDetail,
                              productDetail:
                                  blocFilter.selectionState.productDetail!,
                            ),
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}

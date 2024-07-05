import 'package:flutter/material.dart';

import '../../../utilities/configs.dart';
import '../../../utilities/custom_widgets.dart';
import '../../../utilities/responsive.dart';
import '../../../utilities/shared_preferences.dart';
import '../../../utilities/ui_styles.dart';
import '../../common_components/main_menu.dart';
import '../product_detail_screen/bloc/product_detail_bloc.dart';
import '../product_detail_screen/product_detail_body.dart';
import 'bloc/product_filter_bloc.dart';
import 'product_filter_body.dart';

class ProductFilterScreen extends StatefulWidget {
  const ProductFilterScreen({super.key});

  @override
  State<ProductFilterScreen> createState() => _ProductFilterScreenState();
}

class _ProductFilterScreenState extends State<ProductFilterScreen> {
  final bloc = ProductFilterBloc();
  final blocDetail = ProductDetailBloc();
  final GlobalKey<NavigatorState> detailNavigatorKey =
      GlobalKey<NavigatorState>();

  @override
  void initState() {
    blocDetail.initBLoc();
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    blocDetail.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isSmallWidth = Responsive.isSmallWidth(context);
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
                  bloc.loadData();
                }
              },
            ),
          )
        ],
      ),
      body: Row(
        children: [
          Expanded(
            child: ProductFilterBody(bloc: bloc),
          ),
          if (!isSmallWidth)
            Container(
              constraints: BoxConstraints(maxWidth: screenWidth - 450),
              child: Padding(
                  padding: const EdgeInsets.only(left: defaultPadding * 2),
                  child: ProductDetailBody(bloc: blocDetail)),
            ),
        ],
      ),
    );
  }
}

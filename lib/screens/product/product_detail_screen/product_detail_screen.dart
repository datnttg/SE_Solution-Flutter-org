import 'package:flutter/material.dart';

import '../../../utilities/custom_widgets.dart';
import '../../../utilities/responsive.dart';
import '../../../utilities/shared_preferences.dart';
import '../../../utilities/ui_styles.dart';
import '../../common_components/main_menu.dart';
import '../product_filter_screen/bloc/product_filter_bloc.dart';
import '../product_filter_screen/bloc/product_filter_events.dart';
import '../product_filter_screen/product_filter_body.dart';
import 'bloc/product_detail_bloc.dart';
import 'components/product_detail_action_buttons.dart';
import 'product_detail_body.dart';

class ProductDetailScreen extends StatefulWidget {
  final String? productId;

  const ProductDetailScreen({super.key, this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final ProductDetailBloc bloc = ProductDetailBloc();
  final ProductFilterBloc blocFilter = ProductFilterBloc();

  @override
  void initState() {
    if (widget.productId?.isNotEmpty ?? false) {
      blocFilter.selectionState.productId = widget.productId;
    }
    bloc.initBLoc(productId: widget.productId);
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    blocFilter.eventController.stream.listen((event) {
      if (event is ChangeSelectedProduct) {
        bloc.loadDetail(productId: event.productId);
      }
    });

    return CScaffold(
      drawer: const MainMenu(),
      appBar: AppBar(
        title: Text(sharedPrefs.translate('Product information'),
            style: const TextStyle(
                fontSize: mediumTextSize * 1.2, fontWeight: FontWeight.bold)),
        actions: [
          Responsive.isPortrait(context)
              ? const SizedBox()
              : Row(
                  children: [
                    SaveProductButton(bloc: bloc),
                    UpdateProductButton(bloc: bloc),
                    const DiscardProductButton(),
                  ],
                ),
        ],
      ),
      // body: StreamBuilder(
      //   stream: bloc.dataController.stream,
      //   builder: (context, snapshot) {
      //     if (Responsive.isSmallWidth(context)) {
      //       if (blocFilter.selectionState.productId?.isNotEmpty ?? false) {
      //         return ProductDetailBody(
      //           bloc: bloc,
      //           productId: blocFilter.selectionState.productId,
      //         );
      //       } else {
      //         return ProductFilterBody(bloc: blocFilter);
      //       }
      //     } else {
      //       return Row(
      //         children: [
      //           Container(
      //             constraints: const BoxConstraints(maxWidth: 450),
      //             child: ProductFilterBody(bloc: blocFilter),
      //           ),
      //           const SizedBox(width: defaultPadding * 2),
      //           Expanded(
      //             child: ProductDetailBody(
      //               bloc: bloc,
      //               productId: blocFilter.selectionState.productId,
      //             ),
      //           ),
      //         ],
      //       );
      //     }
      //   },
      // ),

      body: LayoutBuilder(
        builder: (context, constrains) {
          if (Responsive.isSmallWidth(context)) {
            if (blocFilter.selectionState.productId?.isNotEmpty ?? false) {
              return ProductDetailBody(bloc: bloc);
            } else {
              return ProductFilterBody(bloc: blocFilter);
            }
          } else {
            return Row(
              children: [
                Container(
                  constraints: const BoxConstraints(maxWidth: 450),
                  child: ProductFilterBody(bloc: blocFilter),
                ),
                const SizedBox(width: defaultPadding * 2),
                Expanded(
                  child: ProductDetailBody(bloc: bloc),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

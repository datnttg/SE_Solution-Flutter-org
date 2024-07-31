import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utilities/custom_widgets.dart';
import '../../../utilities/responsive.dart';
import '../../../utilities/shared_preferences.dart';
import '../../../utilities/ui_styles.dart';
import '../../common_components/main_menu.dart';
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
  // @override
  // void initState() {
  //   context
  //       .read<ProductDetailBloc>()
  //       .add(InitProductDetailData(productId: widget.productId));
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => ProductDetailBloc(),
        child: CScaffold(
          drawer: const MainMenu(),
          appBar: AppBar(
            title: Text(sharedPrefs.translate('Product information'),
                style: const TextStyle(
                    fontSize: mediumTextSize * 1.2,
                    fontWeight: FontWeight.bold)),
            actions: [
              Responsive.isPortrait(context)
                  ? const SizedBox()
                  : const Row(
                      children: [
                        SaveProductButton(),
                        UpdateProductButton(),
                        DiscardProductButton(),
                      ],
                    ),
            ],
          ),
          body: const ProductDetailBody(),
        ));
  }
}

import 'package:flutter/material.dart';

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
  final ProductDetailBloc bloc = ProductDetailBloc();

  @override
  void initState() {
    bloc.loadData(widget.productId);
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Widget btnUpdate = bloc.screenMode.state == ScreenModeEnum.view
    //     ? Padding(
    //         padding: const EdgeInsets.all(defaultPadding),
    //         child: CElevatedButton(
    //           labelText: sharedPrefs.translate('Update'),
    //           onPressed: () {
    //             bloc.eventController.add(ChangeScreenMode(ScreenModeEnum.edit));
    //           },
    //         ))
    //     : const SizedBox();
    //
    // Widget btnSave = bloc.screenMode.state == ScreenModeEnum.edit
    //     ? Padding(
    //         padding: const EdgeInsets.only(
    //             left: defaultPadding, right: defaultPadding),
    //         child: CElevatedButton(
    //           labelText: sharedPrefs.translate('Save'),
    //           onPressed: () async {
    //             bloc.eventController.add(SubmitData());
    //           },
    //         ))
    //     : const SizedBox();
    //
    // Widget btnDiscard = Padding(
    //     padding:
    //         const EdgeInsets.only(left: defaultPadding, right: defaultPadding),
    //     child: CElevatedButton(
    //       labelText: sharedPrefs.translate('Discard'),
    //       onPressed: () {
    //         Navigator.pop(context);
    //       },
    //     ));

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
      body: ProductDetailBody(bloc: bloc, productId: widget.productId),
    );
  }
}

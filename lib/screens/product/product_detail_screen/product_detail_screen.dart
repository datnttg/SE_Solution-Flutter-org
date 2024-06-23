import 'package:flutter/material.dart';

import '../../../utilities/custom_widgets.dart';
import '../../../utilities/enums/ui_enums.dart';
import '../../../utilities/responsive.dart';
import '../../../utilities/shared_preferences.dart';
import '../../../utilities/ui_styles.dart';
import '../../common_components/main_menu.dart';
import '../product_filter_screen/services/product_filter_services.dart';
import 'bloc/product_detail_bloc.dart';
import 'bloc/product_detail_events.dart';
import 'components/product_detail.dart';
import 'components/product_detail_children.dart';

class ProductDetailScreen extends StatefulWidget {
  final String? productId;

  const ProductDetailScreen({super.key, this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final bloc = ProductDetailBloc();

  Future<void> loadProduct(String productId) async {
    var productDetail = await fetchProductDetail(productId);
    bloc.eventController.add(LoadProductDetail(productDetail));
  }

  @override
  void initState() {
    if (widget.productId == null) {
      bloc.eventController.add(ChangeScreenMode(ScreenModeEnum.edit));
    } else {
      bloc.eventController.add(ChangeScreenMode(ScreenModeEnum.view));
      loadProduct(widget.productId!);
    }
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bloc.dataController.stream.listen((data) {
      setState(() {});
    });

    Widget btnUpdate = bloc.screenMode.state == ScreenModeEnum.view
        ? Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: CElevatedButton(
              labelText: sharedPrefs.translate('Update'),
              onPressed: () {
                bloc.eventController.add(ChangeScreenMode(ScreenModeEnum.edit));
              },
            ))
        : const SizedBox();

    Widget btnSave = bloc.screenMode.state == ScreenModeEnum.edit
        ? Padding(
            padding: const EdgeInsets.only(
                left: defaultPadding, right: defaultPadding),
            child: CElevatedButton(
              labelText: sharedPrefs.translate('Save'),
              onPressed: () async {
                bloc.eventController.add(SubmitData());
              },
            ))
        : const SizedBox();

    Widget btnDiscard = Padding(
        padding:
            const EdgeInsets.only(left: defaultPadding, right: defaultPadding),
        child: CElevatedButton(
          labelText: sharedPrefs.translate('Discard'),
          onPressed: () {
            Navigator.pop(context);
          },
        ));

    return CScaffold(
        drawer: const MainMenu(),
        appBar: AppBar(
          title: Text(sharedPrefs.translate('Add product'),
              style: const TextStyle(
                  fontSize: mediumTextSize * 1.2, fontWeight: FontWeight.bold)),
          actions: [
            Responsive.isPortrait(context)
                ? const SizedBox()
                : Row(
                    children: [btnSave, btnUpdate, btnDiscard],
                  ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: defaultPadding * 2),

                    /// PRODUCT DETAIL
                    ProductDetail(bloc: bloc),
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
                              ProductDetailChildren(bloc: bloc),
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
                      children: [btnSave, btnUpdate, btnDiscard],
                    ),
                  ),
          ],
        ));
  }
}

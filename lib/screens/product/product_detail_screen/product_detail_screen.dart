import 'package:flutter/material.dart';
import 'package:se_solution/screens/product/product_detail_screen/bloc/product_detail_bloc.dart';

import '../../../utilities/configs.dart';
import '../../../utilities/custom_widgets.dart';
import '../../../utilities/responsive.dart';
import '../../../utilities/shared_preferences.dart';
import '../../../utilities/ui_styles.dart';
import '../../common_components/main_menu.dart';

class ProductDetailScreen extends StatefulWidget {
  final String? productId;

  const ProductDetailScreen({super.key, this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final bloc = ProductDetailBloc();

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget btnSave = Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: CElevatedButton(
          labelText: sharedPrefs.translate('Save'),
          onPressed: () async {
            final isReload =
                await Navigator.pushNamed(context, customRouteMapping.taskAdd);
            if (isReload == true) {
              // bloc.loadData();
            }
          },
        ));

    Widget btnBack = Padding(
        padding: const EdgeInsets.all(defaultPadding),
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
                ? Container()
                : Row(
                    children: [btnSave, btnBack],
                  ),
          ],
        ),
        bottomNavigationBar: !Responsive.isPortrait(context)
            ? Container()
            : Container(
                height: 50,
                width: double.infinity,
                color: cAppBarColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [btnSave, btnBack],
                ),
              ),
        body: Container());
  }
}

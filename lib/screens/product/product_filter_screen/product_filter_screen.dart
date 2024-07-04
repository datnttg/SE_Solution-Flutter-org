import 'package:flutter/material.dart';

import '../../../utilities/configs.dart';
import '../../../utilities/custom_widgets.dart';
import '../../../utilities/shared_preferences.dart';
import '../../../utilities/ui_styles.dart';
import '../../common_components/main_menu.dart';
import 'bloc/product_filter_bloc.dart';
import 'product_filter_body.dart';

class ProductFilterScreen extends StatefulWidget {
  const ProductFilterScreen({super.key});

  @override
  State<ProductFilterScreen> createState() => _ProductFilterScreenState();
}

class _ProductFilterScreenState extends State<ProductFilterScreen> {
  final bloc = ProductFilterBloc();

  @override
  void dispose() {
    bloc.dispose();
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
      body: ProductFilterBody(bloc: bloc),
    );
  }
}

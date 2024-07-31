import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se_solution/screens/product/product_filter_screen/bloc/product_filter_states.dart';

import '../../../utilities/custom_widgets.dart';
import '../../../utilities/responsive.dart';
import '../../../utilities/shared_preferences.dart';
import '../../../utilities/ui_styles.dart';
import '../../common_components/main_menu.dart';
import '../product_detail_screen/bloc/product_detail_bloc.dart';
import '../product_detail_screen/product_detail_body.dart';
import 'bloc/product_filter_bloc.dart';
import 'product_filter_body.dart';

class ProductFilterScreen extends StatelessWidget {
  const ProductFilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    /// RETURN WIDGET
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductFilterBloc>(create: (_) => ProductFilterBloc()),
        BlocProvider<ProductDetailBloc>(create: (_) => ProductDetailBloc())
      ],
      child: CScaffold(
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
                onPressed: () async {},
              ),
            )
          ],
        ),
        body: Row(
          children: [
            const Expanded(
              /// FILTER BODY
              child: ProductFilterBody(),
            ),
            if (!Responsive.isSmallWidth(context))
              BlocBuilder<ProductFilterBloc, ProductFilterState>(
                  builder: (context, state) {
                return SizedBox(
                  width: screenWidth - 450,
                  child: Padding(
                    padding: const EdgeInsets.only(left: defaultPadding * 2),

                    /// DETAIL BODY
                    child: state.selectedId == null
                        ? const Center(
                            child: SizedBox(
                                child: Text('Please select a product')))
                        : const ProductDetailBody(),
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }
}

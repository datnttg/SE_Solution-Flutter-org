import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utilities/custom_widgets.dart';
import '../../../utilities/responsive.dart';
import '../../../utilities/shared_preferences.dart';
import '../../../utilities/ui_styles.dart';
import '../../common_components/main_menu.dart';
import '../product_detail_screen/bloc/product_detail_bloc.dart';
import '../product_detail_screen/bloc/product_detail_states.dart';
import '../product_detail_screen/components/product_detail_action_buttons.dart';
import '../product_detail_screen/product_detail_body.dart';
import 'bloc/product_filter_bloc.dart';
import 'bloc/product_filter_events.dart';
import 'bloc/product_filter_states.dart';
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
            const AddProductFilterButton(),
            if (!Responsive.isSmallWidth(context)) const UpdateProductButton(),
            if (!Responsive.isSmallWidth(context)) const SaveProductButton(),
            if (!Responsive.isSmallWidth(context)) const DiscardProductButton(),
          ],
        ),
        body: BlocBuilder<ProductFilterBloc, ProductFilterState>(
          builder: (context, state) {
            switch (state.loadingStatus) {
              case ProductFilterStatus.success:
                return Row(
                  children: [
                    const Expanded(
                      /// FILTER BODY
                      child: ProductFilterBody(),
                    ),
                    if (!Responsive.isSmallWidth(context))
                      BlocSelector<ProductFilterBloc, ProductFilterState,
                              String?>(
                          selector: (state) => state.selectedId,
                          builder: (context, selectedId) {
                            return SizedBox(
                              width: screenWidth - 450,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: defaultPadding * 2),

                                /// DETAIL BODY
                                child: selectedId == null
                                    ? Center(
                                        child: SizedBox(
                                            child: Text(sharedPrefs.translate(
                                                'Please select a product'))))
                                    : BlocBuilder<ProductDetailBloc,
                                        ProductDetailState>(
                                        builder: (context, state) {
                                          switch (state.loadingStatus) {
                                            case ProductDetailLoadingStatus
                                                  .success:
                                              return const ProductDetailBody();
                                            default:
                                              return const Center(
                                                  child:
                                                      CircularProgressIndicator());
                                          }
                                        },
                                      ),
                              ),
                            );
                          }),
                  ],
                );
              default:
                context.read<ProductFilterBloc>().add(InitProductFilterData());
                return const Center(
                  child: CircularProgressIndicator(),
                );
            }
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utilities/custom_widgets.dart';
import '../../../utilities/enums/ui_enums.dart';
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
          title: Text(sharedPref.translate('Product'),
              style: const TextStyle(
                  fontSize: mediumTextSize * 1.2, fontWeight: FontWeight.bold)),
          actions: [
            if (!Responsive.isMobileAndPortrait(context))
              const AddProductFilterButton(),
            if (!Responsive.isMobileAndPortrait(context))
              const EditProductButton(),
            if (!Responsive.isMobileAndPortrait(context))
              const SaveProductButton(),
            if (!Responsive.isMobileAndPortrait(context))
              const DiscardProductButton(),
          ],
        ),
        body: Stack(
          children: [
            Container(
              constraints: const BoxConstraints(
                maxHeight: double.infinity,
                maxWidth: double.infinity,
              ),
              child: BlocBuilder<ProductFilterBloc, ProductFilterState>(
                builder: (context, state) {
                  bool isSmallWidthAndActive =
                      Responsive.isSmallWidth(context) &&
                          state.selectedId != null;
                  switch (state.initialStatus) {
                    case ProcessingStatusEnum.success:
                      return Row(
                        children: [
                          const Expanded(
                            /// FILTER BODY
                            child: ProductFilterBody(),
                          ),
                          if (!Responsive.isSmallWidth(context))
                            const SizedBox(
                              width: defaultPadding * 2,
                            ),
                          if (!Responsive.isSmallWidth(context) ||
                              isSmallWidthAndActive)
                            BlocSelector<ProductFilterBloc, ProductFilterState,
                                    String?>(
                                selector: (state) => state.selectedId,
                                builder: (context, selectedId) {
                                  return SizedBox(
                                    width: screenWidth -
                                        (isSmallWidthAndActive == false
                                            ? 450
                                            : 0),
                                    child: selectedId == null
                                        ? Center(
                                            child: SizedBox(
                                                child: Text(sharedPref.translate(
                                                    'Please select an item'))))
                                        : BlocBuilder<ProductDetailBloc,
                                            ProductDetailState>(
                                            builder: (context, state) {
                                              switch (state.loadingStatus) {
                                                case ProcessingStatusEnum
                                                      .success:

                                                  /// DETAIL BODY
                                                  return const ProductDetailBody();
                                                default:
                                                  return const Center(
                                                      child:
                                                          CircularProgressIndicator());
                                              }
                                            },
                                          ),
                                  );
                                }),
                        ],
                      );
                    default:
                      context
                          .read<ProductFilterBloc>()
                          .add(InitProductFilterData());
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                  }
                },
              ),
            ),

            /// ADD PRODUCT BUTTON
            if (Responsive.isMobileAndPortrait(context))
              const Positioned(
                bottom: 50,
                right: 50,
                child: AddProductFilterFloatingButton(),
              ),
          ],
        ),
      ),
    );
  }
}

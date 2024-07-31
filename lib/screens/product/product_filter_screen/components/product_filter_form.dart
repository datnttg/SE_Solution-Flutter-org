import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se_solution/screens/product/product_filter_screen/bloc/product_filter_states.dart';

import '../../../../utilities/custom_widgets.dart';
import '../../../../utilities/responsive.dart';
import '../../../../utilities/shared_preferences.dart';
import '../bloc/product_filter_bloc.dart';
import '../bloc/product_filter_events.dart';
import '../services/product_filter_services.dart';

class ProductFilterForm extends StatelessWidget {
  const ProductFilterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductFilterBloc, ProductFilterState>(
        builder: (context, state) {
      return Form(
        child: ResponsiveRow(
          context: context,
          basicWidth: 400,
          horizontalSpacing: 0,
          children: [
            /// CODE
            ResponsiveItem(
                child: CTextFormField(
              labelText: sharedPrefs.translate('Product code'),
              // wrap: true,
              hintText: '--${sharedPrefs.translate('All')}--',
              controller: null,
              onChanged: (value) {
                context
                    .read<ProductFilterBloc>()
                    .add(ProductFilterCodeChanged(value));
              },
            )),

            /// NAME
            ResponsiveItem(
                child: CTextFormField(
              labelText: sharedPrefs.translate('Product name'),
              // wrap: true,
              hintText: '--${sharedPrefs.translate('All')}--',
              controller: null,
              onChanged: (value) {
                context
                    .read<ProductFilterBloc>()
                    .add(ProductFilterNameChanged(value));
              },
            )),

            /// ASSIGNED USER
            ResponsiveItem(
              percentWidthOnParent:
                  Responsive.isSmallWidth(context) == true ? 100 : null,
              child: FutureBuilder(
                  future: fetchProductCategoryEntry(
                      categoryProperty: 'ProductCategory'),
                  builder: (context, snapshot) {
                    var labelText = sharedPrefs.translate('Category');
                    Widget child = COnLoadingDropdownMenu(labelText: labelText);
                    if (snapshot.hasData) {
                      child = CDropdownMenu(
                        labelText: labelText,
                        multiSelect: true,
                        hintText: '--${sharedPrefs.translate('All')}--',
                        dropdownMenuEntries: snapshot.data!,
                        onSelected: (values) {
                          context.read<ProductFilterBloc>().add(
                              ProductFilterSelectedCategoriesChanged(values));
                        },
                      );
                    }
                    return child;
                  }),
            ),

            /// ASSIGNED USER
            ResponsiveItem(
              percentWidthOnParent:
                  Responsive.isSmallWidth(context) == true ? 100 : null,
              child: FutureBuilder(
                  future: fetchProductCategoryEntry(
                      categoryProperty: 'ProductType'),
                  builder: (context, snapshot) {
                    var labelText = sharedPrefs.translate('Type');
                    Widget child = COnLoadingDropdownMenu(labelText: labelText);
                    if (snapshot.hasData) {
                      child = CDropdownMenu(
                        labelText: labelText,
                        multiSelect: true,
                        hintText: '--${sharedPrefs.translate('All')}--',
                        dropdownMenuEntries: snapshot.data!,
                        onSelected: (values) {
                          context
                              .read<ProductFilterBloc>()
                              .add(ProductFilterSelectedTypesChanged(values));
                        },
                      );
                    }
                    return child;
                  }),
            ),
          ],
        ),
      );
    });
  }
}

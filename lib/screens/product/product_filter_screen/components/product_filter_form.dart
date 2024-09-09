import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utilities/custom_widgets.dart';
import '../../../../utilities/responsive.dart';
import '../../../../utilities/shared_preferences.dart';
import '../../../../utilities/ui_styles.dart';
import '../bloc/product_filter_bloc.dart';
import '../bloc/product_filter_events.dart';
import '../bloc/product_filter_states.dart';

class ProductFilterForm extends StatelessWidget {
  const ProductFilterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductFilterBloc, ProductFilterState>(
        builder: (context, state) {
      return CGroup(
        child: ResponsiveRow(
          context: context,
          basicWidth: Responsive.isSmallWidth(context) ? 300 : 400,
          horizontalSpacing: defaultPadding * 5,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            /// CODE
            ResponsiveItem(
                child: CTextFormField(
              labelText: sharedPref.translate('Product code'),
              hintText: '--${sharedPref.translate('All')}--',
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
              labelText: sharedPref.translate('Product name'),
              hintText: '--${sharedPref.translate('All')}--',
              controller: null,
              onChanged: (value) {
                context
                    .read<ProductFilterBloc>()
                    .add(ProductFilterNameChanged(value));
              },
            )),

            /// CATEGORY
            ResponsiveItem(
              percentWidthOnParent:
                  Responsive.isSmallWidth(context) == true ? 100 : null,
              child: CDropdownMenu(
                labelText: sharedPref.translate('Category'),
                multiSelect: true,
                hintText: '--${sharedPref.translate('All')}--',
                dropdownMenuEntries:
                    state.dropdownData?.productCategories ?? [],
                onSelected: (values) {
                  context
                      .read<ProductFilterBloc>()
                      .add(ProductFilterCategoriesChanged(values));
                },
              ),
            ),

            /// TYPE
            ResponsiveItem(
              percentWidthOnParent:
                  Responsive.isSmallWidth(context) == true ? 100 : null,
              child: CDropdownMenu(
                labelText: sharedPref.translate('Type'),
                multiSelect: true,
                hintText: '--${sharedPref.translate('All')}--',
                dropdownMenuEntries: state.dropdownData?.productTypes ?? [],
                onSelected: (values) {
                  context
                      .read<ProductFilterBloc>()
                      .add(ProductFilterTypesChanged(values));
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}

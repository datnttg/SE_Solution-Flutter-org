import 'package:flutter/material.dart';

import '../../../../utilities/custom_widgets.dart';
import '../../../../utilities/responsive.dart';
import '../../../../utilities/shared_preferences.dart';
import '../bloc/product_filter_bloc.dart';
import '../bloc/product_filter_events.dart';
import '../services/product_filter_services.dart';

class ProductFilterForm extends StatefulWidget {
  final ProductFilterBloc bloc;

  const ProductFilterForm({super.key, required this.bloc});

  @override
  State<ProductFilterForm> createState() => _ProductFilterFormState();
}

class _ProductFilterFormState extends State<ProductFilterForm> {
  @override
  Widget build(BuildContext context) {
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
              widget.bloc.eventController.add(ChangeProductFilterCode(value));
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
              widget.bloc.eventController.add(ChangeProductFilterName(value));
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
                        widget.bloc.eventController
                            .add(ChangeProductFilterCategory(values));
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
                future:
                    fetchProductCategoryEntry(categoryProperty: 'ProductType'),
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
                        widget.bloc.eventController
                            .add(ChangeProductFilterType(values));
                      },
                    );
                  }
                  return child;
                }),
          ),
        ],
      ),
    );
  }
}

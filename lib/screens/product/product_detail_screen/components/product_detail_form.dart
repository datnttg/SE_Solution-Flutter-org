import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utilities/custom_widgets.dart';
import '../../../../utilities/enums/ui_enums.dart';
import '../../../../utilities/responsive.dart';
import '../../../../utilities/shared_preferences.dart';
import '../../../../utilities/ui_styles.dart';
import '../bloc/product_detail_bloc.dart';
import '../bloc/product_detail_events.dart';
import '../bloc/product_detail_states.dart';

class ProductDetailForm extends StatelessWidget {
  const ProductDetailForm({super.key});

  @override
  Widget build(BuildContext context) {
    /// RETURN
    return BlocBuilder<ProductDetailBloc, ProductDetailState>(
      builder: (context, state) {
        var readOnly = state.productUpdate.id != null &&
            state.screenMode == ScreenModeEnum.view;
        double basicWidth = 360;
        return LayoutBuilder(builder: (context, constrains) {
          return Container(
            color: kBgColor,
            child: ResponsiveRow(
              basicWidth: basicWidth,
              context: context,
              children: [
                /// CODE
                ResponsiveItem(
                  percentWidthOnParent:
                      constrains.maxWidth < 3 * basicWidth ? 100 : null,
                  child: CTextFormField(
                    labelText: sharedPref.translate('Code'),
                    required: state.screenMode == ScreenModeEnum.edit,
                    readOnly: readOnly,
                    autoFocus: state.productUpdate.code == null ? true : false,
                    initialValue: state.productUpdate.code,
                    onChanged: (value) {
                      context
                          .read<ProductDetailBloc>()
                          .add(ProductCodeChanged(value));
                    },
                  ),
                ),

                /// NAME
                ResponsiveItem(
                  widthRatio: 2,
                  child: CTextFormField(
                    labelText: sharedPref.translate('Name'),
                    required: state.screenMode == ScreenModeEnum.edit,
                    readOnly: readOnly,
                    initialValue: state.productUpdate.name,
                    onChanged: (value) {
                      context
                          .read<ProductDetailBloc>()
                          .add(ProductNameChanged(value));
                    },
                  ),
                ),

                /// UNIT
                ResponsiveItem(
                  child: CDropdownMenu(
                    labelText: sharedPref.translate('Unit'),
                    required: state.screenMode == ScreenModeEnum.edit,
                    readOnly: readOnly,
                    dropdownMenuEntries: state.lstUnit,
                    selectedMenuEntries: state.lstUnit
                        .where((e) => e.value == state.productUpdate.unitCode)
                        .toList(),
                    onSelected: (value) {
                      context
                          .read<ProductDetailBloc>()
                          .add(ProductUnitChanged(value.firstOrNull?.value));
                    },
                  ),
                ),

                /// SERIAL REQUIRED
                ResponsiveItem(
                  child: CSwitch(
                    labelText: sharedPref.translate('Serial monitoring'),
                    readOnly: readOnly,
                    value: state.productUpdate.serialRequired ?? false,
                    onChanged: (value) {
                      context
                          .read<ProductDetailBloc>()
                          .add(ProductSerialRequiredChanged(value));
                    },
                  ),
                ),

                /// WARRANTY
                ResponsiveItem(
                  percentWidthOnParent:
                      constrains.maxWidth < 3 * basicWidth ? 100 : null,
                  child: CTextFormField(
                    labelText: sharedPref.translate('Warranty (month)'),
                    keyboardType: TextInputType.number,
                    readOnly: readOnly,
                    initialValue:
                        state.productUpdate.monthsOfWarranty?.toString(),
                    onChanged: (value) {
                      context.read<ProductDetailBloc>().add(
                          ProductMonthsOfWarrantyChanged(int.parse(value)));
                    },
                  ),
                ),

                /// DESCRIPTION
                ResponsiveItem(
                  percentWidthOnParent: 100,
                  child: CTextFormField(
                    labelText: sharedPref.translate('Description'),
                    readOnly: readOnly,
                    initialValue: state.productUpdate.description,
                    onChanged: (value) {
                      context
                          .read<ProductDetailBloc>()
                          .add(ProductDescriptionChanged(value));
                    },
                  ),
                ),

                /// CATEGORY
                ResponsiveItem(
                  child: CDropdownMenu(
                    labelText: sharedPref.translate('Category'),
                    required: state.screenMode == ScreenModeEnum.edit,
                    readOnly: readOnly,
                    dropdownMenuEntries: state.lstCategory,
                    selectedMenuEntries: state.lstCategory
                        .where(
                            (e) => e.value == state.productUpdate.categoryCode)
                        .toList(),
                    onSelected: (value) {
                      context.read<ProductDetailBloc>().add(
                          ProductCategoryChanged(value.firstOrNull?.value));
                    },
                  ),
                ),

                /// STATUS
                ResponsiveItem(
                  child: CDropdownMenu(
                    labelText: sharedPref.translate('Status'),
                    required: state.screenMode == ScreenModeEnum.edit,
                    readOnly: readOnly,
                    dropdownMenuEntries: state.lstStatus,
                    selectedMenuEntries: state.lstStatus
                        .where((e) => e.value == state.productUpdate.statusCode)
                        .toList(),
                    onSelected: (value) {
                      context
                          .read<ProductDetailBloc>()
                          .add(ProductStatusChanged(value.firstOrNull?.value));
                    },
                  ),
                ),

                /// TYPE
                ResponsiveItem(
                  child: CDropdownMenu(
                    labelText: sharedPref.translate('Type'),
                    required: state.screenMode == ScreenModeEnum.edit,
                    readOnly: state.productUpdate.id != null &&
                        state.screenMode == ScreenModeEnum.view,
                    dropdownMenuEntries: state.lstType,
                    selectedMenuEntries: state.lstType
                        .where((e) => e.value == state.productUpdate.typeCode)
                        .toList(),
                    onSelected: (value) {
                      context
                          .read<ProductDetailBloc>()
                          .add(ProductTypeChanged(value.firstOrNull?.value));
                    },
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }
}

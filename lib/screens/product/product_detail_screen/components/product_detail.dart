import 'package:flutter/material.dart';

import '../../../../utilities/classes/custom_widget_models.dart';
import '../../../../utilities/custom_widgets.dart';
import '../../../../utilities/enums/ui_enums.dart';
import '../../../../utilities/responsive.dart';
import '../../../../utilities/shared_preferences.dart';
import '../../../../utilities/ui_styles.dart';
import '../bloc/product_detail_bloc.dart';
import '../bloc/product_detail_events.dart';
import '../services/fetch_data_service.dart';

class ProductDetail extends StatelessWidget {
  final ProductDetailBloc bloc;
  final codeController = TextEditingController();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final warrantyController = TextEditingController();

  ProductDetail({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    var readOnly = bloc.screenMode.state == ScreenModeEnum.view;
    codeController.text = bloc.data.code ?? '';
    nameController.text = bloc.data.name ?? '';
    descriptionController.text = bloc.data.description ?? '';
    warrantyController.text = bloc.data.monthsOfWarranty?.toString() ?? '';

    /// RETURN
    return Container(
      color: kBgColor,
      child: ResponsiveRow(
        basicWidth: 360,
        context: context,
        children: [
          /// CODE
          ResponsiveItem(
            child: CTextFormField(
              labelText: sharedPrefs.translate('Code'),
              required: true,
              readOnly: readOnly,
              autoFocus: codeController.text == '' ? true : false,
              controller: codeController,
              onChanged: (value) {
                bloc.eventController.add(ChangeProductCode(value));
              },
            ),
          ),

          /// NAME
          ResponsiveItem(
            child: CTextFormField(
              labelText: sharedPrefs.translate('Name'),
              required: true,
              readOnly: readOnly,
              controller: nameController,
              onChanged: (value) {
                bloc.eventController.add(ChangeProductName(value));
              },
            ),
          ),

          /// UNIT
          ResponsiveItem(
            child: FutureBuilder<List<CDropdownMenuEntry>>(
                future: fetchProductCategory(categoryProperty: 'ProductUnit'),
                builder: (context, snapshot) {
                  var labelText = 'Unit';
                  if (snapshot.hasData) {
                    return CDropdownMenu(
                      labelText: sharedPrefs.translate(labelText),
                      required: true,
                      readOnly: readOnly,
                      dropdownMenuEntries: snapshot.data!,
                      selectedMenuEntries: snapshot.data!
                          .where((e) => e.value == bloc.data.unitCode)
                          .toList(),
                      onSelected: (value) {
                        bloc.eventController
                            .add(ChangeProductUnit(value.first.value));
                      },
                    );
                  }
                  return COnLoadingDropdownMenu(
                      labelText: sharedPrefs.translate(labelText));
                }),
          ),

          /// DESCRIPTION
          ResponsiveItem(
            widthRatio: 2,
            child: CTextFormField(
              labelText: sharedPrefs.translate('Description'),
              readOnly: readOnly,
              controller: descriptionController,
              onChanged: (value) {
                bloc.eventController.add(ChangeProductDescription(value));
              },
            ),
          ),

          /// WARRANTY
          ResponsiveItem(
            child: CTextFormField(
              labelText: sharedPrefs.translate('Warranty (month)'),
              keyboardType: TextInputType.number,
              readOnly: readOnly,
              controller: warrantyController,
              onChanged: (value) {
                bloc.eventController.add(ChangeProductMonthsOfWarranty(value));
              },
            ),
          ),

          /// STATUS
          ResponsiveItem(
            widthRatio: bloc.data.statusCode != null ? 1 : 0,
            child: FutureBuilder<List<CDropdownMenuEntry>>(
                future: fetchProductCategory(categoryProperty: 'ProductStatus'),
                builder: (context, snapshot) {
                  var labelText = 'Status';
                  if (snapshot.hasData) {
                    return CDropdownMenu(
                      labelText: sharedPrefs.translate(labelText),
                      required: true,
                      readOnly: readOnly,
                      dropdownMenuEntries: snapshot.data!,
                      selectedMenuEntries: snapshot.data!
                          .where((e) => e.value == bloc.data.statusCode)
                          .toList(),
                      onSelected: (value) {
                        bloc.eventController
                            .add(ChangeProductStatus(value.first.value));
                      },
                    );
                  }
                  return COnLoadingDropdownMenu(
                      labelText: sharedPrefs.translate(labelText));
                }),
          ),

          /// CATEGORY
          ResponsiveItem(
            child: FutureBuilder<List<CDropdownMenuEntry>>(
                future:
                    fetchProductCategory(categoryProperty: 'ProductCategory'),
                builder: (context, snapshot) {
                  var labelText = 'Category';
                  if (snapshot.hasData) {
                    return CDropdownMenu(
                      labelText: sharedPrefs.translate(labelText),
                      required: true,
                      readOnly: readOnly,
                      dropdownMenuEntries: snapshot.data!,
                      selectedMenuEntries: snapshot.data!
                          .where((e) => e.value == bloc.data.categoryCode)
                          .toList(),
                      onSelected: (value) {
                        bloc.eventController
                            .add(ChangeProductCategory(value.first.value));
                      },
                    );
                  }
                  return COnLoadingDropdownMenu(
                      labelText: sharedPrefs.translate(labelText));
                }),
          ),

          /// TYPE
          ResponsiveItem(
            child: FutureBuilder<List<CDropdownMenuEntry>>(
                future: fetchProductCategory(categoryProperty: 'ProductType'),
                builder: (context, snapshot) {
                  var labelText = 'Type';
                  if (snapshot.hasData) {
                    return CDropdownMenu(
                      labelText: sharedPrefs.translate(labelText),
                      required: true,
                      readOnly: readOnly,
                      dropdownMenuEntries: snapshot.data!,
                      selectedMenuEntries: bloc.data.typeCode == null
                          ? snapshot.data!
                              .where((e) => e.value == bloc.data.typeCode)
                              .toList()
                          : snapshot.data!
                              .where((e) => e.value == bloc.data.typeCode)
                              .toList(),
                      onSelected: (value) {
                        bloc.eventController
                            .add(ChangeProductType(value.first.value));
                      },
                    );
                  }
                  return COnLoadingDropdownMenu(
                      labelText: sharedPrefs.translate(labelText));
                }),
          ),
        ],
      ),
    );
  }
}

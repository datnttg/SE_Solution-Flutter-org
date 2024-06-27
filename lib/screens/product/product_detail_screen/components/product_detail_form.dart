import 'package:flutter/material.dart';

import '../../../../utilities/custom_widgets.dart';
import '../../../../utilities/enums/ui_enums.dart';
import '../../../../utilities/responsive.dart';
import '../../../../utilities/shared_preferences.dart';
import '../../../../utilities/ui_styles.dart';
import '../bloc/product_detail_bloc.dart';
import '../bloc/product_detail_events.dart';
import '../bloc/product_detail_states.dart';

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
              required: bloc.screenMode.state == ScreenModeEnum.edit,
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
            widthRatio: 2,
            child: CTextFormField(
              labelText: sharedPrefs.translate('Name'),
              required: bloc.screenMode.state == ScreenModeEnum.edit,
              readOnly: readOnly,
              controller: nameController,
              onChanged: (value) {
                bloc.eventController.add(ChangeProductName(value));
              },
            ),
          ),

          /// UNIT
          ResponsiveItem(
            child: StreamBuilder<ProductDetailDataState>(
                stream: bloc.dropdownDataController.stream,
                builder: (context, snapshot) {
                  var labelText = 'Unit';
                  if (snapshot.hasData) {
                    return CDropdownMenu(
                      labelText: sharedPrefs.translate(labelText),
                      required: bloc.screenMode.state == ScreenModeEnum.edit,
                      readOnly: readOnly,
                      dropdownMenuEntries: snapshot.data!.listUnit ?? [],
                      selectedMenuEntries: snapshot.data!.listUnit!
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

          /// SERIAL REQUIRED
          ResponsiveItem(
            child: CSwitch(
              labelText: sharedPrefs.translate('Serial monitoring'),
              readOnly: readOnly,
              value: bloc.data.serialRequired ?? false,
              onChanged: (value) {
                bloc.eventController.add(ChangeProductRequiredSerial(value));
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

          /// DESCRIPTION
          ResponsiveItem(
            percentWidthOnParent: 100,
            child: CTextFormField(
              labelText: sharedPrefs.translate('Description'),
              readOnly: readOnly,
              controller: descriptionController,
              onChanged: (value) {
                bloc.eventController.add(ChangeProductDescription(value));
              },
            ),
          ),

          /// CATEGORY
          ResponsiveItem(
            child: StreamBuilder<ProductDetailDataState>(
                stream: bloc.dropdownDataController.stream,
                builder: (context, snapshot) {
                  var labelText = 'Category';
                  if (snapshot.hasData) {
                    return CDropdownMenu(
                      labelText: sharedPrefs.translate(labelText),
                      required: bloc.screenMode.state == ScreenModeEnum.edit,
                      readOnly: readOnly,
                      dropdownMenuEntries: snapshot.data!.listCategory!,
                      selectedMenuEntries: snapshot.data!.listCategory!
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

          /// STATUS
          ResponsiveItem(
            widthRatio: bloc.data.statusCode != '' ? 1 : 0,
            child: StreamBuilder<ProductDetailDataState>(
                stream: bloc.dropdownDataController.stream,
                builder: (context, snapshot) {
                  var labelText = 'Status';
                  if (snapshot.hasData) {
                    return CDropdownMenu(
                      labelText: sharedPrefs.translate(labelText),
                      required: bloc.screenMode.state == ScreenModeEnum.edit,
                      readOnly: readOnly,
                      dropdownMenuEntries: snapshot.data!.listStatus ?? [],
                      selectedMenuEntries: snapshot.data!.listStatus!
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

          /// TYPE
          ResponsiveItem(
            child: StreamBuilder<ProductDetailDataState>(
                stream: bloc.dropdownDataController.stream,
                builder: (context, snapshot) {
                  var labelText = 'Type';
                  if (snapshot.hasData) {
                    return CDropdownMenu(
                      labelText: sharedPrefs.translate(labelText),
                      required: bloc.screenMode.state == ScreenModeEnum.edit,
                      readOnly: readOnly,
                      dropdownMenuEntries: snapshot.data!.listType!,
                      selectedMenuEntries: bloc.data.typeCode == null
                          ? []
                          : snapshot.data!.listType!
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

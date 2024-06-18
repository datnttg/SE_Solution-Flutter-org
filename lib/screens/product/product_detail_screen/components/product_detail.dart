import 'package:flutter/material.dart';

import '../../../../utilities/classes/custom_widget_models.dart';
import '../../../../utilities/custom_widgets.dart';
import '../../../../utilities/enums/ui_enums.dart';
import '../../../../utilities/responsive.dart';
import '../../../../utilities/shared_preferences.dart';
import '../../../../utilities/ui_styles.dart';
import '../bloc/product_detail_bloc.dart';
import '../bloc/product_detail_events.dart';
import '../models/product_detail_model.dart';
import '../services/fetch_data_service.dart';

class ProductDetail extends StatelessWidget {
  final ProductDetailBloc bloc;
  final ProductDetailModel? data;

  const ProductDetail({super.key, required this.bloc, this.data});

  @override
  Widget build(BuildContext context) {
    if (data != null) {
      bloc.state.productDetail = data!;
    }
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
            readOnly: bloc.screenMode.screenMode == ScreenModeEnum.view
                ? true
                : false,
            autoFocus: data?.code == null ? true : false,
            initialValue: data?.code,
            onChanged: (value) {
              bloc.eventController.add(ChangeProductCode(value));
            },
          )),

          /// NAME
          ResponsiveItem(
              child: CTextFormField(
            labelText: sharedPrefs.translate('Name'),
            required: true,
            readOnly: bloc.screenMode.screenMode == ScreenModeEnum.view
                ? true
                : false,
            initialValue: data?.name,
            onChanged: (value) {
              bloc.eventController.add(ChangeProductName(value));
            },
          )),

          /// DESCRIPTION
          ResponsiveItem(
              child: CTextFormField(
            labelText: sharedPrefs.translate('Description'),
            wrap: true,
            readOnly: bloc.screenMode.screenMode == ScreenModeEnum.view
                ? true
                : false,
            initialValue: data?.description,
            onChanged: (value) {
              bloc.eventController.add(ChangeProductDescription(value));
            },
          )),

          /// WARRANTY
          ResponsiveItem(
              child: CTextFormField(
            labelText: sharedPrefs.translate('Warranty (month)'),
            readOnly: bloc.screenMode.screenMode == ScreenModeEnum.view
                ? true
                : false,
            initialValue: data?.monthsOfWarranty.toString(),
            onChanged: (value) {
              bloc.eventController
                  .add(ChangeProductMonthsOfWarranty(int.parse(value)));
            },
          )),

          /// STATUS
          ResponsiveItem(
            widthRatio: data?.statusCode != null ? 1 : 0,
            child: FutureBuilder<List<CDropdownMenuEntry>>(
                future: fetchProductCategory(categoryProperty: 'ProductStatus'),
                builder: (context, snapshot) {
                  var labelText = 'Status';
                  if (snapshot.hasData) {
                    return CDropdownMenu(
                      labelText: sharedPrefs.translate(labelText),
                      required: true,
                      readOnly:
                          bloc.screenMode.screenMode == ScreenModeEnum.view
                              ? true
                              : false,
                      dropdownMenuEntries: snapshot.data!,
                      selectedMenuEntries: snapshot.data!
                          .where((e) => e.value == data?.statusCode)
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
                      readOnly:
                          bloc.screenMode.screenMode == ScreenModeEnum.view
                              ? true
                              : false,
                      dropdownMenuEntries: snapshot.data!,
                      selectedMenuEntries: snapshot.data!
                          .where((e) => e.value == data?.categoryCode)
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
                      readOnly:
                          bloc.screenMode.screenMode == ScreenModeEnum.view
                              ? true
                              : false,
                      dropdownMenuEntries: snapshot.data!,
                      selectedMenuEntries: bloc.state.productDetail.typeCode ==
                              null
                          ? snapshot.data!
                              .where((e) => e.value == data?.typeCode)
                              .toList()
                          : snapshot.data!
                              .where((e) =>
                                  e.value == bloc.state.productDetail.typeCode)
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

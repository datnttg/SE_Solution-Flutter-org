import 'package:flutter/material.dart';

import '../../../../utilities/app_service.dart';
import '../../../../utilities/configs.dart';
import '../../../../utilities/custom_widgets.dart';
import '../../../../utilities/responsive.dart';
import '../../../../utilities/shared_preferences.dart';
import '../../../../utilities/ui_styles.dart';
import '../bloc/product_filter_bloc.dart';
import '../bloc/product_filter_events.dart';
import '../models/product_filter_item_model.dart';

class ProductListItem extends StatelessWidget {
  const ProductListItem(
      {super.key, required this.dataItem, required this.bloc});
  final ProductFilterBloc bloc;
  final ProductFilterItemModel dataItem;

  @override
  Widget build(BuildContext context) {
    /// RETURN
    return InkWell(
      onTap: () async {
        bloc.eventController.add(ChangeSelectedProduct(productId: dataItem.id));

        if (Responsive.isSmallWidth(context)) {
          final isReload = await Navigator.pushNamed(
            context,
            '${customRouteMapping.productDetail}/${dataItem.id}',
          );
          if (isReload == true) {
            bloc.loadData();
          }
          // Navigator.pushNamedAndRemoveUntil(
          //     context,
          //     '${customRouteMapping.productDetail}/${dataItem.id}',
          //     (Route<dynamic> route) => false);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(defaultPadding * 2),
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(defaultRadius)),
        child: Column(
          children: [
            ResponsiveRow(
              context: context,
              // basicWidth: Responsive.isSmallWidth(context) == true ? 180 : 240,
              basicWidth: 180,
              children: [
                /// TASK TYPE
                ResponsiveItem(
                  widthRatio: 2,
                  child: Row(
                    children: [
                      CText(
                        '${dataItem.name}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        warpText: true,
                      )
                    ],
                  ),
                ),

                // /// STATUS
                // ResponsiveItem(
                //   child: Row(
                //     children: [
                //       CText('${sharedPrefs.translate('Status')}: ',
                //           style: const TextStyle(fontSize: smallTextSize)),
                //       CText(
                //         '${dataItem.taskStatusText}',
                //         style: TextStyle(
                //           // fontWeight: FontWeight.bold,
                //           fontSize: smallTextSize,
                //           color: dataItem.taskStatusCode == "Completed"
                //               ? Colors.green
                //               : dataItem.taskStatusCode == "WaitToConfirm"
                //                   ? Colors.orange
                //                   : dataItem.taskStatusCode == "Rejected"
                //                       ? Colors.grey
                //                       : Colors.black,
                //         ),
                //         warpText: true,
                //       )
                //     ],
                //   ),
                // ),

                /// CATEGORY
                ResponsiveItem(
                  child: Row(
                    children: [
                      CText('${sharedPrefs.translate('Category')}: ',
                          style: const TextStyle(fontSize: smallTextSize)),
                      CText(
                        '${dataItem.categoryText}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: smallTextSize,
                          color: Colors.black,
                        ),
                        warpText: true,
                      )
                    ],
                  ),
                ),

                /// TYPE
                ResponsiveItem(
                  child: Row(
                    children: [
                      CText('${sharedPrefs.translate('Type')}: ',
                          style: const TextStyle(fontSize: smallTextSize)),
                      CText(
                        '${dataItem.typeText}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: smallTextSize,
                          color: Colors.black,
                        ),
                        warpText: true,
                      )
                    ],
                  ),
                ),

                /// MONTHS OF WARRANTY
                dataItem.monthsOfWarranty == null
                    ? const ResponsiveItem(
                        widthRatio: 0,
                        child: SizedBox(),
                      )
                    : ResponsiveItem(
                        child: Row(
                          children: [
                            CText(
                                '${sharedPrefs.translate('Warranty (month)')}: ',
                                style:
                                    const TextStyle(fontSize: smallTextSize)),
                            CText(
                              numberFormat0(
                                  dataItem.monthsOfWarranty!.toDouble()),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: smallTextSize,
                                color: Colors.black,
                              ),
                              warpText: true,
                            )
                          ],
                        ),
                      ),

                /// MIN PRICE
                dataItem.minPrice == null
                    ? const ResponsiveItem()
                    : ResponsiveItem(
                        child: Row(
                          children: [
                            CText('${sharedPrefs.translate('Min price')}: ',
                                style:
                                    const TextStyle(fontSize: smallTextSize)),
                            CText(
                              numberFormat0(dataItem.minPrice!),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: smallTextSize,
                                color: Colors.black,
                              ),
                              warpText: true,
                            )
                          ],
                        ),
                      ),

                /// DESCRIPTION
                ResponsiveItem(
                  widthRatio: 2,
                  child: dataItem.description == null
                      ? Container()
                      : CText('${dataItem.description}'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utilities/app_service.dart';
import '../../../../utilities/configs.dart';
import '../../../../utilities/custom_widgets.dart';
import '../../../../utilities/responsive.dart';
import '../../../../utilities/shared_preferences.dart';
import '../../../../utilities/ui_styles.dart';
import '../../product_detail_screen/bloc/product_detail_bloc.dart';
import '../../product_detail_screen/bloc/product_detail_events.dart';
import '../bloc/product_filter_bloc.dart';
import '../bloc/product_filter_events.dart';
import '../bloc/product_filter_states.dart';
import '../models/product_filter_item_model.dart';

class ProductListItem extends StatelessWidget {
  final ProductFilterItemModel dataItem;

  const ProductListItem({super.key, required this.dataItem});

  @override
  Widget build(BuildContext context) {
    /// RETURN
    return BlocBuilder<ProductFilterBloc, ProductFilterState>(
        builder: (context, state) {
      return InkWell(
        onTap: () async {
          debugPrint('Selected productId: ${dataItem.id}');
          if (Responsive.isSmallWidth(context)) {
            var isReload = await Navigator.pushNamed(
              context,
              '${customRouteMapping.productDetail}/${dataItem.id}',
            );
            if (isReload == true && context.mounted) {
              context.read<ProductFilterBloc>().add(InitProductFilterData());
            }
            // Navigator.pushNamedAndRemoveUntil(
            //     context,
            //     '${customRouteMapping.productDetail}/${dataItem.id}',
            //     (Route<dynamic> route) => false);
          } else if (context.mounted) {
            context
                .read<ProductFilterBloc>()
                .add(SelectedFilterProductChanged(dataItem.id));
            context
                .read<ProductDetailBloc>()
                .add(ProductIdChanged(dataItem.id));
          }
        },
        child: Container(
          padding: const EdgeInsets.all(defaultPadding * 2),
          decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(defaultRadius)),
          child: ResponsiveRow(
            context: context,
            // basicWidth: Responsive.isSmallWidth(context) == true ? 180 : 240,
            basicWidth: 180,
            children: [
              /// TYPE
              ResponsiveItem(
                percentWidthOnParent: 100,
                child: Row(
                  children: [
                    CText(
                      '${dataItem.name}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      wrapText: true,
                    )
                  ],
                ),
              ),

              /// CATEGORY
              ResponsiveItem(
                child: Row(
                  children: [
                    CText('${sharedPref.translate('Category')}: ',
                        style: const TextStyle(fontSize: smallTextSize)),
                    CText(
                      '${dataItem.categoryText}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: smallTextSize,
                        color: Colors.black,
                      ),
                      wrapText: true,
                    )
                  ],
                ),
              ),

              /// TYPE
              ResponsiveItem(
                child: Row(
                  children: [
                    CText('${sharedPref.translate('Type')}: ',
                        style: const TextStyle(fontSize: smallTextSize)),
                    CText(
                      '${dataItem.typeText}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: smallTextSize,
                        color: Colors.black,
                      ),
                      wrapText: true,
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
                          CText('${sharedPref.translate('Warranty (month)')}: ',
                              style: const TextStyle(fontSize: smallTextSize)),
                          CText(
                            numberFormat0(
                                dataItem.monthsOfWarranty!.toDouble()),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: smallTextSize,
                              color: Colors.black,
                            ),
                            wrapText: true,
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
                          CText('${sharedPref.translate('Min price')}: ',
                              style: const TextStyle(fontSize: smallTextSize)),
                          CText(
                            numberFormat0(dataItem.minPrice!),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: smallTextSize,
                              color: Colors.black,
                            ),
                            wrapText: true,
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
          ),
        ),
      );
    });
  }
}

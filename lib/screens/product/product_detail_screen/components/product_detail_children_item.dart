import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utilities/app_service.dart';
import '../../../../utilities/classes/custom_widget_models.dart';
import '../../../../utilities/custom_widgets.dart';
import '../../../../utilities/responsive.dart';
import '../../../../utilities/shared_preferences.dart';
import '../../../../utilities/ui_styles.dart';
import '../../product_filter_screen/models/product_filter_item_model.dart';

class ProductDetailChildrenItem extends StatefulWidget {
  final int itemIndex;

  const ProductDetailChildrenItem({super.key, required this.itemIndex});

  @override
  State<ProductDetailChildrenItem> createState() =>
      _ProductDetailChildrenItemState();
}

class _ProductDetailChildrenItemState extends State<ProductDetailChildrenItem> {
  final quantityController = TextEditingController();

  ProductFilterItemModel? child;
  double quantity = 0.0;
  List<CDropdownMenuEntry> dropdownMenuEntries = [];
  List<CDropdownMenuEntry> selectedMenuEntries = [];
  List<CDropdownMenuEntry> disabledMenuEntries = [];

  @override
  Widget build(BuildContext context) {
    var productNameWidget = CDropdownMenu(
        labelText: sharedPrefs.translate('Select product'),
        labelTextAsHint: true,
        showDivider: false,
        enableSearch: true,
        menuHeight: 200,
        // readOnly: widget.bloc.screenMode.state == ScreenModeEnum.view,
        dropdownMenuEntries: dropdownMenuEntries,
        disabledMenuEntries: disabledMenuEntries,
        selectedMenuEntries: selectedMenuEntries,
        onSelected: (selected) {});

    var productQuantityWidget = SizedBox(
      width: 150,
      child: Column(
        children: [
          Row(
            children: [
              IconButton(icon: const Icon(Icons.remove), onPressed: () {}),
              Expanded(
                child: CTextFormField(
                  labelText: sharedPrefs.translate('Qty'),
                  keyboardType: TextInputType.number,
                  controller: quantityController,
                  labelTextAsHint: true,
                  textAlign: TextAlign.end,
                  isDense: true,
                  // readOnly: widget.bloc.screenMode.state == ScreenModeEnum.edit
                  //     ? false
                  //     : true,
                  onChanged: (value) {
                    if (!value.isAlphabetOnly) {
                      try {
                        quantity = double.parse(value);
                        if (quantity <= 0) {
                          kShowAlert(
                              body: Text(sharedPrefs.translate(
                                  'Quantity must be better than 0')));
                        }
                      } catch (ex) {
                        return;
                      }
                    } else {
                      kShowAlert(
                          body: Text(sharedPrefs
                              .translate('Quantity must be a number')));
                    }
                  },
                ),
              ),
              IconButton(icon: const Icon(Icons.add), onPressed: () {}),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CText(
                child?.unitText ?? '',
                style: const TextStyle(fontSize: smallTextSize),
              ),
              const SizedBox(width: 45)
            ],
          ),
        ],
      ),
    );

    Widget categoryWidget = child?.categoryText == null
        ? const SizedBox()
        : CText(
            '${sharedPrefs.translate('Category')}: ${child?.categoryText}',
            style: const TextStyle(fontSize: smallTextSize),
          );

    Widget typeWidget = child?.typeText == null
        ? const SizedBox()
        : CText(
            '${sharedPrefs.translate('Type')}: ${child?.typeText}',
            style: const TextStyle(fontSize: smallTextSize),
          );

    /// RETURN
    return Container(
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: kBorderColor))),
      child: !Responsive.isSmallWidth(context)
          ? Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      productNameWidget,
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20.0,
                          bottom: defaultPadding,
                        ),
                        child: ResponsiveRow(context: context, children: [
                          ResponsiveItem(child: categoryWidget),
                          ResponsiveItem(child: typeWidget),
                        ]),
                      )
                    ],
                  ),
                ),
                productQuantityWidget,
              ],
            )
          : Column(
              children: [
                productNameWidget,
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: ResponsiveRow(
                          context: context,
                          children: [
                            ResponsiveItem(child: categoryWidget),
                            ResponsiveItem(child: typeWidget),
                          ],
                        ),
                      ),
                    ),
                    productQuantityWidget,
                  ],
                )
              ],
            ),
    );
  }
}

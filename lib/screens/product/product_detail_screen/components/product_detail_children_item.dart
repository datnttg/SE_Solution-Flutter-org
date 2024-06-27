import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:se_solution/utilities/enums/ui_enums.dart';
import '../../../../utilities/app_service.dart';
import '../../../../utilities/classes/custom_widget_models.dart';
import '../../../../utilities/custom_widgets.dart';
import '../../../../utilities/responsive.dart';
import '../../../../utilities/shared_preferences.dart';
import '../../../../utilities/ui_styles.dart';
import '../../product_filter_screen/models/product_filter_item_model.dart';
import '../bloc/product_detail_bloc.dart';
import '../bloc/product_detail_events.dart';

class ProductDetailChildrenItem extends StatefulWidget {
  final ProductDetailBloc bloc;
  final int itemIndex;

  const ProductDetailChildrenItem(
      {super.key, required this.bloc, required this.itemIndex});

  @override
  State<ProductDetailChildrenItem> createState() =>
      _ProductDetailChildrenItemState();
}

class _ProductDetailChildrenItemState extends State<ProductDetailChildrenItem> {
  final quantityController = TextEditingController();

  var quantity = 0.0;
  ProductFilterItemModel? child;
  ProductFilterItemModel? selectedProduct;

  Future<void> _loadProductDetails() async {
    if (widget.bloc.data.children != null) {
      setState(() {
        child = widget.bloc.dropdownData.listProduct!
            .where((e) =>
                e.id == widget.bloc.data.children?[widget.itemIndex].childId)
            .firstOrNull;
        quantity =
            widget.bloc.data.children?[widget.itemIndex].quantityOfChild ?? 0;
      });
    }
  }

  @override
  void initState() {
    _loadProductDetails();
    selectedProduct = child;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    quantityController.text =
        (widget.bloc.data.children?[widget.itemIndex].quantityOfChild ?? 0)
            .toString();

    var productNameWidget = CDropdownMenu(
      labelText: sharedPrefs.translate('Product'),
      labelTextAsHint: true,
      showDivider: false,
      enableSearch: true,
      menuHeight: 200,
      readOnly:
          widget.bloc.screenMode.state == ScreenModeEnum.view ? true : false,
      dropdownMenuEntries: (widget.bloc.dropdownData.listProduct!
              .map((e) => CDropdownMenuEntry(value: e.id, labelText: e.name)))
          .toList(),
      selectedMenuEntries: widget.bloc.dropdownData.listProduct!
          .where((e) => [widget.bloc.data.children?[widget.itemIndex].childId]
              .any((u) => u == e.id))
          .map((e) => CDropdownMenuEntry(value: e.id, labelText: e.name))
          .toList(),
      disabledMenuEntries: widget.bloc.dropdownData.listProduct!
          .where((e) =>
              e.id == widget.bloc.data.id ||
              e.statusCode != 'Normal' ||
              e.typeCode == 'BundleProduct')
          .map((e) => CDropdownMenuEntry(value: e.id, labelText: e.name))
          .toList(),
      onSelected: (selected) {
        setState(() {
          if (quantity == 0) {
            quantity = 1;
            quantityController.text = quantity.toString();
          }
          selectedProduct = widget.bloc.dropdownData.listProduct!
              .where((e) => selected.any((u) => u.value == e.id))
              .firstOrNull;
          if (selectedProduct != null) {
            widget.bloc.eventController.add(
                ChangeChildProductId(widget.itemIndex, selectedProduct!.id!));
          }
        });
      },
    );

    var productQuantityWidget = SizedBox(
      width: 150,
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    if (quantity >= 1 &&
                        widget.bloc.screenMode.state == ScreenModeEnum.edit) {
                      quantity -= 1;
                      quantityController.text = quantity.toString();
                      widget.bloc.eventController.add(
                          ChangeChildProductQuantity(
                              widget.itemIndex, quantity));
                    }
                  }),
              Expanded(
                child: CTextFormField(
                  labelText: sharedPrefs.translate('Qty'),
                  keyboardType: TextInputType.number,
                  controller: quantityController,
                  labelTextAsHint: true,
                  textAlign: TextAlign.end,
                  isDense: true,
                  readOnly: widget.bloc.screenMode.state == ScreenModeEnum.edit
                      ? false
                      : true,
                  onChanged: (value) {
                    if (!value.isAlphabetOnly) {
                      try {
                        quantity = double.parse(value);
                        if (quantity <= 0) {
                          kShowAlert(
                              body: Text(sharedPrefs.translate(
                                  'Quantity must be better than 0')));
                        }
                        quantityController.text = quantity.toString();
                        widget.bloc.eventController.add(
                            ChangeChildProductQuantity(
                                widget.itemIndex, quantity));
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
              IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    if (widget.bloc.screenMode.state == ScreenModeEnum.edit) {
                      quantity += 1;
                      quantityController.text = quantity.toString();
                      widget.bloc.eventController.add(
                          ChangeChildProductQuantity(
                              widget.itemIndex, quantity));
                    }
                  }),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CText(
                child?.unitText ?? selectedProduct?.unitText ?? '',
                style: const TextStyle(fontSize: smallTextSize),
              ),
              const SizedBox(width: 55)
            ],
          ),
        ],
      ),
    );

    Widget categoryWidget = selectedProduct?.categoryText == null
        ? const SizedBox()
        : CText(
            '${sharedPrefs.translate('Category')}: ${selectedProduct?.categoryText}',
            style: const TextStyle(fontSize: smallTextSize),
          );

    Widget typeWidget = selectedProduct?.typeText == null
        ? const SizedBox()
        : CText(
            '${sharedPrefs.translate('Type')}: ${selectedProduct?.typeText}',
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

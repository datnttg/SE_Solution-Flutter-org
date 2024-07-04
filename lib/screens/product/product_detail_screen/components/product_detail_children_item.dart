import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utilities/app_service.dart';
import '../../../../utilities/classes/custom_widget_models.dart';
import '../../../../utilities/custom_widgets.dart';
import '../../../../utilities/enums/ui_enums.dart';
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

  ProductFilterItemModel? child;
  double quantity = 0.0;
  List<CDropdownMenuEntry> dropdownMenuEntries = [];
  List<CDropdownMenuEntry> selectedMenuEntries = [];
  List<CDropdownMenuEntry> disabledMenuEntries = [];

  // void initData() {
  //   if (widget.bloc.data.children?.isNotEmpty ?? false) {
  //     child = widget.bloc.dropdownData.listProduct!
  //         .where((e) =>
  //             e.id == widget.bloc.data.children?[widget.itemIndex].childId)
  //         .firstOrNull;
  //     quantity =
  //         widget.bloc.data.children?[widget.itemIndex].quantityOfChild ?? 0;
  //   } else {
  //     child = null;
  //     quantity = 0;
  //   }
  // }

  void setData() {
    if (widget.bloc.data.children?.isNotEmpty ?? false) {
      child = widget.bloc.lstProduct
          .where((e) =>
              e.id == widget.bloc.data.children?[widget.itemIndex].childId)
          .firstOrNull;
      quantity =
          widget.bloc.data.children?[widget.itemIndex].quantityOfChild ?? 0;
    } else {
      child = null;
      quantity = 0;
    }
    quantityController.text =
        (widget.bloc.data.children?[widget.itemIndex].quantityOfChild ?? 0)
            .toString();
    dropdownMenuEntries = (widget.bloc.lstProduct
            .map((e) => CDropdownMenuEntry(value: e.id, labelText: e.name)))
        .toList();
    disabledMenuEntries = widget.bloc.lstProduct
        .where((e) =>
            e.id == widget.bloc.data.id ||
            e.statusCode != 'Normal' ||
            e.typeCode == 'BundleProduct' ||
            (widget.bloc.data.children?.any((u) => u.childId == e.id) ?? false))
        .map((e) => CDropdownMenuEntry(value: e.id, labelText: e.name))
        .toList();
    selectedMenuEntries = widget.bloc.lstProduct
        .where((e) => [widget.bloc.data.children?[widget.itemIndex].childId]
            .any((u) => u == e.id))
        .map((e) => CDropdownMenuEntry(value: e.id, labelText: e.name))
        .toList();
  }

  @override
  void initState() {
    // initData();
    setData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.bloc.eventController.stream.listen((event) {
      if (event is ChangeChildProductId) {
        setData();
      }
    });

    var productNameWidget = CDropdownMenu(
      labelText: sharedPrefs.translate('Select product'),
      labelTextAsHint: true,
      showDivider: false,
      enableSearch: true,
      menuHeight: 200,
      readOnly: widget.bloc.screenMode.state == ScreenModeEnum.view,
      dropdownMenuEntries: dropdownMenuEntries,
      disabledMenuEntries: disabledMenuEntries,
      selectedMenuEntries: selectedMenuEntries,
      onSelected: (selected) {
        setState(() {
          if (quantity == 0) {
            quantity = 1;
            quantityController.text = quantity.toString();
          }
          child = widget.bloc.lstProduct
              .where((e) => selected.any((u) => u.value == e.id))
              .firstOrNull;
          if (child != null) {
            widget.bloc.eventController
                .add(ChangeChildProductId(widget.itemIndex, child!.id!));
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

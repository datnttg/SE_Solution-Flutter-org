import 'package:flutter/material.dart';
import '../../../../utilities/app_service.dart';
import '../../../../utilities/classes/custom_widget_models.dart';
import '../../../../utilities/custom_widgets.dart';
import '../../../../utilities/responsive.dart';
import '../../../../utilities/shared_preferences.dart';
import '../../../../utilities/ui_styles.dart';
import '../../product_filter_screen/models/product_filter_item_model.dart';
import '../../product_filter_screen/models/product_filter_parameter_model.dart';
import '../../product_filter_screen/services/product_filter_services.dart';
import '../bloc/product_detail_bloc.dart';
import '../bloc/product_detail_events.dart';
import '../models/product_detail_model.dart';

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
  final quantityController = TextEditingController(text: '1.0');

  var quantity = 1.0;
  ProductDetailModel? child;
  ProductFilterItemModel? selectedProduct;

  Future<void> _loadProductDetails() async {
    if (widget.bloc.data.children != null) {
      final fetchedChild = await fetchProductDetail(
          widget.bloc.data.children![widget.itemIndex].childId ?? '');
      setState(() {
        child = fetchedChild;
      });
    }
  }

  @override
  void initState() {
    _loadProductDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var productNameWidget = Column(
      children: [
        FutureBuilder(
            future: fetchProductListModel(
                ProductFilterParameters(statusCode: 'Normal')),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return CDropdownMenu(
                  labelText: sharedPrefs.translate('Product'),
                  labelTextAsHint: true,
                  enableSearch: true,
                  showDivider: false,
                  menuHeight: 200,
                  dropdownMenuEntries: snapshot.data!
                      .map((e) =>
                          CDropdownMenuEntry(value: e.id, labelText: e.name))
                      .toList(),
                  selectedMenuEntries: snapshot.data!
                      .where((e) => [
                            widget.bloc.data.children?[widget.itemIndex].childId
                          ].any((u) => u == e.id))
                      .map((e) =>
                          CDropdownMenuEntry(value: e.id, labelText: e.name))
                      .toList(),
                  onSelected: (selected) {
                    setState(() {
                      selectedProduct = snapshot.data!
                          .where((e) => selected.any((u) => u.value == e.id))
                          .first;
                      widget.bloc.eventController.add(ChangeChildProductId(
                          widget.itemIndex, selectedProduct!.id!));
                    });
                  },
                );
              }
              return COnLoadingDropdownMenu(
                labelText: sharedPrefs.translate('Loading...'),
                labelTextAsHint: true,
                showDivider: false,
              );
            }),
      ],
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
                    quantity -= 1;
                    quantityController.text = quantity.toString();
                    widget.bloc.eventController.add(
                        ChangeChildProductQuantity(widget.itemIndex, quantity));
                  }),
              Expanded(
                child: CTextFormField(
                  labelText: sharedPrefs.translate('Qty'),
                  keyboardType: TextInputType.number,
                  controller: quantityController,
                  labelTextAsHint: true,
                  textAlign: TextAlign.end,
                  isDense: true,
                  onChanged: (value) {
                    try {
                      quantity = double.parse(value);
                    } catch (ex) {
                      kShowAlert(
                          body: Text(sharedPrefs
                              .translate('Quantity must be a number')));
                    }
                    quantityController.text = quantity.toString();
                    widget.bloc.eventController.add(
                        ChangeChildProductQuantity(widget.itemIndex, quantity));
                  },
                ),
              ),
              IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    quantity += 1;
                    quantityController.text = quantity.toString();
                    widget.bloc.eventController.add(
                        ChangeChildProductQuantity(widget.itemIndex, quantity));
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
              const SizedBox(width: 50)
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

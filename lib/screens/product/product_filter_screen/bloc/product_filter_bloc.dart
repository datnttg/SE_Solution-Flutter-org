import 'dart:async';

import '../models/product_filter_parameter_model.dart';
import 'product_filter_events.dart';
import '../services/product_filter_services.dart';
import 'product_filter_states.dart';

class ProductFilterBloc {
  final eventController = StreamController<ProductFilterEvents>();
  final stateController = StreamController<ProductListState>.broadcast();
  final selectionController = StreamController<SelectionState>.broadcast();

  var params = ProductFilterParameters();
  String? selectedProductId;

  ProductFilterBloc() {
    eventController.stream.listen((event) {
      if (event is ChangeProductCode) {
        params.code = event.productCode;
      } else if (event is ChangeProductName) {
        params.name = event.productName;
      } else if (event is ChangeProductType) {
        params.typeCodes = event.typeCodes!.isNotEmpty
            ? event.typeCodes!.map<String>((e) => e.value).toList()
            : null;
      } else if (event is ChangeProductCategory) {
        params.categoryCodes = event.categoryCodes!.isNotEmpty
            ? event.categoryCodes!.map<String>((e) => e.value).toList()
            : null;
      } else if (event is ChangeSelectedProduct) {
        selectedProductId = event.productId;
        selectionController.add(SelectionState(productId: event.productId));
      }
      loadData();
    });
  }

  void loadData() async {
    var data = await fetchProductListModel(params);
    if (data.isNotEmpty) {
      stateController.sink.add(ProductListState(products: data));
    } else {
      stateController.sink.add(ProductListState(products: null));
    }
  }

  void dispose() {
    eventController.close();
    stateController.close();
  }
}

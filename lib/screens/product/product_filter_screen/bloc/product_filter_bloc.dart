import 'dart:async';

import '../models/product_filter_parameter_model.dart';
import 'product_filter_events.dart';
import '../services/product_filter_services.dart';
import 'product_filter_states.dart';

class ProductFilterBloc {
  final eventController = StreamController<ProductFilterEvents>.broadcast();
  final stateController = StreamController<ProductListState>.broadcast();

  void dispose() {
    eventController.close();
    stateController.close();
  }

  var params = ProductFilterParameters();
  var selectionState = SelectionState(productId: null);

  ProductFilterBloc() {
    eventController.stream.listen((event) {
      if (event is ChangeProductCode) {
        params.code = event.productCode;
        loadData();
      } else if (event is ChangeProductName) {
        params.name = event.productName;
        loadData();
      } else if (event is ChangeProductType) {
        params.typeCodes = event.typeCodes!.isNotEmpty
            ? event.typeCodes!.map<String>((e) => e.value).toList()
            : null;
        loadData();
      } else if (event is ChangeProductCategory) {
        params.categoryCodes = event.categoryCodes!.isNotEmpty
            ? event.categoryCodes!.map<String>((e) => e.value).toList()
            : null;
        loadData();
      } else if (event is ChangeSelectedProduct) {
        selectionState = SelectionState(productId: event.productId);
      }
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
}

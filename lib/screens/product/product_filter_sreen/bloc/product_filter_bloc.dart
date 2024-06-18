import 'dart:async';

import '../models/product_filter_parameter_model.dart';
import 'product_filter_events.dart';
import '../services/product_filter_services.dart';
import 'product_filter_states.dart';

class ProductFilterBloc {
  final StreamController eventController = StreamController();
  final StreamController stateController = StreamController.broadcast();

  var params = ProductFilterParameters();

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
      }
      loadData();
    });
  }

  void loadData() async {
    var data = await fetchProductList(params);
    if (data.isNotEmpty) {
      stateController.sink.add(ProductListState(data));
    } else {
      stateController.sink.add(ProductListState(null));
    }
  }

  void dispose() {
    eventController.close();
    stateController.close();
  }
}

import 'dart:async';

import '../../product_detail_screen/models/product_detail_model.dart';
import '../../product_detail_screen/services/fetch_data_service.dart';
import '../models/product_filter_parameter_model.dart';
import 'product_filter_events.dart';
import '../services/product_filter_services.dart';
import 'product_filter_states.dart';

class ProductFilterBloc {
  final eventController = StreamController<ProductFilterEvents>();
  final stateController = StreamController<ProductListState>.broadcast();
  final selectionController = StreamController<SelectionState>.broadcast();

  void dispose() {
    eventController.close();
    stateController.close();
    selectionController.close();
  }

  var params = ProductFilterParameters();
  var selectionState = SelectionState();

  ProductFilterBloc() {
    eventController.stream.listen((event) {
      if (event is ChangeProductFilterCode) {
        params.code = event.productCode;
        loadData();
      } else if (event is ChangeProductFilterName) {
        params.name = event.productName;
        loadData();
      } else if (event is ChangeProductFilterType) {
        params.typeCodes = event.typeCodes!.isNotEmpty
            ? event.typeCodes!.map<String>((e) => e.value).toList()
            : null;
        loadData();
      } else if (event is ChangeProductFilterCategory) {
        params.categoryCodes = event.categoryCodes!.isNotEmpty
            ? event.categoryCodes!.map<String>((e) => e.value).toList()
            : null;
        loadData();
      } else if (event is ChangeFilterSelectedProduct) {
        loadSelectionDetail(event.productId);
      }
    });
  }

  void init() {
    loadData();
  }

  void loadData() async {
    var data = await fetchProductListModel(params);
    if (data.isNotEmpty) {
      stateController.add(ProductListState(products: data));
    } else {
      stateController.add(ProductListState(products: null));
    }
  }

  void loadSelectionDetail(String? productId) async {
    var productDetailModel = ProductDetailModel(
        typeCode: 'SingleProduct', statusCode: 'Normal', children: []);
    if (productId?.isNotEmpty ?? false) {
      var productDetail = await fetchProductDetail(productId!);
      if (productDetail != null) {
        productDetailModel = productDetail;
      }
    }
    selectionState =
        SelectionState(productId: productId, productDetail: productDetailModel);
    selectionController.add(selectionState);
  }
}

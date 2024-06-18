import 'dart:async';

import '../services/fetch_data_service.dart';
import 'product_detail_events.dart';
import 'product_detail_states.dart';

class ProductDetailBloc {
  var eventController = StreamController<ChangeProductDetailEvents>();

  var params = ProductDetailStates();

  ProductDetailBloc() {
    eventController.stream.listen((event) {
      if (event is ChangeProductCategory) {
        params.categoryCode = event.category;
      } else if (event is ChangeProductUnit) {
        params.unitCode = event.unit;
      } else if (event is ChangeProductType) {
        params.typeCode = event.type;
      } else if (event is ChangeProductCode) {
        params.code = event.code;
      } else if (event is ChangeProductName) {
        params.name = event.name;
      } else if (event is ChangeProductUnit) {
        params.unitCode = event.unit;
      } else if (event is ChangeProductDescription) {
        params.description = event.description;
      } else if (event is ChangeProductMonthsOfWarranty) {
        params.monthsOfWarranty = event.monthsOfWarranty;
      } else if (event is ChangeProductMinPrice) {
        params.minPrice = event.minPrice;
      } else if (event is ChangeProductChildren) {
        params.children = event.children;
      }
    });
  }

  void postData() async {
    await postProductDetail(params);
  }

  void dispose() {
    eventController.close();
  }
}

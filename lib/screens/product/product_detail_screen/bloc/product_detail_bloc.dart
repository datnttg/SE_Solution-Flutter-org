import 'dart:async';

import 'package:se_solution/screens/product/product_detail_screen/models/product_detail_model.dart';
import 'package:se_solution/utilities/enums/ui_enums.dart';

import '../services/fetch_data_service.dart';
import 'product_detail_events.dart';
import 'product_detail_states.dart';

class ProductDetailBloc {
  var eventController = StreamController<ChangeProductDetailEvents>();
  var stateController = StreamController<ProductDetailState>.broadcast();
  var screenModeController = StreamController<ScreenModeState>.broadcast();

  var state = ProductDetailState(
    productDetail: ProductDetailModel(typeCode: 'SingleProduct'),
  );

  var screenMode = ScreenModeState(screenMode: ScreenModeEnum.view);

  ProductDetailBloc() {
    eventController.stream.listen((event) {
      if (event is ChangeScreenMode) {
        screenMode.screenMode = event.screenMode;
      } else if (event is ChangeProductCategory) {
        state.productDetail.categoryCode = event.category;
      } else if (event is ChangeProductUnit) {
        state.productDetail.unitCode = event.unit;
      } else if (event is ChangeProductType) {
        state.productDetail.typeCode = event.type;
        state.productDetail.children = null;
      } else if (event is ChangeProductCode) {
        state.productDetail.code = event.code;
        print(state.productDetail.code);
      } else if (event is ChangeProductName) {
        state.productDetail.name = event.name;
      } else if (event is ChangeProductUnit) {
        state.productDetail.unitCode = event.unit;
      } else if (event is ChangeProductDescription) {
        state.productDetail.description = event.description;
      } else if (event is ChangeProductMonthsOfWarranty) {
        state.productDetail.monthsOfWarranty = event.monthsOfWarranty;
      } else if (event is ChangeProductMinPrice) {
        state.productDetail.minPrice = event.minPrice;
      } else if (event is ChangeProductChildren) {
        state.children = event.children;
      }
      stateController.add(state);
      screenModeController.add(screenMode);
    });
    screenModeController.add(screenMode);
  }

  void postData() async {
    await postProductDetail(state);
  }

  void dispose() {
    eventController.close();
  }
}

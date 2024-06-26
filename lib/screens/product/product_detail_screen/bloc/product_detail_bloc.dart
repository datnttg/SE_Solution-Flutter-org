import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utilities/app_service.dart';
import '../../../../utilities/enums/ui_enums.dart';
import '../../../../utilities/shared_preferences.dart';
import '../models/child_product_model.dart';
import '../models/product_detail_model.dart';
import '../services/fetch_data_service.dart';
import 'product_detail_events.dart';
import 'product_detail_states.dart';

class ProductDetailBloc {
  var eventController = StreamController<ChangeProductDetailEvents>();
  var uiController = StreamController<ScreenModeState>.broadcast();
  var dataController = StreamController<ProductDetailModel>.broadcast();
  var dropdownDataController =
      StreamController<ProductDetailDataState>.broadcast();

  var screenMode = ScreenModeState(state: ScreenModeEnum.view);
  var data = ProductDetailModel(typeCode: 'SingleProduct', children: []);
  var blankChild = ChildProductModel();
  var dropdownData = ProductDetailDataState();

  ProductDetailBloc() {
    eventController.stream.listen((event) {
      try {
        /// CHANGE SCREEN MODE
        if (event is ChangeScreenMode) {
          screenMode.state = event.screenMode;
          uiController.add(screenMode);
        }

        /// LOAD DETAIL
        else if (event is LoadData) {
          dropdownData.listProduct = event.listProduct;
          dropdownData.listUnit = event.listUnit;
          dropdownData.listStatus = event.listStatus;
          dropdownData.listCategory = event.listCategory;
          dropdownData.listType = event.listType;
          if (event.detail?.id != null) {
            data = event.detail!;
            uiController.add(ScreenModeState(state: ScreenModeEnum.view));
          }

          dropdownDataController.add(dropdownData);
        }

        /// SUBMIT
        else if (event is SubmitData) {
          postData();
        }

        /// CHANGE PRODUCT DETAIL
        else if (event is ChangeProductCategory) {
          data.categoryCode = event.category;
        } else if (event is ChangeProductUnit) {
          data.unitCode = event.unit;
        } else if (event is ChangeProductType) {
          data.typeCode = event.type;
          uiController.add(screenMode);
        } else if (event is ChangeProductCode) {
          data.code = event.code;
        } else if (event is ChangeProductName) {
          data.name = event.name;
        } else if (event is ChangeProductUnit) {
          data.unitCode = event.unit;
        } else if (event is ChangeProductRequiredSerial) {
          data.serialRequired = event.require;
          uiController.add(screenMode);
        } else if (event is ChangeProductDescription) {
          data.description = event.description;
        } else if (event is ChangeProductMonthsOfWarranty) {
          if (!event.monthsOfWarranty!.isNum) {
            throw Exception(sharedPrefs.translate('Warranty must be a number'));
          }
          var monthsOfWarranty = int.parse(event.monthsOfWarranty!);
          data.monthsOfWarranty = monthsOfWarranty;
        } else if (event is ChangeProductMinPrice) {
          data.minPrice = event.minPrice;
        }

        /// CHANGE CHILDREN PRODUCTS
        else if (event is ChangeChildrenProducts) {
          data.children = event.children;
        }

        /// CHANGE CHILD PRODUCT DETAIL
        else if (event is ChangeChildProductId) {
          try {
            data.children?[event.item].childId = event.productId;
          } catch (ex) {
            data.children?.add(ChildProductModel(
              childId: event.productId,
              quantityOfChild: 0,
            ));
          }
        } else if (event is ChangeChildProductQuantity) {
          data.children?[event.item].quantityOfChild = event.quantity;
        } else if (event is RemoveChildProduct) {
          data.children?.removeAt(event.item);
        }

        dataController.add(data);
      } catch (ex) {
        kShowAlert(
            title: sharedPrefs.translate('Invalid format'),
            body: Text(ex.toString()));
      }
    });
  }

  void postData() async {
    await postProductDetail(data);
  }

  void dispose() {
    eventController.close();
  }
}

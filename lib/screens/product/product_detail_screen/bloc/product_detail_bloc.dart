import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utilities/app_service.dart';
import '../../../../utilities/enums/ui_enums.dart';
import '../../../../utilities/shared_preferences.dart';
import '../../product_filter_screen/models/product_filter_item_model.dart';
import '../models/child_product_model.dart';
import '../models/product_detail_model.dart';
import '../services/fetch_data_service.dart';
import 'product_detail_events.dart';
import 'product_detail_states.dart';

class ProductDetailBloc {
  final eventController =
      StreamController<ChangeProductDetailEvents>.broadcast();
  final uiController = StreamController<ChangeProductDetailEvents>.broadcast();
  final dataController = StreamController<ProductDetailModel>.broadcast();
  final dropdownDataController =
      StreamController<ProductDetailDataState>.broadcast();

  void dispose() {
    eventController.close();
    dataController.close();
    dropdownDataController.close();
  }

  var screenMode = ScreenModeState(ScreenModeEnum.view);
  final initData = ProductDetailModel(
      typeCode: 'SingleProduct', statusCode: 'Normal', children: []);
  var data = ProductDetailModel(
      typeCode: 'SingleProduct', statusCode: 'Normal', children: []);
  List<ProductFilterItemModel> lstProduct = [];
  var dropdownData = ProductDetailDataState();

  ProductDetailBloc() {
    eventController.stream.listen((event) async {
      try {
        /// CHANGE SCREEN MODE
        if (event is ChangeScreenMode) {
          screenMode.state = event.screenMode;
          uiController.add(ChangeScreenMode(event.screenMode));
          dataController.add(data);
          dropdownDataController.add(dropdownData);
        }

        /// LOAD DETAIL
        else if (event is ReloadData) {
          await loadData(productId: event.productId);
          await loadDropdownData();
          // } else if (event is LoadData) {
          //   data = event.detail;
          //   lstProduct = event.listProduct;
          //   dataController.add(data);
          // } else if (event is LoadDropdownData) {
          //   dropdownData.listUnit = event.listUnit;
          //   dropdownData.listStatus = event.listStatus;
          //   dropdownData.listCategory = event.listCategory;
          //   dropdownData.listType = event.listType;
          //   dropdownDataController.add(dropdownData);
        }

        /// SUBMIT
        else if (event is SubmitData) {
          submitData();
        }

        /// CHANGE PRODUCT DETAIL
        else if (event is ChangeProductCategory) {
          data.categoryCode = event.category;
        } else if (event is ChangeProductUnit) {
          data.unitCode = event.unit;
        } else if (event is ChangeProductType) {
          if (event.type == 'SingleProduct') {
            data.children = [];
          }
          data.typeCode = event.type;
          uiController.add(ChangeScreenMode(screenMode.state));
          dropdownDataController.add(dropdownData);
        } else if (event is ChangeProductCode) {
          data.code = event.code;
        } else if (event is ChangeProductName) {
          data.name = event.name;
        } else if (event is ChangeProductUnit) {
          data.unitCode = event.unit;
        } else if (event is ChangeProductStatus) {
          data.statusCode = event.status;
        } else if (event is ChangeProductRequiredSerial) {
          data.serialRequired = event.require;
          eventController.add(ChangeScreenMode(screenMode.state));
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
            data.children?[event.item].childId = event.childProductId;
            dataController.add(data);
          } catch (ex) {
            data.children?.add(ChildProductModel(
              childId: event.childProductId,
              quantityOfChild: 0,
            ));
          }
        } else if (event is ChangeChildProductQuantity) {
          data.children?[event.item].quantityOfChild = event.quantity;
        } else if (event is RemoveChildProduct) {
          data.children?.removeAt(event.item);
        }
      } catch (ex) {
        kShowAlert(
            title: sharedPrefs.translate('Invalid format'),
            body: Text(ex.toString()));
      }
    });
  }

  void resetData() {
    data = initData;
    dataController.add(data);
  }

  Future<bool> loadData({String? productId}) async {
    try {
      resetData();
      var listProduct = await fetchProductList();
      var productDetailModel = ProductDetailModel(
          typeCode: 'SingleProduct', statusCode: 'Normal', children: []);
      if (productId?.isNotEmpty ?? false) {
        var productDetail = await fetchProductDetail(productId!);
        if (productDetail != null) {
          productDetailModel = productDetail;
        }
        // eventController.add(LoadData(
        //   detail: productDetailModel,
        //   listProduct: listProduct,
        // ));
        data = productDetailModel;
        lstProduct = listProduct;
        dataController.add(data);
      }
      return true;
    } catch (ex) {
      return false;
    }
  }

  Future<bool> loadDropdownData() async {
    try {
      var lstUnit = await fetchProductCategory(categoryProperty: 'ProductUnit');
      var lstStatus =
          await fetchProductCategory(categoryProperty: 'ProductStatus');
      var lstCategory =
          await fetchProductCategory(categoryProperty: 'ProductCategory');
      var lstType = await fetchProductCategory(categoryProperty: 'ProductType');
      dropdownData = ProductDetailDataState(
        listUnit: lstUnit,
        listStatus: lstStatus,
        listCategory: lstCategory,
        listType: lstType,
      );
      dropdownDataController.add(dropdownData);
      return true;
    } catch (ex) {
      return false;
    }
  }

  Future<bool> init({String? productId}) async {
    try {
      if (productId?.isNotEmpty ?? false) {
        eventController.add(ChangeScreenMode(ScreenModeEnum.view));
      } else {
        eventController.add(ChangeScreenMode(ScreenModeEnum.edit));
      }
      resetData();
      await loadData(productId: productId);
      await loadDropdownData();
      return true;
    } catch (ex) {
      return false;
    }
  }

  void submitData() async {
    var productId = await submitProductDetail(data);
    if (productId != null) {
      data.id = productId;
      eventController.add(ChangeScreenMode(ScreenModeEnum.view));
    }
  }
}

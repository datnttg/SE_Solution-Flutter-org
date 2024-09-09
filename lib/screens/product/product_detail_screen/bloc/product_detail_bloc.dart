import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se_solution/utilities/enums/ui_enums.dart';

import '../models/child_product_model.dart';
import '../models/product_detail_model.dart';
import '../services/fetch_data_service.dart';
import 'product_detail_events.dart';
import 'product_detail_states.dart';

class ProductDetailBloc
    extends Bloc<ChangeProductDetailEvents, ProductDetailState> {
  static final initialState = ProductDetailState(
    loadingStatus: ProductDetailLoadingStatus.initial,
    screenMode: ScreenModeEnum.view,
    productDetail: ProductDetailModel(
      typeCode: 'SingleProduct',
      statusCode: 'Normal',
      children: [],
    ),
    lstProduct: [],
    lstCategory: [],
    lstStatus: [],
    lstType: [],
    lstUnit: [],
  );

  ProductDetailBloc() : super(initialState) {
    on<ChangeScreenMode>(_onScreenModeChanged);
    on<ProductIdChanged>(_onProductIdChanged);
    on<ProductCodeChanged>(_onProductCodeChanged);
    on<ProductNameChanged>(_onProductNameChanged);
    on<ProductUnitChanged>(_onProductUnitChanged);
    on<ProductDescriptionChanged>(_onProductDescriptionChanged);
    on<ProductStatusChanged>(_onProductStatusChanged);
    on<ProductCategoryChanged>(_onProductCategoryChanged);
    on<ProductTypeChanged>(_onProductTypeChanged);
    on<ProductSerialRequiredChanged>(_onProductSerialRequiredChanged);
    on<ProductMonthsOfWarrantyChanged>(_onProductMonthsOfWarrantyChanged);
    on<ProductMinPriceChanged>(_onProductMinPriceChanged);
    on<ChildProductRemoved>(_onChildProductRemoved);
    on<ChildProductAdded>(_onChildProductAdded);
    on<ChildProductIdChanged>(_onChildProductIdChanged);
    on<ChildProductQuantityChanged>(_onChildProductQuantityChanged);
  }

  void _onScreenModeChanged(
      ChangeScreenMode event, Emitter<ProductDetailState> emit) {
    emit(state.copyWith(screenMode: event.screenMode));
  }

  Future<void> _onProductIdChanged(
      ProductIdChanged event, Emitter<ProductDetailState> emit) async {
    emit(initialState);

    ProductDetailModel? productDetail;
    if (event.id != null && event.id!.isNotEmpty) {
      productDetail = await fetchProductDetail(event.id!);
    }

    var listProduct = await fetchProductList();
    var listUnit = await fetchProductCategory(categoryProperty: 'ProductUnit');
    var listStatus =
        await fetchProductCategory(categoryProperty: 'ProductStatus');
    var listCategory =
        await fetchProductCategory(categoryProperty: 'ProductCategory');
    var listType = await fetchProductCategory(categoryProperty: 'ProductType');
    var data = state.copyWith(
      screenMode: event.id == '' ? ScreenModeEnum.edit : state.screenMode,
      lstProduct: listProduct,
      lstCategory: listCategory,
      lstStatus: listStatus,
      lstType: listType,
      lstUnit: listUnit,
      productDetail: productDetail,
      loadingStatus: ProductDetailLoadingStatus.success,
    );
    emit(data);
  }

  Future<void> _onProductCodeChanged(
      ProductCodeChanged event, Emitter<ProductDetailState> emit) async {
    state.productDetail.code = event.code;
    emit(state.copyWith(
        productDetail: state.productDetail.copyWith(code: event.code)));
  }

  Future<void> _onProductNameChanged(
      ProductNameChanged event, Emitter<ProductDetailState> emit) async {
    emit(state.copyWith(
        productDetail: state.productDetail.copyWith(name: event.name)));
  }

  Future<void> _onProductUnitChanged(
      ProductUnitChanged event, Emitter<ProductDetailState> emit) async {
    emit(state.copyWith(
        productDetail: state.productDetail.copyWith(unitCode: event.unit)));
  }

  Future<void> _onProductDescriptionChanged(
      ProductDescriptionChanged event, Emitter<ProductDetailState> emit) async {
    emit(state.copyWith(
        productDetail:
            state.productDetail.copyWith(description: event.description)));
  }

  Future<void> _onProductStatusChanged(
      ProductStatusChanged event, Emitter<ProductDetailState> emit) async {
    emit(state.copyWith(
        productDetail: state.productDetail.copyWith(statusCode: event.status)));
  }

  Future<void> _onProductCategoryChanged(
      ProductCategoryChanged event, Emitter<ProductDetailState> emit) async {
    emit(state.copyWith(
        productDetail:
            state.productDetail.copyWith(categoryCode: event.category)));
  }

  Future<void> _onProductTypeChanged(
      ProductTypeChanged event, Emitter<ProductDetailState> emit) async {
    emit(state.copyWith(
        productDetail: state.productDetail.copyWith(typeCode: event.type)));
  }

  Future<void> _onProductSerialRequiredChanged(
      ProductSerialRequiredChanged event,
      Emitter<ProductDetailState> emit) async {
    emit(state.copyWith(
        productDetail: state.productDetail
            .copyWith(serialRequired: event.serialRequired)));
  }

  Future<void> _onProductMonthsOfWarrantyChanged(
      ProductMonthsOfWarrantyChanged event,
      Emitter<ProductDetailState> emit) async {
    emit(state.copyWith(
        productDetail: state.productDetail
            .copyWith(monthsOfWarranty: event.monthsOfWarranty)));
  }

  Future<void> _onProductMinPriceChanged(
      ProductMinPriceChanged event, Emitter<ProductDetailState> emit) async {
    emit(state.copyWith(
        productDetail: state.productDetail.copyWith(minPrice: event.minPrice)));
  }

  Future<void> _onChildProductRemoved(
      ChildProductRemoved event, Emitter<ProductDetailState> emit) async {
    state.productDetail.children!.removeAt(event.item);
    emit(state.copyWith(
        productDetail: state.productDetail
            .copyWith(children: state.productDetail.children)));
  }

  void _onChildProductAdded(
      ChildProductAdded event, Emitter<ProductDetailState> emit) {
    if (event.childProduct.childId != null) {
      List<ChildProductModel> children = state.productDetail.children ?? [];
      children.add(event.childProduct);
      state.copyWith(
          productDetail: state.productDetail.copyWith(children: children));
    }
    emit(state);
  }

  Future<void> _onChildProductIdChanged(
      ChildProductIdChanged event, Emitter<ProductDetailState> emit) async {
    state.productDetail.children?[event.item].childId = event.childProductId;
    emit(state.copyWith(
        productDetail: state.productDetail
            .copyWith(children: state.productDetail.children)));
  }

  Future<void> _onChildProductQuantityChanged(ChildProductQuantityChanged event,
      Emitter<ProductDetailState> emit) async {
    List<ChildProductModel>? children = state.productDetail.children;
    if (event.quantity >= 0) {
      children?[event.item].quantityOfChild = event.quantity;
    }
    emit(state.copyWith(
        productDetail: state.productDetail.copyWith(children: children)));
  }
}

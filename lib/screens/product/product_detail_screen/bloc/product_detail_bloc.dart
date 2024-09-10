import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utilities/app_service.dart';
import '../../../../utilities/constants/core_constants.dart';
import '../../../../utilities/enums/ui_enums.dart';
import '../models/product_detail_model.dart';
import '../models/product_update_model.dart';
import '../services/fetch_data_service.dart';
import 'product_detail_events.dart';
import 'product_detail_states.dart';

final constants = Constants();

class ProductDetailBloc
    extends Bloc<ChangeProductDetailEvents, ProductDetailState> {
  static final initialState = ProductDetailState(
    screenMode: ScreenModeEnum.view,
    initialStatus: ProcessingStatusEnum.processing,
    productDetail: ProductDetailModel(
      typeCode: 'SingleProduct',
      statusCode: 'Normal',
      children: [],
    ),
    productUpdate: ProductUpdateModel(),
    loadingStatus: ProcessingStatusEnum.processing,
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
    on<ProductSaving>(_onProductSaving);
  }

  void _onScreenModeChanged(
      ChangeScreenMode event, Emitter<ProductDetailState> emit) {
    emit(state.copyWith(screenMode: event.screenMode));
  }

  Future<void> _onTProductDataInitializing(
      ProductDataInitializing event, Emitter<ProductDetailState> emit) async {
    emit(state.copyWith(
      initialStatus: ProcessingStatusEnum.processing,
      loadingStatus: ProcessingStatusEnum.processing,
    ));
    var listProduct = await fetchProductList();
    var listUnit = await fetchProductCategory(categoryProperty: 'ProductUnit');
    var listStatus =
        await fetchProductCategory(categoryProperty: 'ProductStatus');
    var listCategory =
        await fetchProductCategory(categoryProperty: 'ProductCategory');
    var listType = await fetchProductCategory(categoryProperty: 'ProductType');

    emit(state.copyWith(
      initialStatus: ProcessingStatusEnum.success,
      lstProduct: listProduct,
      lstCategory: listCategory,
      lstStatus: listStatus,
      lstType: listType,
      lstUnit: listUnit,
    ));
  }

  Future<void> _onProductIdChanged(
      ProductIdChanged event, Emitter<ProductDetailState> emit) async {
    await _onTProductDataInitializing(ProductDataInitializing(), emit);

    ProductDetailModel? productDetail;
    ProductUpdateModel? productUpdate;
    if (event.id != null && event.id!.isNotEmpty) {
      productDetail = await fetchProductDetail(event.id!);
      if (productDetail != null) {
        productUpdate = ProductUpdateModel.fromJson(productDetail.toMap());
      }
    }

    emit(state.copyWith(
      productDetail: productDetail,
      productUpdate: productUpdate,
      loadingStatus: ProcessingStatusEnum.success,
      screenMode: event.id == '' ? ScreenModeEnum.edit : ScreenModeEnum.view,
    ));
  }

  Future<void> _onProductCodeChanged(
      ProductCodeChanged event, Emitter<ProductDetailState> emit) async {
    state.productUpdate.code = event.code;
    emit(state.copyWith(
        productUpdate: state.productUpdate.copyWith(code: event.code)));
  }

  Future<void> _onProductNameChanged(
      ProductNameChanged event, Emitter<ProductDetailState> emit) async {
    emit(state.copyWith(
        productUpdate: state.productUpdate.copyWith(name: event.name)));
  }

  Future<void> _onProductUnitChanged(
      ProductUnitChanged event, Emitter<ProductDetailState> emit) async {
    emit(state.copyWith(
        productUpdate: state.productUpdate.copyWith(unitCode: event.unit)));
  }

  Future<void> _onProductDescriptionChanged(
      ProductDescriptionChanged event, Emitter<ProductDetailState> emit) async {
    emit(state.copyWith(
        productUpdate:
            state.productUpdate.copyWith(description: event.description)));
  }

  Future<void> _onProductStatusChanged(
      ProductStatusChanged event, Emitter<ProductDetailState> emit) async {
    emit(state.copyWith(
        productUpdate: state.productUpdate.copyWith(statusCode: event.status)));
  }

  Future<void> _onProductCategoryChanged(
      ProductCategoryChanged event, Emitter<ProductDetailState> emit) async {
    emit(state.copyWith(
        productUpdate:
            state.productUpdate.copyWith(categoryCode: event.category)));
  }

  Future<void> _onProductTypeChanged(
      ProductTypeChanged event, Emitter<ProductDetailState> emit) async {
    emit(state.copyWith(
        productUpdate: state.productUpdate.copyWith(typeCode: event.type)));
  }

  Future<void> _onProductSerialRequiredChanged(
      ProductSerialRequiredChanged event,
      Emitter<ProductDetailState> emit) async {
    emit(state.copyWith(
        productUpdate: state.productUpdate
            .copyWith(serialRequired: event.serialRequired)));
  }

  Future<void> _onProductMonthsOfWarrantyChanged(
      ProductMonthsOfWarrantyChanged event,
      Emitter<ProductDetailState> emit) async {
    emit(state.copyWith(
        productUpdate: state.productUpdate
            .copyWith(monthsOfWarranty: event.monthsOfWarranty)));
  }

  Future<void> _onProductMinPriceChanged(
      ProductMinPriceChanged event, Emitter<ProductDetailState> emit) async {
    emit(state.copyWith(
        productUpdate: state.productUpdate.copyWith(minPrice: event.minPrice)));
  }

  Future<void> _onChildProductRemoved(
      ChildProductRemoved event, Emitter<ProductDetailState> emit) async {
    state.productUpdate.children!.removeAt(event.item);
    emit(state.copyWith(
        productUpdate: state.productUpdate
            .copyWith(children: state.productUpdate.children)));
  }

  void _onChildProductAdded(
      ChildProductAdded event, Emitter<ProductDetailState> emit) {
    if (event.childProduct.childId != null) {
      List<ChildProductUpdateModel> children =
          state.productUpdate.children ?? [];
      children.add(event.childProduct);
      state.copyWith(
          productUpdate: state.productUpdate.copyWith(children: children));
    }
    emit(state);
  }

  Future<void> _onChildProductIdChanged(
      ChildProductIdChanged event, Emitter<ProductDetailState> emit) async {
    state.productUpdate.children?[event.item].childId = event.childProductId;
    emit(state.copyWith(
        productUpdate: state.productUpdate
            .copyWith(children: state.productUpdate.children)));
  }

  Future<void> _onChildProductQuantityChanged(ChildProductQuantityChanged event,
      Emitter<ProductDetailState> emit) async {
    List<ChildProductUpdateModel>? children = state.productUpdate.children;
    if (event.quantity >= 0) {
      children?[event.item].quantityOfChild = event.quantity;
    }
    emit(state.copyWith(
        productUpdate: state.productUpdate.copyWith(children: children)));
  }

  Future<void> _onProductSaving(
      ProductSaving event, Emitter<ProductDetailState> emit) async {
    var hostAddress = Uri.parse("${constants.hostAddress}/Product/Update");
    var response = await fetchDataUI(
      hostAddress,
      parameters: state.productUpdate.toMap(),
    );
    if (response['success'] == true) {
      add(ProductIdChanged(state.productDetail.id));
    }
  }
}

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/product_filter_parameter_model.dart';
import 'product_filter_events.dart';
import '../services/product_filter_services.dart';
import 'product_filter_states.dart';

class ProductFilterBloc extends Bloc<ProductFilterEvents, ProductFilterState> {
  static final initialState = ProductFilterState(
    products: [],
  );

  ProductFilterBloc() : super(initialState) {
    on<InitProductFilterData>(_loadData);
    on<ProductFilterDataLoaded>(_onDataLoaded);
    on<ProductFilterCodeChanged>(_changeProductCode);
    on<ProductFilterNameChanged>(_changeProductName);
    on<ProductFilterSelectedCategoriesChanged>(
        _changeProductSelectedCategories);
    on<ProductFilterSelectedTypesChanged>(_changeProductSelectedTypes);
    on<SelectedFilterProductChanged>(_changeSelectedProduct);
  }

  var params = ProductFilterParameters();
  Future<void> _loadData(
      InitProductFilterData? event, Emitter<ProductFilterState> emit) async {
    var productCategories =
        await fetchProductCategoryEntry(categoryProperty: 'ProductCategory');
    var productTypes =
        await fetchProductCategoryEntry(categoryProperty: 'ProductType');
    var products = await fetchProductListModel(params);
    emit(state.copyWith(
      loadingStatus: ProductFilterStatus.success,
      productCategories: productCategories,
      productTypes: productTypes,
      products: products,
    ));
  }

  void _onDataLoaded(
      ProductFilterDataLoaded event, Emitter<ProductFilterState> emit) {}

  Future<void> _changeProductCode(
      ProductFilterCodeChanged event, Emitter<ProductFilterState> emit) async {
    params.code = event.productCode;
    state.copyWith(productCode: event.productCode);
    await _loadData(null, emit);
  }

  Future<void> _changeProductName(
      ProductFilterNameChanged event, Emitter<ProductFilterState> emit) async {
    params.name = event.productName;
    state.copyWith(productName: event.productName);
    await _loadData(null, emit);
  }

  Future<void> _changeProductSelectedCategories(
      ProductFilterSelectedCategoriesChanged event,
      Emitter<ProductFilterState> emit) async {
    params.categoryCodes =
        event.selectedCategoryCodes?.map<String>((e) => e.value).toList() ?? [];
    state.copyWith(productCategories: event.selectedCategoryCodes);
    await _loadData(null, emit);
  }

  Future<void> _changeProductSelectedTypes(
      ProductFilterSelectedTypesChanged event,
      Emitter<ProductFilterState> emit) async {
    params.typeCodes =
        event.selectedTypeCodes?.map<String>((e) => e.value).toList() ?? [];
    state.copyWith(productTypes: event.selectedTypeCodes);
    await _loadData(null, emit);
  }

  void _changeSelectedProduct(
      SelectedFilterProductChanged event, Emitter<ProductFilterState> emit) {
    emit(state.copyWith(selectedId: event.productId));
  }

  String? getSelectedId() {
    return state.selectedId;
  }
}

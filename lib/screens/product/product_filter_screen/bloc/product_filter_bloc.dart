import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../utilities/enums/ui_enums.dart';
import '../models/product_filter_dropdowns_model.dart';
import '../models/product_filter_parameter_model.dart';
import 'product_filter_events.dart';
import '../services/product_filter_services.dart';
import 'product_filter_states.dart';

class ProductFilterBloc extends Bloc<ProductFilterEvents, ProductFilterState> {
  static final initialState = ProductFilterState(
    parameters: ProductFilterParameters(),
    dropdownData: ProductFilterDropdownsModel(),
    products: [],
  );

  ProductFilterBloc() : super(initialState) {
    on<InitProductFilterData>(_onInitData);
    on<ProductFilterCodeChanged>(_changeProductCode);
    on<ProductFilterNameChanged>(_changeProductName);
    on<ProductFilterCategoriesChanged>(_onProductFilterCategoriesChanged);
    on<ProductFilterTypesChanged>(_onProductFilterTypesChanged);
    on<ProductFilterSubmitted>(_onProductFilterSubmitted);
    on<SelectedFilterProductChanged>(_onSelectedFilterProductChanged);
  }

  Future<void> _onInitData(
      InitProductFilterData? event, Emitter<ProductFilterState> emit) async {
    var productCategories =
        await fetchProductCategoryEntry(categoryProperty: 'ProductCategory');
    var productTypes =
        await fetchProductCategoryEntry(categoryProperty: 'ProductType');

    emit(state.copyWith(
      initialStatus: ProcessingStatusEnum.success,
      dropdownData: ProductFilterDropdownsModel(
        productCategories: productCategories,
        productTypes: productTypes,
      ),
    ));
    add(ProductFilterSubmitted());
  }

  Future<void> _changeProductCode(
      ProductFilterCodeChanged event, Emitter<ProductFilterState> emit) async {
    emit(state.copyWith(
        parameters: state.parameters?.copyWith(code: event.productCode)));
    add(ProductFilterSubmitted());
  }

  Future<void> _changeProductName(
      ProductFilterNameChanged event, Emitter<ProductFilterState> emit) async {
    emit(state.copyWith(
        parameters: state.parameters?.copyWith(name: event.productName)));
    add(ProductFilterSubmitted());
  }

  Future<void> _onProductFilterCategoriesChanged(
      ProductFilterCategoriesChanged event,
      Emitter<ProductFilterState> emit) async {
    emit(state.copyWith(
        parameters: state.parameters?.copyWith(
            categoryCodes:
                event.categoryCodes?.map<String>((e) => e.value).toList() ??
                    [])));
    add(ProductFilterSubmitted());
  }

  Future<void> _onProductFilterTypesChanged(
      ProductFilterTypesChanged event, Emitter<ProductFilterState> emit) async {
    emit(state.copyWith(
        parameters: state.parameters?.copyWith(
            typeCodes:
                event.typeCodes?.map<String>((e) => e.value).toList() ?? [])));
    add(ProductFilterSubmitted());
  }

  Future<void> _onProductFilterSubmitted(
      ProductFilterSubmitted event, Emitter<ProductFilterState> emit) async {
    emit(state.copyWith(
      initialStatus: ProcessingStatusEnum.success,
      loadingStatus: ProcessingStatusEnum.processing,
    ));

    var products = await fetchProductListModel(state.parameters);
    emit(state.copyWith(
      products: products,
      initialStatus: ProcessingStatusEnum.success,
      loadingStatus: ProcessingStatusEnum.success,
    ));
  }

  void _onSelectedFilterProductChanged(
      SelectedFilterProductChanged event, Emitter<ProductFilterState> emit) {
    emit(state.copyWith(selectedId: event.productId));
  }

  String? getSelectedId() {
    return state.selectedId;
  }
}

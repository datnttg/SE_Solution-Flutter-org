import '../../../../utilities/enums/ui_enums.dart';
import '../models/product_filter_item_model.dart';
import '../models/product_filter_dropdowns_model.dart';
import '../models/product_filter_parameter_model.dart';

class ProductFilterState {
  ProductFilterParameters? parameters;

  ProcessingStatusEnum? initialStatus;
  ProductFilterDropdownsModel? dropdownData;

  ProcessingStatusEnum? loadingStatus;
  List<ProductFilterItemModel>? products;
  String? selectedId;

  ProductFilterState({
    this.initialStatus = ProcessingStatusEnum.processing,
    this.loadingStatus = ProcessingStatusEnum.processing,
    this.parameters,
    this.dropdownData,
    this.products,
    this.selectedId,
  });

  ProductFilterState copyWith({
    ProductFilterParameters? parameters,
    ProcessingStatusEnum? initialStatus,
    ProcessingStatusEnum? loadingStatus,
    ProductFilterDropdownsModel? dropdownData,
    List<ProductFilterItemModel>? products,
    String? selectedId,
  }) {
    return ProductFilterState(
      parameters: parameters ?? this.parameters,
      initialStatus: initialStatus ?? this.initialStatus,
      loadingStatus: loadingStatus ?? this.loadingStatus,
      dropdownData: dropdownData ?? this.dropdownData,
      products: products ?? this.products,
      selectedId: selectedId,
    );
  }
}

// class SelectionState {
//   String? productId;
//   ProductDetailModel? productDetail;
//   SelectionState({this.productId, this.productDetail});
// }

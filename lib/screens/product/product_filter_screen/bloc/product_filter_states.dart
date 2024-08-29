import '../../../../utilities/classes/custom_widget_models.dart';
import '../../../../utilities/enums/ui_enums.dart';
import '../models/product_filter_item_model.dart';

class ProductFilterState {
  ProcessingStatusEnum? loadingStatus;
  String? productCode;
  String? productName;
  List<CDropdownMenuEntry>? productCategories;
  List<CDropdownMenuEntry>? selectedProductCategories;
  List<CDropdownMenuEntry>? productTypes;
  List<CDropdownMenuEntry>? selectedProductTypes;
  List<ProductFilterItemModel>? products;
  String? selectedId;

  ProductFilterState({
    this.loadingStatus = ProcessingStatusEnum.processing,
    this.productCode,
    this.productName,
    this.productCategories,
    this.selectedProductCategories,
    this.productTypes,
    this.selectedProductTypes,
    this.products,
    this.selectedId,
  });

  ProductFilterState copyWith({
    ProcessingStatusEnum? loadingStatus,
    String? productCode,
    String? productName,
    List<CDropdownMenuEntry>? productCategories,
    List<CDropdownMenuEntry>? selectedProductCategories,
    List<CDropdownMenuEntry>? productTypes,
    List<CDropdownMenuEntry>? selectedProductTypes,
    List<ProductFilterItemModel>? products,
    String? selectedId,
  }) {
    return ProductFilterState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      productCode: productCode ?? this.productCode,
      productName: productName ?? this.productName,
      productCategories: productCategories ?? this.productCategories,
      selectedProductCategories:
          selectedProductCategories ?? this.selectedProductCategories,
      productTypes: productTypes ?? this.productTypes,
      selectedProductTypes:
          selectedProductTypes ?? this.selectedProductCategories,
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

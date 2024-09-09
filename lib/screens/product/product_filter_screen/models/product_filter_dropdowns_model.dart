import '../../../../utilities/classes/custom_widget_models.dart';

class ProductFilterDropdownsModel {
  List<CDropdownMenuEntry>? productCategories;
  List<CDropdownMenuEntry>? selectedProductCategories;
  List<CDropdownMenuEntry>? productTypes;
  List<CDropdownMenuEntry>? selectedProductTypes;

  ProductFilterDropdownsModel({
    this.productCategories,
    this.selectedProductCategories,
    this.productTypes,
    this.selectedProductTypes,
  });

  ProductFilterDropdownsModel copyWith({
    List<CDropdownMenuEntry>? productCategories,
    List<CDropdownMenuEntry>? selectedProductCategories,
    List<CDropdownMenuEntry>? productTypes,
    List<CDropdownMenuEntry>? selectedProductTypes,
  }) {
    return ProductFilterDropdownsModel(
      productCategories: productCategories ?? this.productCategories,
      selectedProductCategories:
          selectedProductCategories ?? this.selectedProductCategories,
      productTypes: productTypes ?? this.productTypes,
      selectedProductTypes: selectedProductTypes ?? this.selectedProductTypes,
    );
  }
}

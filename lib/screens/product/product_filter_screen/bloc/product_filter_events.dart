import '../../../../utilities/classes/custom_widget_models.dart';
// import '../../../../utilities/enums/ui_enums.dart';
import '../models/product_filter_item_model.dart';
import '../models/product_filter_parameter_model.dart';

abstract class ProductFilterEvents {}

class InitProductFilterData extends ProductFilterEvents {
  InitProductFilterData();
}

// class ProductFilterDataLoaded extends ProductFilterEvents {
//   ProcessingStatusEnum loadingStatus;
//   ProductFilterDataLoaded(this.loadingStatus);
// }

class ProductFilterCodeChanged extends ProductFilterEvents {
  String? productCode;
  ProductFilterCodeChanged(this.productCode);
}

class ProductFilterNameChanged extends ProductFilterEvents {
  String? productName;
  ProductFilterNameChanged(this.productName);
}

class ProductFilterCategoriesChanged extends ProductFilterEvents {
  List<CDropdownMenuEntry>? categoryCodes;
  ProductFilterCategoriesChanged(this.categoryCodes);
}

class ProductFilterTypesChanged extends ProductFilterEvents {
  List<CDropdownMenuEntry>? typeCodes;
  ProductFilterTypesChanged(this.typeCodes);
}

class ProductFilterSubmitted extends ProductFilterEvents {
  ProductFilterSubmitted();
}

class ProductFilterListChanged extends ProductFilterEvents {
  List<ProductFilterItemModel>? products;
  ProductFilterListChanged(this.products);
}

class SelectedFilterProductChanged extends ProductFilterEvents {
  String? productId;
  SelectedFilterProductChanged(this.productId);
}

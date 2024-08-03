import '../../../../utilities/classes/custom_widget_models.dart';
import '../models/product_filter_item_model.dart';
import 'product_filter_states.dart';

abstract class ProductFilterEvents {}

class InitProductFilterData extends ProductFilterEvents {
  InitProductFilterData();
}

class ProductFilterDataLoaded extends ProductFilterEvents {
  ProductFilterStatus loadingStatus;
  ProductFilterDataLoaded(this.loadingStatus);
}

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

class ProductFilterSelectedCategoriesChanged extends ProductFilterEvents {
  List<CDropdownMenuEntry>? selectedCategoryCodes;
  ProductFilterSelectedCategoriesChanged(this.selectedCategoryCodes);
}

class ProductFilterTypesChanged extends ProductFilterEvents {
  List<CDropdownMenuEntry>? typeCodes;
  ProductFilterTypesChanged(this.typeCodes);
}

class ProductFilterSelectedTypesChanged extends ProductFilterEvents {
  List<CDropdownMenuEntry>? selectedTypeCodes;
  ProductFilterSelectedTypesChanged(this.selectedTypeCodes);
}

class ProductFilterListChanged extends ProductFilterEvents {
  List<ProductFilterItemModel>? products;
  ProductFilterListChanged(this.products);
}

class SelectedFilterProductChanged extends ProductFilterEvents {
  String? productId;
  SelectedFilterProductChanged(this.productId);
}

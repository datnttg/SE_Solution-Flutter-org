import '../../../../utilities/classes/custom_widget_models.dart';

abstract class ProductFilterEvents {}

class ChangeProductFilterCode extends ProductFilterEvents {
  String? productCode;
  ChangeProductFilterCode(this.productCode);
}

class ChangeProductFilterName extends ProductFilterEvents {
  String? productName;
  ChangeProductFilterName(this.productName);
}

class ChangeProductFilterCategory extends ProductFilterEvents {
  List<CDropdownMenuEntry>? categoryCodes;
  ChangeProductFilterCategory(this.categoryCodes);
}

class ChangeProductFilterType extends ProductFilterEvents {
  List<CDropdownMenuEntry>? typeCodes;
  ChangeProductFilterType(this.typeCodes);
}

class ChangeFilterSelectedProduct extends ProductFilterEvents {
  String? productId;
  ChangeFilterSelectedProduct({this.productId});
}

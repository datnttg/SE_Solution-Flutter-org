import '../../../../utilities/classes/custom_widget_models.dart';

abstract class ProductFilterEvents {}

class ChangeProductCode extends ProductFilterEvents {
  String? productCode;
  ChangeProductCode(this.productCode);
}

class ChangeProductName extends ProductFilterEvents {
  String? productName;
  ChangeProductName(this.productName);
}

class ChangeProductCategory extends ProductFilterEvents {
  List<CDropdownMenuEntry>? categoryCodes;
  ChangeProductCategory(this.categoryCodes);
}

class ChangeProductType extends ProductFilterEvents {
  List<CDropdownMenuEntry>? typeCodes;
  ChangeProductType(this.typeCodes);
}

class ChangeSelectedProduct extends ProductFilterEvents {
  String? productId;
  ChangeSelectedProduct({this.productId});
}

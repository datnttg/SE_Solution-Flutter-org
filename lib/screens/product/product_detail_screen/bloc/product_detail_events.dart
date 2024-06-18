import '../models/child_product_model.dart';

abstract class ChangeProductDetailEvents {}

class ChangeProductCode extends ChangeProductDetailEvents {
  String? code;
  ChangeProductCode(this.code);
}

class ChangeProductName extends ChangeProductDetailEvents {
  String? name;
  ChangeProductName(this.name);
}

class ChangeProductUnit extends ChangeProductDetailEvents {
  String? unit;
  ChangeProductUnit(this.unit);
}

class ChangeProductDescription extends ChangeProductDetailEvents {
  String? description;
  ChangeProductDescription(this.description);
}

class ChangeProductCategory extends ChangeProductDetailEvents {
  String? category;
  ChangeProductCategory(this.category);
}

class ChangeProductType extends ChangeProductDetailEvents {
  String? type;
  ChangeProductType(this.type);
}

class ChangeProductSerialRequired extends ChangeProductDetailEvents {
  bool? serialRequired;
  ChangeProductSerialRequired(this.serialRequired);
}

class ChangeProductMonthsOfWarranty extends ChangeProductDetailEvents {
  int? monthsOfWarranty;
  ChangeProductMonthsOfWarranty(this.monthsOfWarranty);
}

class ChangeProductMinPrice extends ChangeProductDetailEvents {
  double? minPrice;
  ChangeProductMinPrice(this.minPrice);
}

class ChangeProductChildren extends ChangeProductDetailEvents {
  List<ChildProductModel> children;
  ChangeProductChildren(this.children);
}

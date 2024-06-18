import '../../../../utilities/enums/ui_enums.dart';
import '../models/child_product_model.dart';

abstract class ChangeProductDetailEvents {}

class ChangeScreenMode extends ChangeProductDetailEvents {
  ScreenModeEnum? screenMode;
  ChangeScreenMode(this.screenMode);
}

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

class ChangeProductStatus extends ChangeProductDetailEvents {
  String? status;
  ChangeProductStatus(this.status);
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

class SubmitData extends ChangeProductDetailEvents {
  SubmitData();
}

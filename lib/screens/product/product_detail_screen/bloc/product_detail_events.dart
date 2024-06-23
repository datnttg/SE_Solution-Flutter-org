import '../../../../utilities/enums/ui_enums.dart';
import '../models/child_product_model.dart';
import '../models/product_detail_model.dart';

abstract class ChangeProductDetailEvents {}

class ChangeScreenMode extends ChangeProductDetailEvents {
  ScreenModeEnum? screenMode;
  ChangeScreenMode(this.screenMode);
}

class LoadProductDetail extends ChangeProductDetailEvents {
  ProductDetailModel detail;
  LoadProductDetail(this.detail);
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
  String? monthsOfWarranty;
  ChangeProductMonthsOfWarranty(this.monthsOfWarranty);
}

class ChangeProductMinPrice extends ChangeProductDetailEvents {
  double? minPrice;
  ChangeProductMinPrice(this.minPrice);
}

class RemoveChildProduct extends ChangeProductDetailEvents {
  int item;
  RemoveChildProduct(this.item);
}

class ChangeChildProductId extends ChangeProductDetailEvents {
  int item;
  String productId;
  ChangeChildProductId(this.item, this.productId);
}

class ChangeChildProductQuantity extends ChangeProductDetailEvents {
  int item;
  double quantity;
  ChangeChildProductQuantity(this.item, this.quantity);
}

class ChangeChildrenProducts extends ChangeProductDetailEvents {
  List<ChildProductModel> children;
  ChangeChildrenProducts(this.children);
}

class SubmitData extends ChangeProductDetailEvents {
  SubmitData();
}

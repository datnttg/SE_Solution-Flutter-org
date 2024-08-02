import '../../../../utilities/enums/ui_enums.dart';
import '../models/child_product_model.dart';
import 'product_detail_states.dart';

abstract class ChangeProductDetailEvents {}

class ChangeScreenMode extends ChangeProductDetailEvents {
  ScreenModeEnum? screenMode;
  ChangeScreenMode(this.screenMode);
}

class ProductIdChanged extends ChangeProductDetailEvents {
  String? id;
  ProductIdChanged(this.id);
}

// class InitProductDetailData extends ChangeProductDetailEvents {
//   String? productId;
//   InitProductDetailData({this.productId});
// }

class ProductDetailDataLoaded extends ChangeProductDetailEvents {
  ProductDetailState state;
  ProductDetailDataLoaded(this.state);
}

class ProductCodeChanged extends ChangeProductDetailEvents {
  String? code;
  ProductCodeChanged(this.code);
}

class ProductNameChanged extends ChangeProductDetailEvents {
  String? name;
  ProductNameChanged(this.name);
}

class ProductUnitChanged extends ChangeProductDetailEvents {
  String? unit;
  ProductUnitChanged(this.unit);
}

class ProductDescriptionChanged extends ChangeProductDetailEvents {
  String? description;
  ProductDescriptionChanged(this.description);
}

class ProductStatusChanged extends ChangeProductDetailEvents {
  String? status;
  ProductStatusChanged(this.status);
}

class ProductCategoryChanged extends ChangeProductDetailEvents {
  String? category;
  ProductCategoryChanged(this.category);
}

class ProductTypeChanged extends ChangeProductDetailEvents {
  String? type;
  ProductTypeChanged(this.type);
}

class ProductSerialRequiredChanged extends ChangeProductDetailEvents {
  bool? serialRequired;
  ProductSerialRequiredChanged(this.serialRequired);
}

class ProductMonthsOfWarrantyChanged extends ChangeProductDetailEvents {
  int? monthsOfWarranty;
  ProductMonthsOfWarrantyChanged(this.monthsOfWarranty);
}

class ProductMinPriceChanged extends ChangeProductDetailEvents {
  double? minPrice;
  ProductMinPriceChanged(this.minPrice);
}

class ChildProductRemoved extends ChangeProductDetailEvents {
  int item;
  ChildProductRemoved(this.item);
}

class ChildProductAdded extends ChangeProductDetailEvents {
  ChildProductModel childProduct;
  ChildProductAdded(this.childProduct);
}

class ChildProductIdChanged extends ChangeProductDetailEvents {
  int item;
  String childProductId;
  ChildProductIdChanged(this.item, this.childProductId);
}

class ChildProductQuantityChanged extends ChangeProductDetailEvents {
  int item;
  double quantity;
  ChildProductQuantityChanged(this.item, this.quantity);
}

class SubmitData extends ChangeProductDetailEvents {
  SubmitData();
}

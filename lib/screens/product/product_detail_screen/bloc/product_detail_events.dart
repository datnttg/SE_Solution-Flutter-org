import '../../../../utilities/enums/ui_enums.dart';
import '../../product_filter_screen/models/product_filter_item_model.dart';
import '../models/child_product_model.dart';
import '../models/product_detail_model.dart';

abstract class ChangeProductDetailEvents {}

class ChangeScreenMode extends ChangeProductDetailEvents {
  ScreenModeEnum? screenMode;
  ChangeScreenMode(this.screenMode);
}

// class LoadData extends ChangeProductDetailEvents {
//   ProductDetailModel detail;
//   List<ProductFilterItemModel> listProduct;
//   LoadData({
//     required this.detail,
//     required this.listProduct,
//   });
// }

// class LoadDropdownData extends ChangeProductDetailEvents {
//   List<CDropdownMenuEntry> listUnit;
//   List<CDropdownMenuEntry> listStatus;
//   List<CDropdownMenuEntry> listCategory;
//   List<CDropdownMenuEntry> listType;
//   LoadDropdownData({
//     required this.listUnit,
//     required this.listStatus,
//     required this.listCategory,
//     required this.listType,
//   });
// }

class ReloadData extends ChangeProductDetailEvents {
  String? productId;
  ReloadData(this.productId);
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

class ChangeProductRequiredSerial extends ChangeProductDetailEvents {
  bool? require;
  ChangeProductRequiredSerial(this.require);
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
  String childProductId;
  ChangeChildProductId(this.item, this.childProductId);
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

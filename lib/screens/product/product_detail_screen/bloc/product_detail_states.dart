import '../../../../utilities/classes/custom_widget_models.dart';
import '../../../../utilities/enums/ui_enums.dart';
import '../../product_filter_screen/models/product_filter_item_model.dart';

class ScreenModeState {
  ScreenModeEnum? state;
  ScreenModeState({this.state});
}

class ProductDetailDataState {
  List<ProductFilterItemModel>? listProduct;
  List<CDropdownMenuEntry>? listUnit;
  List<CDropdownMenuEntry>? listStatus;
  List<CDropdownMenuEntry>? listCategory;
  List<CDropdownMenuEntry>? listType;

  ProductDetailDataState({
    this.listProduct,
    this.listUnit,
    this.listStatus,
    this.listCategory,
    this.listType,
  });
}

import 'package:se_solution/screens/product/product_detail_screen/models/product_detail_model.dart';

import '../../../../utilities/classes/custom_widget_models.dart';
import '../../../../utilities/enums/ui_enums.dart';
import '../../product_filter_screen/models/product_filter_item_model.dart';

class ScreenModeState {
  ScreenModeEnum? state;
  ScreenModeState(this.state);
}

class ProductDetailState {
  ProductDetailModel productDetail;
  ScreenModeEnum screenMode;
  List<ProductFilterItemModel> lstProduct;
  List<CDropdownMenuEntry> lstType;
  List<CDropdownMenuEntry> lstUnit;
  List<CDropdownMenuEntry> lstStatus;
  List<CDropdownMenuEntry> lstCategory;

  ProductDetailState(
      {required this.productDetail,
      required this.screenMode,
      required this.lstProduct,
      required this.lstUnit,
      required this.lstStatus,
      required this.lstCategory,
      required this.lstType});

  ProductDetailState copyWith({
    ScreenModeEnum? screenMode,
    ProductDetailModel? productDetail,
    List<ProductFilterItemModel>? lstProduct,
    List<CDropdownMenuEntry>? lstUnit,
    List<CDropdownMenuEntry>? lstStatus,
    List<CDropdownMenuEntry>? lstCategory,
    List<CDropdownMenuEntry>? lstType,
  }) {
    return ProductDetailState(
      screenMode: screenMode ?? this.screenMode,
      productDetail: productDetail ?? this.productDetail,
      lstProduct: lstProduct ?? this.lstProduct,
      lstUnit: lstUnit ?? this.lstUnit,
      lstStatus: lstStatus ?? this.lstStatus,
      lstCategory: lstCategory ?? this.lstCategory,
      lstType: lstType ?? this.lstType,
    );
  }
}

// class ProductDetailDataState {
//   List<CDropdownMenuEntry>? listUnit;
//   List<CDropdownMenuEntry>? listStatus;
//   List<CDropdownMenuEntry>? listCategory;
//   List<CDropdownMenuEntry>? listType;

//   ProductDetailDataState({
//     this.listUnit,
//     this.listStatus,
//     this.listCategory,
//     this.listType,
//   });
// }

import '../../../../utilities/classes/custom_widget_models.dart';
import '../../../../utilities/enums/ui_enums.dart';
import '../models/product_detail_model.dart';

// class ScreenModeState {
//   ScreenModeEnum? state;
//   ScreenModeState(this.state);
// }

enum ProductDetailLoadingStatus { initial, loading, success, failure }

extension WeatherStatusX on ProductDetailLoadingStatus {
  bool get isInitial => this == ProductDetailLoadingStatus.initial;
  bool get isLoading => this == ProductDetailLoadingStatus.loading;
  bool get isSuccess => this == ProductDetailLoadingStatus.success;
  bool get isFailure => this == ProductDetailLoadingStatus.failure;
}

class ProductDetailState {
  ScreenModeEnum screenMode;
  ProductDetailLoadingStatus loadingStatus;
  ProductDetailModel productDetail;
  List<ProductDetailModel> lstProduct;
  List<CDropdownMenuEntry> lstType;
  List<CDropdownMenuEntry> lstUnit;
  List<CDropdownMenuEntry> lstStatus;
  List<CDropdownMenuEntry> lstCategory;

  ProductDetailState({
    required this.screenMode,
    required this.loadingStatus,
    required this.productDetail,
    required this.lstProduct,
    required this.lstUnit,
    required this.lstStatus,
    required this.lstCategory,
    required this.lstType,
  });

  ProductDetailState copyWith({
    ProductDetailLoadingStatus? loadingStatus,
    ScreenModeEnum? screenMode,
    ProductDetailModel? productDetail,
    List<ProductDetailModel>? lstProduct,
    List<CDropdownMenuEntry>? lstUnit,
    List<CDropdownMenuEntry>? lstStatus,
    List<CDropdownMenuEntry>? lstCategory,
    List<CDropdownMenuEntry>? lstType,
  }) {
    return ProductDetailState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
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

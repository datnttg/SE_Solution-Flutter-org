import '../../../../utilities/classes/custom_widget_models.dart';
import '../../../../utilities/enums/ui_enums.dart';
import '../models/product_detail_model.dart';

// extension ProcessingStatusEnumX on ProcessingStatusEnum {
//   bool get isInitial => this == ProductDetailLoadingStatus.initial;
//   bool get isLoading => this == ProductDetailLoadingStatus.loading;
//   bool get isSuccess => this == ProductDetailLoadingStatus.success;
//   bool get isFailure => this == ProductDetailLoadingStatus.failure;
// }

class ProductDetailState {
  ScreenModeEnum screenMode;
  ProcessingStatusEnum loadingStatus;
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
    ProcessingStatusEnum? loadingStatus,
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

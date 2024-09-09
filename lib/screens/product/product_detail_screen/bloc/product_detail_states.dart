import '../../../../utilities/classes/custom_widget_models.dart';
import '../../../../utilities/enums/ui_enums.dart';
import '../models/product_detail_model.dart';
import '../models/product_update_model.dart';

// extension ProcessingStatusEnumX on ProcessingStatusEnum {
//   bool get isInitial => this == ProductDetailLoadingStatus.initial;
//   bool get isLoading => this == ProductDetailLoadingStatus.loading;
//   bool get isSuccess => this == ProductDetailLoadingStatus.success;
//   bool get isFailure => this == ProductDetailLoadingStatus.failure;
// }

class ProductDetailState {
  ScreenModeEnum screenMode;
  ProcessingStatusEnum initialStatus;
  ProductDetailModel productDetail;
  ProductUpdateModel productUpdate;
  ProcessingStatusEnum loadingStatus;
  List<ProductDetailModel> lstProduct;
  List<CDropdownMenuEntry> lstType;
  List<CDropdownMenuEntry> lstUnit;
  List<CDropdownMenuEntry> lstStatus;
  List<CDropdownMenuEntry> lstCategory;

  ProductDetailState({
    required this.screenMode,
    required this.initialStatus,
    required this.productDetail,
    required this.productUpdate,
    required this.loadingStatus,
    required this.lstProduct,
    required this.lstUnit,
    required this.lstStatus,
    required this.lstCategory,
    required this.lstType,
  });

  ProductDetailState copyWith({
    ProcessingStatusEnum? initialStatus,
    ScreenModeEnum? screenMode,
    ProductDetailModel? productDetail,
    ProductUpdateModel? productUpdate,
    ProcessingStatusEnum? loadingStatus,
    List<ProductDetailModel>? lstProduct,
    List<CDropdownMenuEntry>? lstUnit,
    List<CDropdownMenuEntry>? lstStatus,
    List<CDropdownMenuEntry>? lstCategory,
    List<CDropdownMenuEntry>? lstType,
  }) {
    return ProductDetailState(
      initialStatus: initialStatus ?? this.initialStatus,
      loadingStatus: loadingStatus ?? this.loadingStatus,
      screenMode: screenMode ?? this.screenMode,
      productDetail: productDetail ?? this.productDetail,
      productUpdate: productUpdate ?? this.productUpdate,
      lstProduct: lstProduct ?? this.lstProduct,
      lstUnit: lstUnit ?? this.lstUnit,
      lstStatus: lstStatus ?? this.lstStatus,
      lstCategory: lstCategory ?? this.lstCategory,
      lstType: lstType ?? this.lstType,
    );
  }
}

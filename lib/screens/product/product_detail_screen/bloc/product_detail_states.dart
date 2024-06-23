import '../../../../utilities/enums/ui_enums.dart';

class ScreenModeState {
  ScreenModeEnum? state;
  ScreenModeState({this.state});
}

// class DisplayTypeState {
//   DisplayTypeEnum? displayType;
//   DisplayTypeState({this.displayType});
// }

// class ProductDetailState {
//   ProductDetailModel productDetail;
//   List<ChildProductModel>? children;
//
//   ProductDetailState({
//     required this.productDetail,
//     this.children,
//   });
//
//   factory ProductDetailState.fromJson(Map<String, dynamic> json) {
//     return ProductDetailState(
//       productDetail: ProductDetailModel.fromJson(json['productDetail']),
//       children: List<ChildProductModel>.from(
//           json['children'].map((x) => ChildProductModel.fromJson(x))),
//     );
//   }
//
//   Map<String, dynamic> toMap() {
//     return {
//       'productDetail': productDetail.toMap(),
//       'children': children?.map((x) => x.toMap()).toList(),
//     };
//   }
// }

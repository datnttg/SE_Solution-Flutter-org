import '../../product_detail_screen/models/product_detail_model.dart';
import '../models/product_filter_item_model.dart';

class ProductListState {
  List<ProductFilterItemModel>? products;
  ProductListState({required this.products});
}

class SelectionState {
  String? productId;
  ProductDetailModel? productDetail;
  SelectionState({this.productId, this.productDetail});
}

import '../models/product_filter_item_model.dart';

class ProductListState {
  List<ProductFilterItemModel>? products;
  ProductListState({required this.products});
}

class SelectionState {
  String? productId;
  SelectionState({this.productId});
}

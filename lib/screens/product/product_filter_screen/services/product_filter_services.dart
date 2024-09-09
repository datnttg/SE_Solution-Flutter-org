import '../../../../utilities/app_service.dart';
import '../../../../utilities/classes/custom_widget_models.dart';
import '../../../../utilities/constants/core_constants.dart';
import '../../../../utilities/shared_preferences.dart';
import '../../product_detail_screen/models/product_detail_model.dart';
import '../models/product_filter_item_model.dart';
import '../models/product_filter_parameter_model.dart';

var hostAddress = constants.hostAddress;

Future<ProductDetailModel> fetchProductDetailEntry(String productId) async {
  var params = {'id': productId};
  var data = await fetchData(Uri.parse('$hostAddress/Product/Detail'),
      parameters: params);
  var listEntries = data['responseData']
      .map<CDropdownMenuEntry>((e) => CDropdownMenuEntry(
            value: e['code'],
            labelText: e[sharedPref.getLocale().languageCode],
          ))
      .toList();
  return listEntries;
}

Future<List<CDropdownMenuEntry>> fetchProductCategoryEntry(
    {String? categoryProperty}) async {
  var params = {"categoryProperty": categoryProperty};
  var data = await fetchData(Uri.parse('$hostAddress/Product/ListCategory'),
      parameters: params);
  var listEntries = data['responseData']
      .map<CDropdownMenuEntry>((e) => CDropdownMenuEntry(
            value: e['code'],
            labelText: e[sharedPref.getLocale().languageCode],
          ))
      .toList();
  return listEntries;
}

Future<List<ProductFilterItemModel>> fetchProductListModel(
    ProductFilterParameters? params) async {
  var data = await fetchData(
    Uri.parse('$hostAddress/Product/List'),
    parameters: params?.toMap(),
  );
  if (data['success'] == false) return [];
  var result = data['responseData']
      .map<ProductFilterItemModel>((e) => ProductFilterItemModel?.fromJson(e))
      .toList();
  return result;
}

Future<List<CDropdownMenuEntry>> fetchProductListEntry(
    ProductFilterParameters? params) async {
  var data = await fetchData(
    Uri.parse('$hostAddress/Product/List'),
    parameters: params?.toMap(),
  );
  if (data['success'] == false) return [];
  var result = data['responseData']
      .map<CDropdownMenuEntry>((e) => CDropdownMenuEntry(
            value: e['id'],
            labelText: e['name'],
          ))
      .toList();
  return result;
}

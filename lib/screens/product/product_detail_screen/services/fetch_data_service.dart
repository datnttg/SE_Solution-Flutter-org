import '../../../../utilities/app_service.dart';
import '../../../../utilities/constants/core_constants.dart';
import '../../../../utilities/shared_preferences.dart';
import '../bloc/product_detail_states.dart';

var hostAddress = constants.hostAddress;

Future postProductDetail(ProductDetailStates params) async {
  var response =
      await fetchDataUI(Uri.parse(hostAddress), parameters: params.toMap());
  if (response['success'] == true) {
    kShowToast(
      title: sharedPrefs.translate('Success'),
      content: response['responseMessage'],
      style: 'success',
    );
  }
}

import '../../../utilities/app_service.dart';
import '../../../utilities/constants/core_constants.dart';

Future<List> fetchPowerStationsList() async {
  var uri = Uri.parse("${constants.hostAddress}/PowerStation/List");
  Map response = await fetchData(uri);
  var responseData = response['responseData'];
  return responseData;
}

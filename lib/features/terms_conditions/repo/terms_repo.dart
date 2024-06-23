import '../../../config/api_names.dart';
import '../../../network/network_layer.dart';

abstract class TermsRepo {
  static Future<dynamic> getTerms() async {
    return await Network().request(
      ApiNames.terms,
      method: ServerMethods.GET,
    );
  }
}

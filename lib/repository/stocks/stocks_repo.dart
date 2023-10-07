import 'package:stock_scan_parser/repository/stocks/repo.dart';

import '../../data/remote/api_endpoints.dart';
import '../../data/remote/base_api_service.dart';
import '../../data/remote/network_api_service.dart';

class StocksRepo implements Repo {
  final BaseApiService _apiService = NetworkApiService();

  @override
  Future<dynamic> getStocksData() async {
    try {
      dynamic response =
          await _apiService.getAllStocksResponse(ApiEndPoints().getStocksList);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

abstract class BaseApiService {
  final String baseUrl = "http://coding-assignment.bombayrunning.com";
  // final String apiKey = "7d635b11b2094bec87104c167922ea1e";

  Future<dynamic> getAllStocksResponse(String endpoint);
}

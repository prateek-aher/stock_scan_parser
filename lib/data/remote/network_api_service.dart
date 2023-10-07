import 'dart:convert';
import 'dart:io';

import 'app_exception.dart';
import 'base_api_service.dart';
import 'package:http/http.dart' as http;

class NetworkApiService extends BaseApiService {
  @override
  Future getAllStocksResponse(String endpoint) async {
    dynamic responseJson;
    try {
      // var query = {"apiKey": apiKey, "country": countryCode};
      var uri = Uri.parse(baseUrl+endpoint /*, query*/);
      final response = await http.get(uri);
      responseJson = returnResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Socket Exception: ${e.toString()}");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.toString());
      case 401:
      case 403:
      case 404:
        dynamic responseJson = jsonDecode(response.body);
        throw UnauthorisedException(responseJson['message']);
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while communication with server with status code : ${response.statusCode}');
    }
  }
}

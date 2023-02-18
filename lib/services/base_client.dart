import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:baseclient/services/app_exceptions.dart';
import 'package:http/http.dart' as http;

class BaseClient {
  static const TIME_OUT_DURATION = 20;
  // GET
  Future<dynamic> get(String baseUrl, String api) async {
    var uri = Uri.parse(baseUrl + api);
    try {
      var response = await http
          .get(uri)
          .timeout(const Duration(seconds: TIME_OUT_DURATION));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataExcption('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          "API not responded in time", uri.toString());
    }
  }

  // POST
  Future<dynamic> post(String baseUrl, String api, dynamic payloadObj) async {
    var uri = Uri.parse(baseUrl + api);
    var payload = json.encode(payloadObj);
    try {
      var response = await http
          .post(uri, body: payload)
          .timeout(const Duration(seconds: TIME_OUT_DURATION));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataExcption('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          "API not responded in time", uri.toString());
    }
  }
  // DELETE
  // OTHERS

  dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;
      // case 201:
      //   var responseJson = utf8.decode(response.bodyBytes);
      //   return responseJson;

      case 400:
        throw BadRequestException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 401:
      case 403:
        throw BadRequestException((utf8.decode(response.bodyBytes)),
            response.request!.url.toString());
      case 500:

      default:
        throw FetchDataExcption(
            'Error occured with code :${response.statusCode}',
            response.request!.url.toString());
    }
  }
}

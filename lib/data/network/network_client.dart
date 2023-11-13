

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:plant_ui/app_exception.dart';
import 'package:plant_ui/data/network/base_api_service.dart';

class NetworkClient extends BaseApiService{

  final url = Uri.parse('https://perenual.com/api/species-list?key=sk-BuwK652a9021aa6aa2462&page=1');

  Future<Response> get() async {
    final response  = await http.get(url);
    return response;
  }

  @override
  Future getGetApiResponse(String url) async{

    dynamic responseJson;

    try
    {
      final response  = await http.get(Uri.parse(url))
          .timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    }on SocketException{
      throw FetchDataException("Error in communication");
    }
    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic data) async {

    dynamic responseJson;

    try
    {
        final response  = await post(
          Uri.parse(url),
          body:  data
        ).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);

    }on SocketException{
      throw FetchDataException("Error in communication");
    }
    return responseJson;
  }


  dynamic returnResponse (http.Response response){

    switch(response.statusCode){
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 404:
        throw UnauthorizedException(response.body.toString());

      default:
          throw FetchDataException('Error occured while communication with server with status code ${response.statusCode}');
    }
  }
}
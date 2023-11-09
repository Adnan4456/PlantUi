

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:plant_ui/data/network/base_api_service.dart';

class NetworkClient extends BaseApiService{

  final url = Uri.parse('https://perenual.com/api/species-list?key=sk-BuwK652a9021aa6aa2462&page=1');

  Future<Response> get() async {
    final response  = await http.get(url);
    return response;
  }

  @override
  Future getGetApiResponse(String url) async{
    final response  = await http.get(Uri.parse(url));
    return response;
  }

  @override
  Future getPostApiResponse(String url, data) {
    // TODO: implement getPostApiResponse
    throw UnimplementedError();
  }
}
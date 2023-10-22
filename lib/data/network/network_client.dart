

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class NetworkClient{

  final url = Uri.parse('https://perenual.com/api/species-list?key=sk-BuwK652a9021aa6aa2462&page=1'); // Replace with your API URL

  Future<Response> get() async {
    final response  = await http.get(url);
    return response;
  }
}
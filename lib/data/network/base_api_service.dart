


abstract class BaseApiService{

  //this function is for all get api calls
  Future<dynamic> getGetApiResponse(String url);

  //this function is for all post api calls e.g login
  Future<dynamic> getPostApiResponse(String url, dynamic data);
}
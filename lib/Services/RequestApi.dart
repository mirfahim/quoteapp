
import 'package:http/http.dart' as http;
import 'package:thoughts_creator/utils/ApiUtils.dart';

class RequestApi {
   String url;
   dynamic body;


   RequestApi({this.url, this.body});

  Future<http.Response> post() {
    return http.post(ApiUtils.urlBase + url, body: body,).timeout(Duration(minutes: 2));
  }
  Future<http.Response> get() {
    return http.get(ApiUtils.urlBase + url,).timeout(Duration(minutes: 2));
  }

   Future<http.Response> popularPost() {
     return http.get(ApiUtils.urlBase + url,).timeout(Duration(minutes: 2));
   }
}
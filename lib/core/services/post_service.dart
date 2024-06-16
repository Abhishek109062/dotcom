import 'package:http/http.dart' as http;

import '../base/base_service.dart';
import '../network/api_end_point.dart';
import 'network_api_service.dart';

class PostService extends BaseService {
  Future<http.Response> postsApiResponse() async {
    try {
      final response = await NetworkApiService().getApiResponse(ApiEndPoint.posts, null);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}

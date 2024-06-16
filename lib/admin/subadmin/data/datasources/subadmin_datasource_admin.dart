import 'dart:convert';

import 'package:dot_com/constants.dart';
import 'package:dot_com/init_dependencies.dart';
import 'package:fpdart/fpdart.dart';
import "package:http/http.dart" as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/badrequest.dart';
import '../../../../core/error/failure.dart';

// abstract interface class SubAdminDataSource {
//   Future<Either<Failure, String>> addSubAdmin(
//       {required String userName,
//       required String email,
//       required String password});
// }

// class SubAdminDataSourceImpl implements SubAdminDataSource {
//   @override
// Future<Either<Failure, String>> addSubAdmin(
//     {required String userName,
//     required String email,
//     required String password}) async {
//   print("add called");
//   return await post<String>(
//       onSuccess: (data) {
//         return data.toString();
//       },
//       url: "${ApiConstants.baseUrl}/admin/addSubAdmin",
//       body: {"name": userName, "email": email, "password": password});
// }

// Future<Either<Failure, String>> addSubAdmin(
//     {required String userName,
//     required String email,
//     required String password}) async {
//   try {
//     String accessToken =
//         (await storage.read(key: StoreKeys.accessToken)) ?? "";
//     final response = await http.read(Uri.parse("url"),headers: "",);

//     if(response.statusCode == 400){
//         throw BadRequest(jsonDecode(response.body));
//     }
//     else if(response.statusCode !=200){
//       throw Exception("Something went wrong");
//     }
//     return right("success");
//   }on BadRequest catch(e){
//     return left(Failure(e.message));
//   } catch (e) {
//     return left(Failure("Something wennt wrong"));
//   }
// }
// }

Future<Either<Failure, T>> get<T>({
  required String url,
  Map<String, String>? headers,
  required T Function(dynamic data) onSuccess,
}) async {
  // try {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String accessToken = prefs.getString('token') ?? "";
  if (headers == null) {
    headers = {};
  }
  headers["Authorization"] = "Bearer $accessToken";

  final response = await http.get(Uri.parse(url), headers: headers);

  if (response.statusCode == 400) {
    throw BadRequest(jsonDecode(response.body));
  } else if (response.statusCode != 200) {
    throw Exception("Something went wrong");
  }

  final data = jsonDecode(response.body);
  return right(onSuccess(data));
  // } on BadRequest catch (e) {
  //   return left(Failure(e.message));
  // } catch (e) {
  //   return left(Failure("Something went wrong"));
  // }
}

Future<Either<Failure, T>> post<T>({
  required String url,
  required Map<String, dynamic> body,
  Map<String, String>? headers,
  required T Function(dynamic data) onSuccess,
}) async {
  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String accessToken = prefs.getString('token') ?? "";
    if (headers == null) {
      headers = {};
    }
    headers["Authorization"] = "Bearer $accessToken";
    headers["Content-Type"] = "application/json";

    final response = await http.post(Uri.parse(url),
        headers: headers, body: jsonEncode(body));
    if (response.statusCode == 400) {
      throw BadRequest(jsonDecode(response.body));
    } else if (response.statusCode != 200) {
      throw Exception("Something went wrong");
    }

    final data = jsonDecode(response.body);
    return right(onSuccess(data));
  } on BadRequest catch (e) {
    return left(Failure(e.message));
  } catch (e) {
    return left(Failure("Something went wrong"));
  }
}

Future<Either<Failure, T>> put<T>({
  required String url,
  required Map<String, dynamic> body,
  Map<String, String>? headers,
  required T Function(dynamic data) onSuccess,
}) async {
  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String accessToken = prefs.getString('token') ?? "";
    if (headers == null) {
      headers = {};
    }
    headers["Authorization"] = "Bearer $accessToken";
    headers["Content-Type"] = "application/json";
    final response = await http.put(Uri.parse(url),
        headers: headers, body: jsonEncode(body));

    if (response.statusCode == 400) {
      throw BadRequest(jsonDecode(response.body));
    } else if (response.statusCode != 200) {
      throw Exception("Something went wrong");
    }

    final data = jsonDecode(response.body);
    return right(onSuccess(data));
  } on BadRequest catch (e) {
    return left(Failure(e.message));
  } catch (e) {
    return left(Failure("Something went wrong"));
  }
}

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../models/posts_model.dart';
import '../models/calendars.dart';

class SharedPreferenceService {
  Future<void> writeCache({
    required String key,
    required String value,
  }) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    bool isSaved = await pref.setString(key, value);
    debugPrint(isSaved.toString());
  }

  Future<String?> readCache({required String key}) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(key);
  }

  Future<void> clearCache({required String key}) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove(key);
  }
}

class RemoteService {
  final SharedPreferenceService _sharedPrefService = SharedPreferenceService();

  Future<List<Post>?> getPosts() async {
    print("trying to fetch posts");
    var client = http.Client();
    var uri = Uri.parse('http://10.0.2.2:3000/posts');
    final response = await client.get(uri);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return postFromJson(jsonString);
    } else {
      return null;
    }
  }

  Future<int?> addPost(post) async {
    SharedPreferenceService _sharedPrefService = SharedPreferenceService();
    String? token = await _sharedPrefService.readCache(key: "token");
    if (kDebugMode) {
      print(post);
    }
    if (token == null) {
      return 401;
    }
    var client = http.Client();
    var uri = Uri.parse('http://10.0.2.2:3000/posts');
    final response = await client.post(uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: post);
    print(response.body);
    final Map<String, dynamic> responseBody = jsonDecode(response.body);
    print(responseBody);
    return response.statusCode;
  }

  Future<Map<String, dynamic>> logIn(String username, String password) async {
    SharedPreferenceService _sharedPrefService = SharedPreferenceService();
    print(username);
    print(password);
    var client = http.Client();
    var uri = Uri(
      scheme: 'http',
      host: '10.0.2.2',
      port: 3000,
      path: '/auth/login',
      queryParameters: {
        'username': username,
        'password': password,
      },
    );
    var url = uri.toString();
    final response = await client.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      await _sharedPrefService.writeCache(
          key: "token", value: responseBody['token']);
      await _sharedPrefService.writeCache(
          key: "uId", value: responseBody['userId']);
      print(responseBody);
      return responseBody; // Return the entire response body
    } else {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      return {'message': responseBody['message'] ?? 'Failed to log in'};
    }
  }

  Future<String?>? addToCalendar(String date, String id) async {
    SharedPreferenceService _sharedPrefService = SharedPreferenceService();
    String? userId = await _sharedPrefService.readCache(key: "uId");
    String? token = await _sharedPrefService.readCache(key: "token");
    if (userId == null || token == null) {
      return null;
    }
    var client = http.Client();
    var uri = Uri.parse('http://10.0.2.2:3000/calendars/add/$id');
    final response = await client.post(uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(<String, String>{
          'date': date,
          'user': userId,
        }));
    print(response.body);
    if (response.statusCode == 201) {
      var responseBody = jsonDecode(response.body);
      _sharedPrefService.writeCache(
          key: "calendarId", value: responseBody["_id"]);
      return "Post Created";
    } else {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      return responseBody['message'] ?? 'Failed to add to calendar';
    }
  }

  Future<List<Calendar>?> getCalendar() async {
    print("trying to fetch calendar");
    SharedPreferenceService sharedPrefService = SharedPreferenceService();
    String? token = await sharedPrefService.readCache(key: "token");
    print(token);
    if (token == null) {
      return null;
    }

    final client = http.Client();
    try {
      var calendarUri =
          Uri.parse('http://10.0.2.2:3000/calendars/mycalendar');
      final calendarResponse = await client.get(
        calendarUri,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (calendarResponse.statusCode == 200) {
        var calendarData = json.decode(calendarResponse.body) as List;
        List<Calendar> posts = [];
        for (var item in calendarData) {
          var postId = item["post"];
          var postUri = Uri.parse('http://10.0.2.2:3000/posts/$postId');
          final postResponse = await client.get(
            postUri,
            headers: {'Authorization': 'Bearer $token'},
          );

          DateTime dateTime = DateTime.parse(item["date"].toString());
          DateFormat formatter = DateFormat('yyyy-MM-dd');
          String formatted = formatter.format(dateTime);
          if (postResponse.statusCode == 200) {
            var postData = Post.fromJson(jsonDecode(postResponse.body));
            posts.add(Calendar(
                id: item["_id"],
                name: postData.name,
                description: postData.description,
                contact: postData.contact,
                date: formatted));
          }
        }
        return posts;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<String?> updateUserProfile(String userId, String username,
      String email, String password, String name) async {
    try {
      String? token = await _sharedPrefService.readCache(key: "token");
      if (token == null) {
        return 'User not logged in';
      }

      final uri = Uri.parse('http://10.0.2.2:3000/user/$userId/profile');

      final response = await http.patch(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token', // Add the authorization token
        },
        body: jsonEncode(<String, String>{
          'username': username,
          'email': email,
          'password': password,
          'name': name,
        }),
      );

      if (response.statusCode == 200) {
        return 'Profile updated successfully'; // Profile updated successfully
      } else {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        return responseBody['message'] ?? 'Failed to update profile';
      }
    } catch (e) {
      return 'Failed to connect to server'; // Handle connection error
    }
  }

  Future<String?> signUp(String fullName, String email, String username,
      String password, String role) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:3000/auth/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': fullName,
        "username": username,
        'email': email,
        'password': password,
        'role': role,
      }),
    );
    if (response.statusCode == 201) {
      SharedPreferenceService sharedPrefService = SharedPreferenceService();
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      sharedPrefService.writeCache(key: "token", value: responseBody['token']);
      sharedPrefService.writeCache(key: "uId", value: responseBody['userId']);
      return null;
    } else {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      return responseBody['message'] ?? 'Failed to sign up';
    }
  }

  Future<List<Post>?> getMyPosts() async {
    var client = http.Client();
    SharedPreferenceService sharedPrefService = SharedPreferenceService();
    String? userId = await sharedPrefService.readCache(key: "uId");
    if (userId == null) {
      return null;
    }
    String url = 'http://10.0.2.2:3000/posts/myposts/$userId';
    var uri = Uri.parse(url);
    final response = await client.get(uri);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return postFromJson(jsonString);
    } else {
      return (null);
    }
  }

  Future<Post?> getPost(id) async {
    var client = http.Client();
    String url = 'http://10.0.2.2:3000/posts/$id';
    var uri = Uri.parse(url);
    final response = await client.get(uri);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return Post.fromJson(jsonDecode(jsonString));
    } else {
      return (null);
    }

  }

  Future<int> editPost(id, post) async {
    var client = http.Client();
    var uri = Uri.parse('http://10.0.2.2:3000/posts/$id');
    final response = await client.put(uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'name': post.name,
          'description': post.description,
          'contact': post.contact,
        }));
    return response.statusCode;
  }

  Future<int> deletePost(id) async {
    var client = http.Client();
    var uri = Uri.parse('http://10.0.2.2:3000/posts/$id');
    final response = await client.delete(uri);
    return response.statusCode;
  }

  Future<int> deleteCalendar(id) async {
    print(id);
    var client = http.Client();
    var uri = Uri.parse('http://10.0.2.2:3000/calendars/$id');
    final response = await client.delete(uri);
    print(response.body);
    return response.statusCode;
  }

  Future<int> updateCalendar(date, id) async {
    var client = http.Client();
    var uri = Uri.parse('http://10.0.2.2:3000/calendars/$id');
    final response = await client.patch(uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'date': date,
        }));
    print(response.body);
    return response.statusCode;
  }
}

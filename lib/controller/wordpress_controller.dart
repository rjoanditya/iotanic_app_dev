import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:iotanic_app_dev/view/App/detail_articles.dart';

class WordpressController extends GetxController {
  late List categories = [];
  late String url_wordpress = 'https://iotanic.id';

  @override
  void onInit() {
    super.onInit();
    _fetchArticles();
  }

  Future<void> _fetchArticles() async {
    List<Map<String, dynamic>> articles = await getArticles();
    categories = articles;
  }

  Future<Map<String, dynamic>> getUser(id) async {
    var username = 'admin';
    var password = 'i9PeJgZfO&';
    // var password = 'Aicademy1234578';

    Map<String, dynamic> result = {};
    var headers = {
      'Authorization': 'Basic ${base64Encode(utf8.encode('$username:$password'))}',
      'Accept': 'application/json',
    };
    try {
      var url = Uri.parse('$url_wordpress/wp-json/wp/v2/users?id=$id');
      http.Response response = await http.get(url, headers: headers);

      if (response.statusCode != 200) {
        print(response.statusCode);
        return result;
      }
      final jsonData = (jsonDecode(response.body));
      result = jsonData;

      // for (var data in jsonData) {
      //   result.add({
      //     'id': data['id'],
      //     'name': data['name'],
      //     'posts': await getPosts(data['id']),
      //   });
      // }
    } catch (e) {
      print({e});
    }

    return result;
  }

  Future<int> countComment(id) async {
    List result = [];
    var headers = {"Accept": "application/json"};
    try {
      var url = Uri.parse('$url_wordpress/wp-json/wp/v2/comments?post=$id');
      http.Response response = await http.get(url, headers: headers);

      if (response.statusCode != 200) {
        return result.length;
      }
      final jsonData = (jsonDecode(response.body));
      // print('comment =====> $jsonData');
      result = jsonData.length;
    } catch (e) {
      print(e);
    }
    return result.length;
  }

  Future<Map<String, dynamic>> getImage(id) async {
    Map<String, dynamic> result = {};
    var headers = {"Accept": "application/json"};
    try {
      var url = Uri.parse('$url_wordpress/wp-json/wp/v2/media/$id');
      http.Response response = await http.get(url, headers: headers);

      if (response.statusCode != 200) {
        return result;
      }
      final jsonData = (jsonDecode(response.body));
      result = {'url': jsonData['guid']['rendered']};
    } catch (e) {
      print(e);
    }

    return result;
  }

  Future<void> getPost(id) async {
    var headers = {"Accept": "application/json"};
    try {
      var url = Uri.parse('$url_wordpress/wp-json/wp/v2/posts/$id');
      http.Response response = await http.get(url, headers: headers);
      if (response.statusCode != 200) {}
      final jsonData = (jsonDecode(response.body));
      final data = jsonData;
      Get.to(DetailArticles(), arguments: data);
    } catch (e) {
      print(e);
    }
  }

  Future<List<Map<String, dynamic>>> getPosts(id) async {
    List<Map<String, dynamic>> result = [];
    var headers = {"Accept": "application/json"};
    try {
      var url = Uri.parse('$url_wordpress/wp-json/wp/v2/posts?categories=$id&status=publish');
      http.Response response = await http.get(url, headers: headers);
      if (response.statusCode != 200) {
        return result;
      }
      final jsonData = (jsonDecode(response.body));

      for (var data in jsonData) {
        result.add({
          'id': data['id'],
          'title': data['title']['rendered'],
          // 'author': await getUser(data['author']),
          'image': await getImage(data['featured_media']),
          'date': data['date_gmt'],
          'comment_length': await countComment(data['id']),
        });
      }
    } catch (e) {
      print(e);
    }

    return result;
  }

  // List categories = await getArticles();
  Future<List<Map<String, dynamic>>> getArticles() async {
    List<Map<String, dynamic>> result = [];
    var headers = {"Accept": "application/json"};
    try {
      var url = Uri.parse('$url_wordpress/wp-json/wp/v2/categories?parent=50');
      http.Response response = await http.get(url, headers: headers);
      // print(url);
      // print(response.statusCode);
      // print(response.body);
      if (response.statusCode != 200) {
        return result;
      }
      final jsonData = (jsonDecode(response.body));

      for (var data in jsonData) {
        result.add({
          'category_name': data['name'],
          'data': await getPosts(data['id']),
        });
      }
    } catch (e) {
      print(e);
    }
    return result;
  }

  Future<List<Map<String, dynamic>>> getLatestArticles() async {
    List<Map<String, dynamic>> result = [];
    var headers = {"Accept": "application/json"};
    try {
      var url = Uri.parse('$url_wordpress/wp-json/wp/v2/posts/?status=publish');
      http.Response response = await http.get(url, headers: headers);

      if (response.statusCode != 200) {
        return result;
      }
      final jsonData = (jsonDecode(response.body));

      for (var data in jsonData) {
        result.add({
          'id': data['id'],
          'title': data['title']['rendered'],
          'image': await getImage(data['featured_media']),
          'date': data['date_gmt'],
          'comment_length': await countComment(data['id']),
        });
      }
    } catch (e) {
      print(e);
    }
    return result;
  }

  // Future<Map<String, dynamic>> getUser(id) async {
  //   var username = 'admin';
  //   // var password = 'eNmBwwVo6*Iug)%2P0p@4YIy';
  //   var password = 'Aicademy12345678';

  //   Map<String, dynamic> result = {};
  //   var headers = {
  //     'Authorization': 'Basic ${base64Encode(utf8.encode('$username:$password'))}',
  //     'Accept': 'application/json',
  //   };
  //   try {
  //     // var url_wordpress = url_wordpress;
  //     var url = Uri.parse('$url_wordpress/wp-json/wp/v2/users?id=$id');
  //     http.Response response = await http.get(url, headers: headers);

  //     if (response.statusCode != 200) {
  //       return result;
  //     }
  //     final jsonData = (jsonDecode(response.body));
  //     print(jsonData);

  //     // for (var data in jsonData) {
  //     //   result.add({
  //     //     'id': data['id'],
  //     //     'name': data['name'],
  //     //     'posts': await getPosts(data['id']),
  //     //   });
  //     // }
  //   } catch (e) {
  //     print({e});
  //   }

  //   return result;
  // }
}

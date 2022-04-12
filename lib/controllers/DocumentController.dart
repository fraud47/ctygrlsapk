import 'package:city_girls/config/index.dart';
import 'package:city_girls/models/Document.dart';
import 'package:city_girls/models/videos.dart';

import '../models/videos.dart';

import 'package:dio/dio.dart';
import '../config/urls.dart';

Dio dio = Dio();

class DocumentController {
  // location

  static Future<List<Document>> getAll() async {
    try {
      Response response;

      response = await dio.get(
        AppUrl.allDocuments,
      );

      if (response.statusCode == 200) {
        List<Document> documents = response.data
            .map<Document>((item) => Document.fromJson(item))
            .toList();

        return documents;
      }
    } catch (e) {
      return null;
    }
  }
}

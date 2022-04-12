import 'package:city_girls/config/urls.dart';
import 'package:city_girls/controllers/DocumentController.dart';
import 'package:city_girls/models/Document.dart';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DocumentProvider extends ChangeNotifier {
  List<Document> _documents = [];

  getDocuments() async {
    List<Document> docs = await DocumentController.getAll();
    if (docs != null) {
      _documents = docs;
      notifyListeners();
    }
  }

  set documents(value) => this._documents = value;
  get documents => _documents;
}

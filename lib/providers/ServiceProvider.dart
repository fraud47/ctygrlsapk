import 'package:city_girls/config/urls.dart';
import 'package:city_girls/models/Service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../controllers/ServiceController.dart';

enum ServiceStatus {
  NotUploaded,
  Uploading,
  Uploaded,
}

class ServiceProvider extends ChangeNotifier {
  ServiceStatus _Service = ServiceStatus.NotUploaded;
  get _service => this._Service;
  set _service(value) => this._Service = value;

  List<Service> _services = [];

  List<Service> _servicesCategories = [];
  List<Service> _favourites = [];
  List<Service> _servicesLocation = [];

  getServices() async {
    List<Service> services = await ServiceController.getAll();
    if (services != null) {
      _services = services;
      notifyListeners();
    }
  }

  getFavourites() async {
    List<Service> services = await ServiceController.getAll();
    if (services != null) {
      _favourites = services;
      notifyListeners();
    }
  }

  set service(value) => this._services = value;
  get services => _services;
  get favourites => _favourites;

  // List<Service> get services => _services;
  // List<Service> get ServiceLocation => _servicesLocation;
  // List<Service> get CategoryService => _servicesCategories;

  // getCategoryServices(String category) async {
  //   List<Service> services = await ServiceController.getCategory(category);
  //   if (services != null) {
  //     _servicesCategories = services;
  //     notifyListeners();
  //   }
  // }

  // set ServiceLocation(value) => this._servicesLocation = value;
}

import 'package:city_girls/config/index.dart';

import 'package:flutter/cupertino.dart';

import '../models/Service.dart';

import 'package:dio/dio.dart';
import '../config/urls.dart';

Dio dio = Dio();

class ServiceController {
  // location

  static Future<List<Service>> getAll() async {
    try {
      Response response;

      response = await dio.get(
        AppUrl.allServices,
      );

      if (response.statusCode == 200) {
        List<Service> services = response.data
            .map<Service>((item) => Service.fromJson(item))
            .toList();

        return services;
      }
    } catch (e) {
      return null;
    }
  }

// service by category

  static Future<List<Service>> getCategory(String category) async {
    try {
      Response response;

      response = await dio.get(
        AppUrl.allServices + '${category}/',
      );

      if (response.statusCode == 200) {
        List<Service> services = response.data
            .map<Service>((item) => Service.fromJson(item))
            .toList();
        if (services.isEmpty) {
          return null;
        }
        return services;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<List<Service>> getFavourites(String token) async {
    try {
      Response response;
      dio.options.headers = {'x-access-token': token};
      response = await dio.get(
        AppUrl.Favourite,
      );

      if (response.statusCode == 200) {
        List<Service> services = response.data
            .map<Service>((item) => Service.fromJson(item))
            .toList();
        if (services.isEmpty) {
          return null;
        }
        return services;
      }
    } catch (e) {
      return null;
    }
  }

  // service by location
  static Future<List<Service>> getLocation(String location) async {
    try {
      Response response;

      response = await dio.get(
        AppUrl.allServices + 'location/' '${location}/',
      );

      if (response.statusCode == 200) {
        List<Service> services = response.data
            .map<Service>((item) => Service.fromJson(item))
            .toList();
        if (services.isEmpty) {
          return null;
        }
        return services;
      }
    } catch (e) {
      return null;
    }
  }
  // user service

  static Future<Service> userService(String id) async {
    try {
      Response response;

      response = await dio.get(
        AppUrl.allServices + '/user/' '${id}/',
      );

      if (response.statusCode == 200) {
        Service service = Service.fromJson(response.data);

        return service;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<Map<String, dynamic>> postService({
    @required String accessToken,
    @required String category,
    @required String logoUrl,
    @required String serviceName,
    @required String description,
    @required String location,
    @required String websiteUrl,
    @required String email,
    @required String phoneNumber,
    @required bool available,
    @required bool published,
    @required String userId,
    @required List<String> socialmedia,
  }) async {
    dio.options.headers['x-access-token'] = accessToken;

    var result;

    Response response;

    var data = {
      "socialmedia": socialmedia,
      "category": category,
      "serviceName": serviceName,
      "description": description,
      "location": location,
      "websiteUrl": websiteUrl,
      "email": email,
      "logoUrl": logoUrl,
      "phoneNumber": phoneNumber,
      "available": available,
      "published": published,
      "userId": userId,
    };
    try {
      response = await dio.post(
        AppUrl.allServices,
        data: data,
      );
      if (response.statusCode == 201) {
        result = {"result": false};
        return result;
      }
      result = {"result": true};
      return result;
    } catch (e) {
      result = {"result": false};
      return result;
    }
  }
}

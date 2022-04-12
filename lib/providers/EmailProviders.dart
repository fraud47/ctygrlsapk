import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import '../config/index.dart';

import '../models/index.dart';
import 'dart:convert' as convert;
import 'package:provider/provider.dart';

enum StatusInquiry {
  NotSent,
  Sending,
  Sent,
}

class EmailProviders extends ChangeNotifier {
  StatusInquiry _InquiryStatus = StatusInquiry.NotSent;

  get InquiryStatus => this._InquiryStatus;

  set InquiryStatus(value) => this._InquiryStatus = value;

  Future<Map<String, dynamic>> Inquiry(
      String email, name, CustomerEmail, phone, about, service) async {
    var result;

    final Map<String, dynamic> emailData = {
      'email': email,
      'name': name,
      'CustomerEmail': CustomerEmail,
      'phone': phone,
      'about': about,
      'service': service,
    };

    _InquiryStatus = StatusInquiry.Sending;
    notifyListeners();

    try {
      Response response = await post(
        AppUrl.inquiry,
        body: convert.jsonEncode(emailData),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      switch (response.statusCode) {
        case 200:
          final Map<String, dynamic> responseData =
              convert.jsonDecode(response.body);

          _InquiryStatus = StatusInquiry.Sent;
          notifyListeners();

          result = {'statusInquiry': true, 'message': 'Successful'};
          break;
        case 401:
        case 404:
        case 500:
          _InquiryStatus = StatusInquiry.NotSent;
          notifyListeners();
          final Map<String, dynamic> responseData =
              convert.jsonDecode(response.body);
          result = {
            'statusInquiry': false,
            'message': responseData['message'],
          };
          break;
      }
    } on SocketException catch (e) {
      result = {'statusInquiry': false, 'message': "$e"};
      _InquiryStatus = StatusInquiry.NotSent;
      notifyListeners();
    }

    return result;
  }
}

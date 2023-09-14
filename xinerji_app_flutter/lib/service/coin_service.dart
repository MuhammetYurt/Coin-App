import 'dart:convert';

import 'package:xinerji_app_flutter/model/coin_model.dart';
import 'package:http/http.dart' as http;

class CoinService {
  final String url = 'https://api.coincap.io/v2/assets?limit=20';
  Future<CoinModel?> fetchDatas() async {
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonBody = CoinModel.fromJson(jsonDecode(response.body));
      return jsonBody;
    } else {
      print('istek basarisiz oldu. status kodu = ${response.statusCode}');
    }
  }
}

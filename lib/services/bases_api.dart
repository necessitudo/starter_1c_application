import 'dart:convert';

import 'package:starter_1c_application/models/base_description.dart';
import 'package:http/http.dart' as http;

class BasesApi {
  const BasesApi();

  static const baseURL = 'https://62e2ca8ab54fc209b88088b1.mockapi.io/api/v1';

  Future<List<BaseDescription>> fetchBases() async {
    var url = BasesApi.baseURL;
    url += '/bases';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      if (json['status'] == 'ok') {
        final dynamic basesJSON = json['items'] ?? [];
        final List<BaseDescription> basesDescription = basesJSON
            .map<BaseDescription>((value) => BaseDescription.fromJson(value))
            .toList();

        return basesDescription;
      } else {
        throw Exception(json['message'] ?? 'Failed to load bases');
      }
    } else {
      throw Exception('Failed to load bases (bad response)');
    }
  }
}

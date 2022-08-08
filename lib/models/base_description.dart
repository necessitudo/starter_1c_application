import 'package:starter_1c_application/models/base_category.dart';

class BaseDescription {
  final String id;
  final String name;
  final String executablePath;
  final BaseCategory baseCategory;

  const BaseDescription(
      {required this.id,
      required this.name,
      required this.executablePath,
      required this.baseCategory});

  factory BaseDescription.fromJson(Map<String, dynamic> json) {
    return BaseDescription(
      id: json['id'],
      name: json['name'],
      executablePath: json['executablePath'],
      baseCategory: BaseCategory.values
          .firstWhere((value) => value.name == json['baseCategory']),
    );
  }
}

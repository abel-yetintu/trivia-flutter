import 'package:trivio/core/utils/data_mapper.dart';
import 'package:trivio/features/trivia/domain/entities/trivia_category.dart';

class TriviaCategoryModel extends DataMapper<TriviaCategory> {
  TriviaCategoryModel({required this.id, required this.name});

  final int id;
  final String name;

  @override
  TriviaCategory mapToEntity() {
    return TriviaCategory(id: id, name: name);
  }

  factory TriviaCategoryModel.fromMap(Map<String, dynamic> map) {
    return TriviaCategoryModel(id: map['id'], name: map['name']);
  }
}

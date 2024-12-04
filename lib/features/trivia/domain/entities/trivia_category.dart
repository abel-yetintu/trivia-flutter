import 'package:equatable/equatable.dart';

class TriviaCategory extends Equatable {
  const TriviaCategory({required this.id, required this.name});

  final int id;
  final String name;

  @override
  List<Object?> get props => [id, name];
}

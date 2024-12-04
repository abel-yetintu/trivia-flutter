import 'package:equatable/equatable.dart';
import 'package:trivio/features/trivia/domain/entities/trivia_category.dart';

sealed class CategoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class CategoryInitial extends CategoryState {}

final class CategoryLoading extends CategoryState {}

final class CategoryFetched extends CategoryState {
  final List<TriviaCategory> categories;

  CategoryFetched({required this.categories});

  @override
  List<Object?> get props => [categories];
}

final class CategoryError extends CategoryState {
  final String message;

  CategoryError({required this.message});

  @override
  List<Object?> get props => [message];
}

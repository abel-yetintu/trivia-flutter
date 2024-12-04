import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivio/features/trivia/domain/entities/trivia_category.dart';
import 'package:trivio/features/trivia/domain/usecases/get_trivia_categories_usecase.dart';
import 'package:trivio/features/trivia/presentation/cubits/category/category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final GetTriviaCategoriesUsecase _getTriviaCategoriesUsecase;

  CategoryCubit({required GetTriviaCategoriesUsecase getTriviaCategoriesUsecase})
      : _getTriviaCategoriesUsecase = getTriviaCategoriesUsecase,
        super(CategoryInitial());

  Future<void> fetchCategories() async {
    emit(CategoryLoading());
    final result = await _getTriviaCategoriesUsecase.execute();
    result.fold(
      (failure) {
        emit(CategoryError(message: failure.message));
      },
      (categories) {
        categories.add(const TriviaCategory(id: -1, name: 'Any'));
        emit(CategoryFetched(categories: categories));
      },
    );
  }
}

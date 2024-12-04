enum QuestionType {
  any(displayName: 'Any'),
  multipleChoice(displayName: 'Multiple Choice'),
  trueFalse(displayName: 'True / False');

  final String displayName;

  const QuestionType({required this.displayName});

  static QuestionType fromString(String value) {
    switch (value.toLowerCase()) {
      case 'boolean':
        return QuestionType.multipleChoice;
      case 'multiple':
        return QuestionType.trueFalse;
      default:
        throw ArgumentError('Invalid question type value: $value');
    }
  }
}

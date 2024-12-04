enum Difficulty {
  any,
  easy,
  medium,
  hard;

  static Difficulty fromString(String value) {
    switch (value.toLowerCase()) {
      case 'easy':
        return Difficulty.easy;
      case 'medium':
        return Difficulty.medium;
      case 'hard':
        return Difficulty.hard;
      default:
        throw ArgumentError('Invalid difficulty value: $value');
    }
  }
}

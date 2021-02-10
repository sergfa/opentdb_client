/// Used to obtain a quiz by specified difficalty.
enum OpentdbQuizDifficalty {
  EASY,
  MEDIUM,
  HARD,
}

extension OpentdbQuizDifficaltyExtension on OpentdbQuizDifficalty {
  String get name {
    switch (this) {
      case OpentdbQuizDifficalty.EASY:
        return 'easy';
      case OpentdbQuizDifficalty.MEDIUM:
        return 'medium';
      case OpentdbQuizDifficalty.HARD:
        return 'hard';
      default:
        return null;
    }
  }
}

/// Used to get a quiz that has 4 answers for [OpentdbQuizType.MULTIPLE] or  yes/no answer for [OpentdbQuizType.TRUE_FALSE]
enum OpentdbQuizType {
  /// Quiz with multi answers
  MULTIPLE,

  /// Quiz with True/False answer
  TRUE_FALSE,
}

extension OpentdbQuizTypeExtension on OpentdbQuizType {
  String get name {
    switch (this) {
      case OpentdbQuizType.MULTIPLE:
        return 'multiple';
      case OpentdbQuizType.TRUE_FALSE:
        return 'boolean';
      default:
        return null;
    }
  }
}

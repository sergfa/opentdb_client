import 'dart:convert';
import 'package:meta/meta.dart';

/// [OpentdbQuizItem] represent an item in quiz.
class OpentdbQuizItem {
  /// The name of category
  final String category;

  /// The type of the question multple or True/False
  final String type;

  /// The difficulty of the question
  final String difficulty;

  /// The actual question
  final String question;

  /// Holds the correct answer
  final String correctAnswer;

  /// Holds the index of [correctAnswer] in [allAnswers]
  final int correctAnswerIndex;
  final List<String> allAnswers;

  /// Create an instacnce of the quiz item.
  OpentdbQuizItem({
    @required this.category,
    @required this.type,
    @required this.difficulty,
    @required this.question,
    @required this.correctAnswer,
    @required this.allAnswers,
    @required this.correctAnswerIndex,
  });

  /// Creates a new instance of [OpentdbQuizItem] from map.
  ///
  /// Use [json.decode()] to create a map from specified json.
  factory OpentdbQuizItem.fromMap(Map<String, dynamic> map) {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    var correctAnswer = stringToBase64.decode(map['correct_answer']);
    var allAnswers = List<String>.from(map['incorrect_answers'])
        .map((e) => stringToBase64.decode(e))
        .toList();
    allAnswers.add(correctAnswer);
    allAnswers.shuffle();
    int correctAnswerIndex = 0;
    for (int i = 0; i < allAnswers.length; i++) {
      if (allAnswers[i] == correctAnswer) {
        correctAnswerIndex = i;
        break;
      }
    }
    return OpentdbQuizItem(
      category: stringToBase64.decode(map['category']),
      type: map['type'],
      difficulty: map['difficulty'],
      question: stringToBase64.decode(map['question']),
      correctAnswer: correctAnswer,
      allAnswers: allAnswers,
      correctAnswerIndex: correctAnswerIndex,
    );
  }

  /// Creates a new instance of [OpentdbQuizItem] from json string
  factory OpentdbQuizItem.fromJson(String source) =>
      OpentdbQuizItem.fromMap(json.decode(source));
}

import 'dart:async' show Future;

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:opentdb_client/src/models/category_item.dart';

class OpentdbQuizProvider {
  static final List<OpentdbCategoryItem> categories = [
    OpentdbCategoryItem(name: "Random", id: -1),
    OpentdbCategoryItem(name: "General Knowledge", id: 9),
    OpentdbCategoryItem(name: "Books", id: 10),
    OpentdbCategoryItem(name: "Film", id: 11),
    OpentdbCategoryItem(name: "Music", id: 12),
    OpentdbCategoryItem(name: "Musicals and Theatres", id: 13),
    OpentdbCategoryItem(name: "Television", id: 14),
    OpentdbCategoryItem(name: "Video Games", id: 15),
    OpentdbCategoryItem(name: "Board Games", id: 16),
    OpentdbCategoryItem(name: "Science and Nature", id: 17),
    OpentdbCategoryItem(name: "Computers", id: 18),
    OpentdbCategoryItem(name: "Mathematics", id: 19),
    OpentdbCategoryItem(name: "Mythology", id: 20),
    OpentdbCategoryItem(name: "Sports", id: 21),
    OpentdbCategoryItem(name: "Geography", id: 22),
    OpentdbCategoryItem(name: "History", id: 23),
    OpentdbCategoryItem(name: "Politics", id: 24),
    OpentdbCategoryItem(name: "Art", id: 25),
    OpentdbCategoryItem(name: "Celebrities", id: 26),
    OpentdbCategoryItem(name: "Animals", id: 27),
    OpentdbCategoryItem(name: "Vehicles", id: 28),
    OpentdbCategoryItem(name: "Entertainment", id: 29),
    OpentdbCategoryItem(name: "Gadgets", id: 30),
    OpentdbCategoryItem(name: "Japanese Anime", id: 31),
    OpentdbCategoryItem(name: "Cartoon and Animations", id: 32)
  ];

  OpentdbQuizProvider._();

  static const API_URL = 'opentdb.com';

  static Future<http.Response> fetchQuiz({
    http.Client client,
    int category,
    String difficulty,
    String type,
    @required int amount,
  }) {
    Map<String, String> queryParams =
        _createFetchQuizQueryParamMap(amount, category, difficulty, type);
    var uri = Uri.https(API_URL, 'api.php', queryParams).toString();
    return client != null ? client.get(uri) : http.get(uri);
  }

  static Map<String, String> _createFetchQuizQueryParamMap(
      int amount, int category, String difficulty, String type) {
    Map<String, String> queryParams = {};

    queryParams['amount'] = amount != null ? amount.toString() : '20';

    if (category != null && category > 0) {
      queryParams['category'] = category.toString();
    }
    if (difficulty != null) {
      queryParams['difficulty'] = difficulty;
    }

    if (type != null) {
      queryParams['type'] = type;
    }
    queryParams['encode'] = 'base64';
    return queryParams;
  }
}

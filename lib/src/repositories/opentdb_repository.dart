import 'package:meta/meta.dart';
import 'package:opentdb_client/opentdb_client.dart';
import 'package:opentdb_client/src/models/enums.dart';
import 'package:opentdb_client/src/models/quiz_item.dart';
import 'package:opentdb_client/src/models/quiz_response.dart';
import 'package:opentdb_client/src/providers/opentdb_provider.dart';
import 'package:http/http.dart' as http;

/// Use [OpentdbRepository] to get list of categories or to fetch a quiz
class OpentdbRepository {
  OpentdbRepository._();

  /// Returns list of categoreis [List<OpentdbCategoryItem>].
  /// Each category [OpentdbCategoryItem] is represented by name and id.
  static List<OpentdbCategoryItem> fetchCategories() =>
      OpentdbQuizProvider.categories
          .map((c) => OpentdbCategoryItem(name: c.name, id: c.id))
          .toList();

  /// Get a quiz by specified category, difficulty and type.
  /// if no category is provided than a quiz will have questions from different random categories.
  /// This method may throw exception if status code from API was not 200 if response code was not 0.
  /// if http client not provided then a one time use http client will be created and closed after use.
  static Future<List<OpentdbQuizItem>> fetchQuiz(
      {http.Client client,
      int category,
      OpentdbQuizDifficalty difficulty,
      OpentdbQuizType type,
      @required int amount}) async {
    final response = await OpentdbQuizProvider.fetchQuiz(
      client: client,
      amount: amount,
      category: category,
      difficulty: difficulty != null ? difficulty.name : null,
      type: type != null ? type.name : null,
    );

    if (response.statusCode == 200) {
      final parsedResponse = OpentdbFetchQuizResponse.fromJson(response.body);
      if (parsedResponse.responseCode == 0) {
        return parsedResponse.results;
      } else {
        throw Exception([
          'Failed to get quiz. Response code ${parsedResponse.responseCode}'
        ]);
      }
    } else {
      throw Exception(
          ['Failed to get quiz. Status code ${response.statusCode}']);
    }
  }
}

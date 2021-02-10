import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:opentdb_client/src/models/quiz_item.dart';

class OpentdbFetchQuizResponse {
  int responseCode;
  List<OpentdbQuizItem> results;

  OpentdbFetchQuizResponse({
    @required this.responseCode,
    this.results,
  });

  factory OpentdbFetchQuizResponse.fromMap(Map<String, dynamic> map) {
    return OpentdbFetchQuizResponse(
      responseCode: map['response_code'],
      results: List<OpentdbQuizItem>.from(
          map['results'].map((x) => OpentdbQuizItem.fromMap(x))),
    );
  }

  factory OpentdbFetchQuizResponse.fromJson(String source) =>
      OpentdbFetchQuizResponse.fromMap(json.decode(source));
}

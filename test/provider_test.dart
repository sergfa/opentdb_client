import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:opentdb_client/opentdb_client.dart';
import 'package:opentdb_client/src/providers/opentdb_provider.dart';

// Create a MockClient using the Mock class provided by the Mockito package.
// Create new instances of this class in each test.
class MockClient extends Mock implements http.Client {}

main() {
  final response =
      '{"response_code":0,"results":[{"category":"RW50ZXJ0YWlubWVudDogTXVzaWM=","type":"bXVsdGlwbGU=","difficulty":"bWVkaXVt","question":"V2hvIGlzIHRoZSBmcm9udG1hbiBvZiBNdXNlPw==","correct_answer":"TWF0dCBCZWxsYW15","incorrect_answers":["RG9taW5pYyBIb3dhcmQ=","VGhvbSBZb3JrZQ==","Sm9ubnkgR3JlZW53b29k"]}]}';

  group('Provider: fetchQuiz with type multiple', () {
    test('shoud return status code 200 if the http call completes successfully',
        () async {
      await onSuccess(OpentdbQuizType.MULTIPLE, response);
    });

    test(
        'shoud return status code 500 if the http call completes with status code 500',
        () async {
      onBadStatusCode(OpentdbQuizType.TRUE_FALSE);
    });
  });

  group('Provider: fetchQuiz with type boolean', () {
    test('shoud return status code 200 if the http call completes successfully',
        () async {
      await onSuccess(OpentdbQuizType.TRUE_FALSE, response);
    });

    test(
        'shoud return status code 500 if the http call completes with status code 500',
        () async {
      onBadStatusCode(OpentdbQuizType.TRUE_FALSE);
    });
  });
}

Future onSuccess(OpentdbQuizType type, String response) async {
  final client = MockClient();

  when(client.get(
          'https://${OpentdbQuizProvider.API_URL}/api.php?amount=1&type=${type.name}&encode=base64'))
      .thenAnswer((_) async => http.Response(response, 200));

  expect(
      (await OpentdbQuizProvider.fetchQuiz(
        type: type.name,
        amount: 1,
        client: client,
      ))
          .statusCode,
      equals(200));
}

void onBadStatusCode(OpentdbQuizType type) async {
  final client = MockClient();

  when(client.get(
          'https://${OpentdbQuizProvider.API_URL}/api.php?amount=1&type=${type.name}&encode=base64'))
      .thenAnswer((_) async => http.Response('Someting wroong', 500));

  expect(
      (await OpentdbQuizProvider.fetchQuiz(
              type: type.name, amount: 1, client: client))
          .statusCode,
      equals(500));
}

# opentdb_client

[![pub package](https://img.shields.io/pub/v/opentdb_client.svg?logo=dart&logoColor=00b9fc)](https://pub.dartlang.org/packages/opentdb_client)
[![Last Commits](https://img.shields.io/github/last-commit/sergfa/opentdb_client?logo=git&logoColor=white)](https://github.com/sergfa/opentdb_client/commits/main)
[![Pull Requests](https://img.shields.io/github/issues-pr/sergfa/opentdb_client?logo=github&logoColor=white)](https://github.com/sergfa/opentdb_client/pulls)
[![Code size](https://img.shields.io/github/languages/code-size/sergfa/opentdb_client?logo=github&logoColor=white)](https://github.com/sergfa/opentdb_client)
[![License](https://img.shields.io/github/license/sergfa/opentdb_client?logo=open-source-initiative&logoColor=green)](https://github.com/sergfa/opentdb_client/blob/main/LICENSE)


Unofficial client for Open Trivia Quiz API (opentdb.com). Use of this API does not require a API Key

**Show some ❤️ and star the repo to support the project**


## Getting Started

#### To install the opentdb_client package, add it to the dependencies section of the pubspec.yaml file. You can find the latest version of the http package the pub.dev.


```yaml

dependencies:
  opentdb_client: <latest_version>

```

#### In your AndroidManifest.xml file, add the Internet permission.

```xml

<!-- Required to fetch data from the internet. -->
<uses-permission android:name="android.permission.INTERNET" />

```

#### Import the opentdb_client package.

```dart

import 'package:opentdb_client/opentdb_client.dart';

```

#### Get list of all quiz categories such as Films, Books, Computers, Sports etc...

```dart

// Each category has name and id
final List<OpentdbCategoryItem> categories = OpentdbRepository.fetchCategories();

```

#### Get a quiz for Film category, difficulty easy, 20 questions, every question has 4 options (multiple) and one correct answer

```dart

Future<List<OpentdbQuizItem>> fetchQuiz() async {
    List<OpentdbQuizItem> quizItems = [];
    // First of all get all categories. (this is not  HTTP call)
    final List<OpentdbCategoryItem> categories =
        OpentdbRepository.fetchCategories();
    // Find a category for films and get its id
    final OpentdbCategoryItem quizCategory =
        categories.where((element) => element.name == 'Film').first;
   // Make http request to get a quiz
    try {
      quizItems = await OpentdbRepository.fetchQuiz(
        category: quizCategory.id,
        amount: 20,
        difficulty: OpentdbQuizDifficalty.EASY,
        type: OpentdbQuizType.MULTIPLE,
      );
    } catch (e) {
        print('Something went wrong ${e.toString()}')
    }
    return quizItems;
  }

```

#### Get a random quiz, responses with list of questions from diffirent categoreis


```dart
  quizItems = await OpentdbRepository.fetchQuiz(
        amount: 20,
        difficulty: OpentdbQuizDifficalty.EASY,
        type: OpentdbQuizType.MULTIPLE,
      );

```

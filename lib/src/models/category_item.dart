import 'package:meta/meta.dart';

/// Use instance of [OpentdbCategoryItem]  to get id or name of  the category.
/// The id of category is used by [OpentdbRepository] to fetch a quiz.
/// The name of category can be used to display it to users.
/// To get list of all categories use [OpentdbRepository.fetchCategories] function.
class OpentdbCategoryItem {
  /// The name of category
  /// For example: Film, Music, Books, etc...
  final String name;
  /// The id of the category
  final int id;

  /// Create a new instance of [OpentdbCategoryItem].
  /// To get list of all categories use [OpentdbRepository.fetchCategories] function. 
  OpentdbCategoryItem({@required this.name, @required this.id});

  @override
  String toString() {
    return 'Name: $name, Value: $id';
  }
}
import 'package:estante/enums/condition_enum.dart';
import 'package:estante/models/book_model.dart';

class AdModel {
  const AdModel({required this.book, required this.price, required this.condition, this.comment, required this.publishedDate});

  final BookModel book;
  final double price;
  final ConditionEnum condition;
  final String? comment;
  final DateTime publishedDate;
}
import 'package:estante/models/author_model.dart';
import 'package:estante/models/publisher_model.dart';

class BookModel {
  const BookModel({required this.title, this.isbn, this.author, this.publisher, this.publishedYear});

  final String title;
  final String? isbn;
  final AuthorModel? author;
  final PublisherModel? publisher;
  final int? publishedYear;
}
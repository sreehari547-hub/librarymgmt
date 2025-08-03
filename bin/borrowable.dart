import 'book.dart';

abstract class Borrowable {
  Future<void> borrowBook(Book book);
  Future<void> returnBook(Book book);
}

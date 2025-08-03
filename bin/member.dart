import 'person.dart';
import 'borrowable.dart';
import 'book.dart';
import 'library.dart';

class Member extends Person implements Borrowable {
  List<Book> borrowedBooks = [];

  Member(String name, String id) : super(name, id);

  @override
  Future<void> borrowBook(Book book) async {
    if (!book.isIssued) {
      print("Borrowing book: ${book.title}...");
      await Future.delayed(Duration(seconds: 2));
      borrowedBooks.add(book);
      book.isIssued = true;
      Library.totalBooksIssued++;
      print("Book borrowed successfully.");
    } else {
      print("Book already issued.");
    }
  }

  @override
  Future<void> returnBook(Book book) async {
    if (borrowedBooks.contains(book)) {
      print("Returning book: ${book.title}...");
      await Future.delayed(Duration(seconds: 2));
      borrowedBooks.remove(book);
      book.isIssued = false;
      print("Book returned successfully.");
    } else {
      print("You don't have this book.");
    }
  }
}

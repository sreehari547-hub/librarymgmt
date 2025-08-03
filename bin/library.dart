import 'book.dart';
import 'member.dart';

class Library {
  static int totalBooksIssued = 0;
  List<Book> books = [];
  List<Member> members = [];
  Map<String, List<String>> borrowingRecords = {}; 

  void addBook(Book book) {
    books.add(book);
    print("Book added: ${book.title}");
  }

  void addMember(Member member) {
    members.add(member);
    borrowingRecords[member.id] = [];
    print("Member added: ${member.name}");
  }

  void showBooks({String? author, String? genre}) {
    print("--- Book List ---");
    for (var book in books) {
      if ((author == null || book.author == author) &&
          (genre == null || book.genre == genre)) {
        print("Title: ${book.title}, Author: ${book.author}, Genre: ${book.genre}, Issued: ${book.isIssued}");
      }
    }
  }

  void showBorrowingRecords() {
    print("--- Borrowing Records ---");
    borrowingRecords.forEach((memberId, bookList) {
      print("Member ID: $memberId => Books: $bookList");
    });
  }
}

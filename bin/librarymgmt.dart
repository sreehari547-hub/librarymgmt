// main.dart (Simplified with user role handling)
import 'dart:io';
import 'book.dart';
import 'member.dart';
import 'library.dart';

void main() async {
  Library lib = Library();

  lib.addBook(Book.named(title: "Premalekhanam", author: "VM Basheer", genre: "Romantic novel", isbn: "B1"));
  lib.addBook(Book.named(title: "Mathilukal", author: "Basheer", genre: "Romantic novel", isbn: "B2"));
  lib.addBook(Book.named(title: "The Hobbit", author: "J.R.R. Tolkien", genre: "Fantasy", isbn: "B3"));
  lib.addBook(Book.named(title: "Ravunni", author: "PM Thaj", genre: "Drama", isbn: "B4"));
  lib.addBook(Book.named(title: "Aadujeevitham", author: "Benyamin", genre: "Novel", isbn: "MAL1"));
  lib.addBook(Book.named(title: "Ranadamuzham", author: "M.T. Vasudevan Nair", genre: "Epic Fiction", isbn: "MAL2"));
  lib.addBook(Book.named(title: "Pathummaayude aad", author: "Vaikom Muhammad Basheer", genre: "Memoir", isbn: "MAL3"));
  lib.addBook(Book.named(title: "Khasakinte ithihasam", author: "O.V. Vijayan", genre: "Philosophical Fiction", isbn: "MAL4"));
  lib.addBook(Book.named(title: "Oru deshathinte katha", author: "S. K. Pottekkatt", genre: "Travel Literature", isbn: "MAL5"));


  

  Member sreehari = Member("Sreehari", "M1");
  Member shyamjith = Member("Shyamjith", "M2");
  lib.addMember(sreehari);
  lib.addMember(shyamjith);

  print("Welcome to Library System");
  stdout.write("Enter role (admin/member): ");
  String role = stdin.readLineSync()?.trim().toLowerCase() ?? '';

  if (role == 'admin') {
    while (true) {
      print("\nAdmin Menu:\n1. Add Book\n2. Add Member\n3. Show Books\n4. Show Borrowing Records\n5. Exit");
      stdout.write("Choose: ");
      String choice = stdin.readLineSync() ?? '';
      if (choice == '1') {
        stdout.write("Title: ");
        String title = stdin.readLineSync() ?? '';
        stdout.write("Author: ");
        String author = stdin.readLineSync() ?? '';
        stdout.write("Genre: ");
        String genre = stdin.readLineSync() ?? '';
        stdout.write("ISBN: ");
        String isbn = stdin.readLineSync() ?? '';
        lib.addBook(Book(title, author, genre, isbn));
      } else if (choice == '2') {
        stdout.write("Name: ");
        String name = stdin.readLineSync() ?? '';
        stdout.write("ID: ");
        String id = stdin.readLineSync() ?? '';
        lib.addMember(Member(name, id));
      } else if (choice == '3') {
        lib.showBooks();
      } else if (choice == '4') {
        lib.showBorrowingRecords();
      } else if (choice == '5') {
        break;
      } else {
        print("Invalid option");
      }
    }
  } else if (role == 'member') {
    stdout.write("Enter your Member ID: ");
    String id = stdin.readLineSync() ?? '';
    Member? member = lib.members.firstWhere((m) => m.id == id, orElse: () => Member("", ""));
    if (member.name.isEmpty) {
      print("Member not found");
      return;
    }

    while (true) {
      print("\nMember Menu:\n1. Show Books\n2. Borrow Book\n3. Return Book\n4. Exit");
      stdout.write("Choose: ");
      String choice = stdin.readLineSync() ?? '';
      if (choice == '1') {
        lib.showBooks();
      } else if (choice == '2') {
        stdout.write("Enter ISBN to borrow: ");
        String isbn = stdin.readLineSync() ?? '';
        Book? book = lib.books.firstWhere((b) => b.isbn == isbn, orElse: () => Book("", "", "", ""));
        if (book.title.isEmpty) {
          print("Book not found");
        } else {
          await member.borrowBook(book);
          lib.borrowingRecords[member.id]?.add(book.isbn);
        }
      } else if (choice == '3') {
        stdout.write("Enter ISBN to return: ");
        String isbn = stdin.readLineSync() ?? '';
        Book? book = lib.books.firstWhere((b) => b.isbn == isbn, orElse: () => Book("", "", "", ""));
        if (book.title.isEmpty) {
          print("Book not found");
        } else {
          await member.returnBook(book);
          lib.borrowingRecords[member.id]?.remove(book.isbn);
        }
      } else if (choice == '4') {
        break;
      } else {
        print("Invalid option");
      }
    }
  } else {
    print("Invalid role");
  }

  print("\nTotal books issued: ${Library.totalBooksIssued}");
} 

class Book {
  String title;
  String author;
  String genre;
  String isbn;
  bool isIssued = false;

  Book(this.title, this.author, this.genre, this.isbn);

  Book.named({
    required this.title,
    required this.author,
    required this.genre,
    required this.isbn,
  });
}

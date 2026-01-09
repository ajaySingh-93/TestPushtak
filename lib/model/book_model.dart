class Book {
  final String title;
  final String category;
  final String imageUrl;
  final String author;
  final String price;

  Book({
    required this.title,
    required this.category,
    required this.imageUrl,
    required this.author,
    required this.price,
  });
}

final List<Book> sampleBooks = [
  Book(
    title: 'Indian Polity 6th Edition',
    category: 'UPSC',
    imageUrl: 'assets/polity.jpg', 
    author: 'M. Laxmikanth',
    price: '₹750',
  ),
  Book(
    title: 'Quantitative Aptitude',
    category: 'SSC/Bank',
    imageUrl: 'assets/quants.jpg', 
    author: 'R.S. Aggarwal',
    price: '₹550',
  ),
  Book(
    title: 'General Knowledge 2024',
    category: 'All Exams',
    imageUrl: 'assets/gk.jpg', 
    author: 'Lucent',
    price: '₹220',
  ),
  Book(
    title: 'A Modern Approach to Verbal Reasoning',
    category: 'Banking',
    imageUrl: 'assets/reasoning.jpg', 
    author: 'R.S. Aggarwal',
    price: '₹600',
  ),
  Book(
    title: 'Certificate Physical and Human Geography',
    category: 'UPSC',
    imageUrl: 'assets/geo.jpg', 
    author: 'G.C. Leong',
    price: '₹350',
  ),
];

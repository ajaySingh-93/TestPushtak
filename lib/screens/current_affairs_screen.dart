import 'package:flutter/material.dart';

// --- Data Model and Dummy Data ---
class _AffairsArticle {
  final String id;
  final String headline;
  final String description;
  final String content;
  final String date;
  final List<String> tags;

  _AffairsArticle({
    required this.id,
    required this.headline,
    required this.description,
    required this.content,
    required this.date,
    required this.tags,
  });
}

final List<_AffairsArticle> _articles = [
  _AffairsArticle(
    id: 'ca1',
    headline: 'New Space Mission to Explore Jupiter\'s Moons',
    description: 'The mission aims to find signs of life on Europa and Ganymede, marking a significant step in space exploration.',
    content: 'A detailed exploration mission has been launched by an international space consortium. The primary objective is to investigate the potential for extraterrestrial life on Jupiter\'s moons, Europa and Ganymede, which are believed to have subsurface oceans.',
    date: 'Today',
    tags: ['Science', 'UPSC'],
  ),
  _AffairsArticle(
    id: 'ca2',
    headline: 'Economic Reforms Announced for Banking Sector',
    description: 'The government has introduced new policies to boost the banking industry and improve credit flow.',
    content: 'In a press conference, the Finance Minister laid out a new set of reforms aimed at strengthening the banking sector. These include measures for capital infusion, NPA reduction, and promoting digital transactions.',
    date: 'Today',
    tags: ['Banking', 'Economy'],
  ),
  _AffairsArticle(
    id: 'ca3',
    headline: 'Supreme Court Verdict on Electoral Bonds',
    description: 'A landmark judgment was passed regarding the transparency of political funding and the controversial bonds scheme.',
    content: 'The Supreme Court delivered its final verdict on the electoral bonds scheme, striking it down as unconstitutional. The court emphasized the voter\'s right to information about political funding sources.',
    date: 'Yesterday',
    tags: ['Polity', 'UPSC'],
  ),
];

// --- Main List Screen ---
class CurrentAffairsScreen extends StatelessWidget {
  const CurrentAffairsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final groupedArticles = _groupArticlesByDate();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Current Affairs'),
      ),
      body: ListView.builder(
        itemCount: groupedArticles.keys.length,
        itemBuilder: (context, index) {
          final dateHeader = groupedArticles.keys.elementAt(index);
          final articlesForDate = groupedArticles[dateHeader]!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                child: Text(
                  dateHeader,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              ...articlesForDate.map((article) => _ArticleCard(article: article)).toList(),
            ],
          );
        },
      ),
    );
  }

  Map<String, List<_AffairsArticle>> _groupArticlesByDate() {
    final Map<String, List<_AffairsArticle>> map = {};
    for (var article in _articles) {
      (map[article.date] ??= []).add(article);
    }
    return map;
  }
}

// --- Reusable Article Card Widget ---
class _ArticleCard extends StatefulWidget {
  final _AffairsArticle article;
  const _ArticleCard({required this.article});

  @override
  State<_ArticleCard> createState() => _ArticleCardState();
}

class _ArticleCardState extends State<_ArticleCard> {
  bool _isBookmarked = false;

  void _navigateToDetail() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            CurrentAffairsDetailScreen(article: widget.article),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          final tween = Tween(begin: begin, end: end);
          final curvedAnimation = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
          return SlideTransition(position: tween.animate(curvedAnimation), child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: _navigateToDetail,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 8, 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.article.headline,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.article.description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      children: widget.article.tags.map((tag) => Chip(
                        label: Text(tag, style: const TextStyle(fontSize: 12)),
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        backgroundColor: Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.5),
                        side: BorderSide.none,
                        visualDensity: VisualDensity.compact,
                      )).toList(),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(_isBookmarked ? Icons.bookmark_rounded : Icons.bookmark_outline_rounded),
                onPressed: () => setState(() => _isBookmarked = !_isBookmarked),
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- Detail Screen (in the same file) ---
class CurrentAffairsDetailScreen extends StatelessWidget {
  final _AffairsArticle article;

  const CurrentAffairsDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.tags.join(' / ')),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              article.headline,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.calendar_today_outlined, size: 14, color: Colors.grey.shade600),
                const SizedBox(width: 8),
                Text(article.date, style: TextStyle(color: Colors.grey.shade600)),
              ],
            ),
            const Divider(height: 40),
            Text(
              article.content,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.6, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
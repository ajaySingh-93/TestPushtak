import 'package:flutter/material.dart';

class StudyMaterialScreen extends StatelessWidget {
  const StudyMaterialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Study Material'),
          bottom: const TabBar(
            indicatorWeight: 3,
            tabs: [
              Tab(text: 'Notes'),
              Tab(text: 'PDFs'),
              Tab(text: 'Videos'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildMaterialList(context, 'notes'),
            _buildMaterialList(context, 'pdfs'),
            _buildMaterialList(context, 'videos'),
          ],
        ),
      ),
    );
  }

  Widget _buildMaterialList(BuildContext context, String type) {
    final Map<String, dynamic> content = {
      'notes': {
        'icon': Icons.note_alt_outlined,
        'items': [
          {'title': 'History Ancient India Notes', 'subtitle': 'Chapter 1-5'},
          {'title': 'Polity Constitutional Framework', 'subtitle': 'Part 1'},
        ],
      },
      'pdfs': {
        'icon': Icons.picture_as_pdf_outlined,
        'items': [
          {'title': 'Monthly Current Affairs - Jan 2024', 'subtitle': 'Full PDF'},
          {'title': 'SSC CGL Previous Year Papers', 'subtitle': '2022-2023'},
        ],
      },
      'videos': {
        'icon': Icons.play_circle_outline,
        'items': [
          {'title': 'Geography Marathon Session', 'subtitle': 'Full 8 Hours'},
          {'title': 'Banking Awareness Masterclass', 'subtitle': 'Episode 1'},
        ],
      },
    };

    final items = content[type]['items'] as List<Map<String, String>>;
    final icon = content[type]['icon'] as IconData;

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: Icon(icon, color: Theme.of(context).primaryColor),
            title: Text(item['title']!, style: const TextStyle(fontWeight: FontWeight.w500)),
            subtitle: Text(item['subtitle']!),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Content will be available soon'),
                behavior: SnackBarBehavior.floating,
              ));
            },
          ),
        );
      },
    );
  }
}
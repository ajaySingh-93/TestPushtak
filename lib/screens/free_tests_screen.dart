import 'package:flutter/material.dart';
import 'dart:async';

// Dummy data model for a test
class _Test {
  final String name;
  final String duration;
  final int questions;

  _Test({required this.name, required this.duration, required this.questions});
}

// Data for all test categories
final Map<String, List<_Test>> _testCategories = {
  'UPSC': [
    _Test(name: 'UPSC CSE Prelims Mock 1', duration: '120 mins', questions: 100),
    _Test(name: 'Indian Polity Sectional Test', duration: '60 mins', questions: 50),
  ],
  'SSC': [
    _Test(name: 'SSC CGL Tier 1 Full Mock', duration: '60 mins', questions: 100),
    _Test(name: 'Quantitative Aptitude Mock', duration: '30 mins', questions: 25),
  ],
  'Banking': [
    _Test(name: 'IBPS PO Prelims Mock Test', duration: '60 mins', questions: 100),
    _Test(name: 'Reasoning Ability Sectional', duration: '20 mins', questions: 35),
  ],
};

class FreeTestsScreen extends StatelessWidget {
  const FreeTestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Free Mock Tests'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        itemCount: _testCategories.keys.length,
        itemBuilder: (context, index) {
          final category = _testCategories.keys.elementAt(index);
          final tests = _testCategories[category]!;
          return _buildCategorySection(context, category, tests);
        },
      ),
    );
  }

  Widget _buildCategorySection(BuildContext context, String category, List<_Test> tests) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            category,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        ...tests.map((test) => _TestCard(test: test)).toList(),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _TestCard extends StatefulWidget {
  final _Test test;
  const _TestCard({required this.test});

  @override
  State<_TestCard> createState() => _TestCardState();
}

class _TestCardState extends State<_TestCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.97).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  void _onTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.test.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildInfoChip(context, Icons.timer_outlined, widget.test.duration),
                    const SizedBox(width: 8),
                    _buildInfoChip(context, Icons.help_outline, '${widget.test.questions} Qs'),
                  ],
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Coming Soon'),
                          content: const Text('The test engine is under development and will be available shortly.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Text('Start Test'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(BuildContext context, IconData icon, String label) {
    return Chip(
      avatar: Icon(icon, size: 16, color: Theme.of(context).colorScheme.onSurfaceVariant),
      label: Text(label),
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
      side: BorderSide.none,
    );
  }
}

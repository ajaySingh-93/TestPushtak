import 'dart:async';
import 'package:flutter/material.dart';
import '../../model/batch_model.dart';

class BatchDetailsScreen extends StatefulWidget {
  final Batch batch;
  final Object heroTag;

  const BatchDetailsScreen({super.key, required this.batch, required this.heroTag});

  @override
  State<BatchDetailsScreen> createState() => _BatchDetailsScreenState();
}

class _BatchDetailsScreenState extends State<BatchDetailsScreen> with TickerProviderStateMixin {
  late AnimationController _contentAnimationController;
  late AnimationController _pulseAnimationController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    // Controller for content entry animation
    _contentAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    // Controller for button pulse animation
    _pulseAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(
        parent: _pulseAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    // Start content animation after a short delay
    Timer(const Duration(milliseconds: 200), () {
      if (mounted) {
        _contentAnimationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _contentAnimationController.dispose();
    _pulseAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Hero(
        tag: widget.heroTag,
        child: Material(
          type: MaterialType.transparency,
          child: CustomScrollView(
            slivers: [
              _buildSliverAppBar(),
              _buildAnimatedContent(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildEnrollButton(),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 250.0,
      pinned: true,
      stretch: true,
      elevation: 0,
      backgroundColor: Colors.blue.shade800,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [StretchMode.zoomBackground],
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Placeholder since batch.imageUrl doesn't exist
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade700, Colors.blue.shade900],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.school_outlined,
                  size: 100,
                  color: Colors.white24,
                ),
              ),
            ),
            // Dark Gradient Overlay
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black54, Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedContent() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAnimatedWidget(
              intervalStart: 0.2,
              child: Text(
                widget.batch.title,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildAnimatedWidget(
              intervalStart: 0.4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildInfoChip(
                    icon: Icons.access_time_filled,
                    text: widget.batch.duration,
                  ),
                  Text(
                    widget.batch.price,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildAnimatedWidget(
              intervalStart: 0.6,
              child: const Text(
                'About this course',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),
            _buildAnimatedWidget(
              intervalStart: 0.7,
              child: Text(
                widget.batch.description,
                style: TextStyle(
                  fontSize: 16,
                  height: 1.6,
                  color: Colors.grey[700],
                ),
              ),
            ),
            const SizedBox(height: 24),
            _buildAnimatedWidget(
              intervalStart: 0.8,
              child: const Text(
                'Target Exams',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),
            _buildAnimatedWidget(
              intervalStart: 0.9,
              child: Wrap(
                spacing: 8.0,
                children: ['UPSC', 'SSC', 'Banking']
                    .map((exam) => Chip(
                  label: Text(exam),
                  backgroundColor: Colors.grey.shade200,
                ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip({required IconData icon, required String text}) {
    return Chip(
      avatar: Icon(icon, size: 18, color: Colors.blue.shade800),
      label: Text(text),
      backgroundColor: Colors.blue.shade50,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    );
  }

  Widget _buildAnimatedWidget({required Widget child, required double intervalStart}) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: _contentAnimationController,
        curve: Interval(intervalStart, 1.0, curve: Curves.easeOut),
      ),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.2),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: _contentAnimationController,
          curve: Interval(intervalStart, 1.0, curve: Curves.easeOut),
        )),
        child: child,
      ),
    );
  }

  Widget _buildEnrollButton() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
        child: ScaleTransition(
          scale: _pulseAnimation,
          child: ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Enrollment feature coming soon!')),
              );
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: Colors.blue.shade700,
              foregroundColor: Colors.white,
              elevation: 5,
            ),
            child: const Text(
              'Enroll Now',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
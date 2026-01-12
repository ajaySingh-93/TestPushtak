import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../../model/batch_model.dart';
import '../../model/book_model.dart';
import '../../screens/my_courses_screen.dart';
import '../../screens/free_tests_screen.dart';
import '../../screens/study_material_screen.dart';
import '../../screens/current_affairs_screen.dart';
import '../../widgets/batch_card.dart';
import '../../widgets/book_card.dart';
import 'drawer_menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController(viewportFraction: 0.9, initialPage: 0);
  int _currentPage = 0;
  Timer? _timer;
  String? _tappedCardTitle;

  final List<String> _bannerImages = [
    'assets/images/gv_exam.jpg',
    'assets/images/gv_exam.jpg',
    'assets/images/gv_exam.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      if (mounted) setState(() {});
    });

    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (!mounted) return;
      if (_currentPage < _bannerImages.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerMenu(),
      appBar: AppBar(
        title: Image.asset(
          'assets/images/testpustak.jpg',
          height: 32,
          errorBuilder: (context, error, stackTrace) {
            return const Text('TestPustak', style: TextStyle(fontWeight: FontWeight.bold));
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            // Banner Carousel
            SizedBox(
              height: 190,
              child: PageView.builder(
                controller: _pageController,
                itemCount: _bannerImages.length,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemBuilder: (context, index) {
                  double scale = 1.0;
                  if (_pageController.position.haveDimensions) {
                    double page = _pageController.page ?? 0.0;
                    scale = max(0.85, 1 - (page - index).abs() * 0.3);
                  }
                  return Transform.scale(
                    scale: scale,
                    child: _buildBannerSlide(
                      imagePath: _bannerImages[index],
                      title: "Prepare for Government Exams",
                      subtitle: "UPSC • SSC • Banking • Railway",
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            _buildPageIndicator(),
            const SizedBox(height: 24),
            // Quick Actions Grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 1.5,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: [
                  _buildQuickActionCard(Icons.play_circle_outline, 'My Courses'),
                  _buildQuickActionCard(Icons.quiz_outlined, 'Free Tests'),
                  _buildQuickActionCard(Icons.library_books_outlined, 'Study Material'),
                  _buildQuickActionCard(Icons.newspaper_outlined, 'Current Affairs'),
                  _buildQuickActionCard(Icons.play_circle_outline, 'My Courses'),
                  _buildQuickActionCard(Icons.quiz_outlined, 'Free Tests'),
                  _buildQuickActionCard(Icons.library_books_outlined, 'Study Material'),
                  _buildQuickActionCard(Icons.newspaper_outlined, 'Current Affairs'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildSectionHeader(context, 'Popular Batches'),
            SizedBox(
              height: 220, // Adjusted height for better proportions
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: sampleBatches.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: 260, // Adjusted width
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: BatchCard(batch: sampleBatches[index]),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            _buildSectionHeader(context, 'Featured Books'),
            SizedBox(
              height: 200, // Adjusted height
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: sampleBooks.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: 140,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: BookCard(book: sampleBooks[index]),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Padding _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 12.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildBannerSlide({required String imagePath, required String title, required String subtitle}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              imagePath,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                  stops: const [0.0, 0.7],
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      shadows: [Shadow(blurRadius: 10, color: Colors.black54)],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                      shadows: const [Shadow(blurRadius: 8, color: Colors.black54)],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_bannerImages.length, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          height: 8.0,
          width: _currentPage == index ? 24.0 : 8.0,
          decoration: BoxDecoration(
            color: _currentPage == index ? Theme.of(context).primaryColor : Colors.grey.shade400,
            borderRadius: BorderRadius.circular(12),
          ),
        );
      }),
    );
  }

  Widget _buildQuickActionCard(IconData icon, String title) {
    final isPressed = _tappedCardTitle == title;
    final scale = isPressed ? 0.95 : 1.0;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      transform: Matrix4.identity()..scale(scale),
      transformAlignment: Alignment.center,
      child: Card(
        elevation: 0, // Using Border instead of elevation
        child: InkWell(
          onTap: () {
            // NAVIGATION LOGIC
            Widget? screen;
            if (title == 'My Courses') {
              screen = const MyCoursesScreen();
            } else if (title == 'Free Tests') {
              screen = const FreeTestsScreen();
            } else if (title == 'Study Material') {
              screen = const StudyMaterialScreen();
            } else if (title == 'Current Affairs') {
              screen = const CurrentAffairsScreen();
            }

            if (screen != null) {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => screen!,
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0.0, 0.1),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      ),
                    );
                  },
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('\'$title\' selected'),
                duration: const Duration(seconds: 1),
                behavior: SnackBarBehavior.floating,
              ));
            }
          },
          onHighlightChanged: (highlighted) {
            setState(() {
              _tappedCardTitle = highlighted ? title : null;
            });
          },
          splashColor: Theme.of(context).primaryColor.withOpacity(0.1),
          highlightColor: Theme.of(context).primaryColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(icon, color: Theme.of(context).primaryColor),
                const SizedBox(width: 12),
                Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.w500))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
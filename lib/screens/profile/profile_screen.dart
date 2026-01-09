import 'dart:async';
import 'package:flutter/material.dart';
import '../login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: Column(
          children: [
            _buildAnimatedItem(
              interval: 0.1,
              child: _buildProfileHeader(),
            ),
            const SizedBox(height: 32),
            _buildAnimatedItem(
              interval: 0.3,
              child: _buildInfoCard(
                icon: Icons.email_outlined,
                title: 'Email Address',
                subtitle: 'user@testpustak.com',
              ),
            ),
            _buildAnimatedItem(
              interval: 0.4,
              child: _buildInfoCard(
                icon: Icons.phone_outlined,
                title: 'Phone Number',
                subtitle: '+91-9876543210',
              ),
            ),
            _buildAnimatedItem(
              interval: 0.5,
              child: _buildInfoCard(
                icon: Icons.track_changes_outlined,
                title: 'Target Exam',
                subtitle: 'UPSC Civil Services',
              ),
            ),
            const SizedBox(height: 32),
            _buildAnimatedItem(
              interval: 0.7,
              child: _buildLogoutButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 15,
                spreadRadius: 2,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: const CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.person_outline,
              size: 50,
              color: Colors.blue,
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'TestPustak User',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'UPSC Aspirant',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard({required IconData icon, required String title, required String subtitle}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.grey.shade200),
        ),
        child: ListTile(
          leading: Icon(icon, color: Colors.blue),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
          subtitle: Text(subtitle, style: TextStyle(color: Colors.grey[700])),
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ElevatedButton.icon(
        icon: const Icon(Icons.logout),
        label: const Text('Logout'),
        onPressed: () {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginScreen()),
                (Route<dynamic> route) => false,
          );
        },
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          foregroundColor: Colors.red,
          backgroundColor: Colors.red.shade50,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
      ),
    );
  }

  Widget _buildAnimatedItem({required Widget child, required double interval}) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 0.5),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(interval, 1.0, curve: Curves.easeOut),
        ),
      ),
      child: FadeTransition(
        opacity: CurvedAnimation(
          parent: _animationController,
          curve: Interval(interval, 1.0, curve: Curves.easeOut),
        ),
        child: child,
      ),
    );
  }
}
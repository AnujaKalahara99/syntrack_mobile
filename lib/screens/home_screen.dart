import 'package:flutter/material.dart';
import '../components/background_image.dart';
import '../components/search_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image at the top
          const BackgroundImage(),

          // Scrollable Content
          SingleChildScrollView(
            child: Column(
              children: [
                // Spacer to push content below the background image
                const SizedBox(height: 200),

                // Main Content Container
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0),
                    ),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomSearchBar(),
                      const Text(
                        'Welcome to SynTrack',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Add your content widgets here
                      _buildContentSection(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCard(
          title: 'Your Progress',
          content:
              'Track your daily activities and see your progress over time.',
        ),
        const SizedBox(height: 16),
        _buildCard(
          title: 'Recent Activities',
          content: 'View your recent activities and achievements.',
        ),
        const SizedBox(height: 16),
        _buildCard(
          title: 'Statistics',
          content: 'Check your performance statistics and insights.',
        ),
        const SizedBox(height: 16),
        _buildCard(
          title: 'Statistics',
          content: 'Check your performance statistics and insights.',
        ),
        const SizedBox(height: 16),
        _buildCard(
          title: 'Statistics',
          content: 'Check your performance statistics and insights.',
        ),
        const SizedBox(height: 16),
        _buildCard(
          title: 'Statistics',
          content: 'Check your performance statistics and insights.',
        ),
        const SizedBox(height: 16),
        _buildCard(
          title: 'Statistics',
          content: 'Check your performance statistics and insights.',
        ),
        const SizedBox(height: 16),
        _buildCard(
          title: 'Statistics',
          content: 'Check your performance statistics and insights.',
        ),
      ],
    );
  }

  Widget _buildCard({required String title, required String content}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

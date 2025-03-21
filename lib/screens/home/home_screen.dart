import 'package:flutter/material.dart';
import 'package:syntrack/components/busstop_listitem.dart';
import 'services_menu.dart';
import 'background_image.dart';
import 'announcement_section.dart';
import 'blog_section.dart';
import '../../components/search_bar.dart';
import '../../components/history_listitem.dart';
import '../../data/announcement_data.dart';
import '../../data/blog_data.dart';
import '../../data/bus_stop_data.dart';

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
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: _buildContentSection()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentSection() {
    final recentSearches = BusStopData.getRecentSearches();
    final nearestBusStops = BusStopData.getNearestBusStops();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const CustomSearchBar(),
              if (recentSearches.isNotEmpty) ...[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
                  child: Column(
                    children: [
                      HistoryListItem(
                        title: 'Kokis Kade',
                        subtitle: 'Ganemulla',
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Container(
                          width: double.infinity,
                          height: 1,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const Text(
            'Nearest Bus Stops',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: nearestBusStops
                .map((stop) => BusStopListItem(
                      name: stop.name,
                      location: stop.location,
                      estimatedArrival: stop.estimatedArrival,
                      nextBus: stop.nextBus,
                    ))
                .toList(),
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const Text(
            'Services',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const ServiceMenu(),
        const SizedBox(height: 20),
        AnnouncementSection(
          announcements: AnnouncementData.getAnnouncements(),
        ),
        const SizedBox(height: 20),
        BlogSection(
          blogs: BlogData.getBlogPosts(),
        ),
      ],
    );
  }
}

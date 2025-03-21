import 'package:flutter/material.dart';
import '../../models/announcement_modal.dart';

class AnnouncementSection extends StatelessWidget {
  final List<Announcement> announcements;

  const AnnouncementSection({
    Key? key,
    required this.announcements,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 16),
          child: Text(
            'Announcements',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 120,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            itemCount: announcements.length,
            itemBuilder: (context, index) {
              final announcement = announcements[index];
              return Container(
                width: 300,
                margin: EdgeInsets.only(
                  right: index == announcements.length - 1 ? 0 : 16,
                  bottom: 8,
                ),
                decoration: BoxDecoration(
                  color: announcement.backgroundColor,
                  borderRadius: BorderRadius.circular(16),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.black.withOpacity(0.1),
                  //     blurRadius: 8,
                  //     offset: Offset(0, 4),
                  //   ),
                  // ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 7,
                        child: Text(
                          announcement.message,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Image.asset(
                          announcement.imageAsset,
                          width: 100,
                          height: 100,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../models/announcement_modal.dart';

class AnnouncementData {
  static List<Announcement> getAnnouncements() {
    return [
      const Announcement(
        message: 'Road Accidents have been reduced by 20% this year',
        imageAsset: 'assets/images/anouncement1.png',
        backgroundColor: Color.fromARGB(255, 227, 79, 140),
      ),
      const Announcement(
        message: 'New bus routes added in your area',
        imageAsset: 'assets/images/anouncement2.png',
        backgroundColor: Color.fromARGB(255, 77, 201, 153),
      ),
    ];
  }
}

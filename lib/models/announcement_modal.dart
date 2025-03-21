import 'package:flutter/material.dart';

class Announcement {
  final String message;
  final String imageAsset;
  final Color backgroundColor;

  const Announcement({
    required this.message,
    required this.imageAsset,
    required this.backgroundColor,
  });
}

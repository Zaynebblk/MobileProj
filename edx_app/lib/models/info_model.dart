import 'package:flutter/material.dart';

class CalendarEvent {
  final String title;
  final String date;
  final String status;
  final Color statusColor;

  CalendarEvent(this.title, this.date, this.status, this.statusColor);
}

class GeneralInfoModel {
  final String announcement;
  final List<Map<String, String>> faqs;
  final List<CalendarEvent> events;
  final List<Map<String, String>> services;

  GeneralInfoModel({
    required this.announcement,
    required this.faqs,
    required this.events,
    required this.services,
  });
}

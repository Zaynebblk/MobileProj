import 'package:flutter/material.dart';
import '../models/ticket.dart';

class TicketProvider extends ChangeNotifier {
  final List<Ticket> _tickets = [];

  List<Ticket> get tickets => _tickets;

  void addTicket(Ticket ticket) {
    _tickets.insert(0, ticket); // nouveau ticket en haut
    notifyListeners();
  }

  void updateStatus(String id, String newStatus) {
    final ticket = _tickets.firstWhere((t) => t.id == id);
    ticket.statut = newStatus;
    notifyListeners();
  }
}

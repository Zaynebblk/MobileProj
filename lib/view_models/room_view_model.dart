import 'package:flutter/material.dart';
import '../models/room_model.dart';

class RoomViewModel extends ChangeNotifier {
  bool _isLoading = false;
  List<Room> rooms = [];

  bool get isLoading => _isLoading;

  // Stats
  int get totalRooms => rooms.length;
  int get availableRooms => rooms.where((r) => r.status == "Libre").length;
  int get maintenanceRooms => rooms.where((r) => r.status == "Maintenance").length;

  Future<void> fetchRooms() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 600));

    // Données fictives
    rooms = [
      Room(id: "1", name: "Amphi A", type: "Amphi", capacity: 150, status: "Occupée", hasProjector: true),
      Room(id: "2", name: "Salle B-12", type: "TD", capacity: 30, status: "Libre", hasProjector: true),
      Room(id: "3", name: "Labo Réseaux", type: "Labo", capacity: 20, status: "Occupée", hasProjector: false),
      Room(id: "4", name: "Salle C-04", type: "TD", capacity: 25, status: "Maintenance", hasProjector: true),
      Room(id: "5", name: "Amphi B", type: "Amphi", capacity: 120, status: "Libre", hasProjector: true),
      Room(id: "6", name: "Salle Info 1", type: "Labo", capacity: 15, status: "Libre", hasProjector: true),
    ];

    _isLoading = false;
    notifyListeners();
  }
}
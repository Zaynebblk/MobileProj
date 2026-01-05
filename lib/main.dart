import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Import de la vue principale
import 'views/admin_view.dart';

// Import de tous les ViewModels
import 'view_models/admin_view_model.dart';
import 'view_models/publish_view_model.dart'; 
import 'view_models/ticket_view_model.dart';
import 'view_models/rattrapage_view_model.dart';
import 'view_models/user_view_model.dart';
import 'view_models/schedule_view_model.dart';
import 'view_models/subject_view_model.dart';
import 'view_models/announcement_view_model.dart';
import 'view_models/document_view_model.dart';
import 'view_models/room_view_model.dart'; // NOUVEAU

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // 1. Dashboard Principal
        ChangeNotifierProvider(create: (_) => AdminViewModel()),
        
        // 2. Module Publier Notes
        ChangeNotifierProvider(create: (_) => PublishViewModel()),
        
        // 3. Module Tickets
        ChangeNotifierProvider(create: (_) => TicketViewModel()),
        
        // 4. Module Rattrapages
        ChangeNotifierProvider(create: (_) => RattrapageViewModel()),
        
        // 5. Module Utilisateurs
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        
        // 6. Module Emplois du temps
        ChangeNotifierProvider(create: (_) => ScheduleViewModel()),

        // 7. Module Matières
        ChangeNotifierProvider(create: (_) => SubjectViewModel()),

        // 8. Module Annonces
        ChangeNotifierProvider(create: (_) => AnnouncementViewModel()),

        // 9. Module Documents
        ChangeNotifierProvider(create: (_) => DocumentViewModel()),

        // 10. Module Salles (NOUVEAU)
        ChangeNotifierProvider(create: (_) => RoomViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Admin Dashboard',
        theme: ThemeData(
          primarySwatch: Colors.pink,
          scaffoldBackgroundColor: const Color(0xFFFFF8E1),
          useMaterial3: true,
        ),
        home: const AdminView(),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// --- IMPORTS DES VIEWMODELS ---
import 'viewmodels/student_viewmodel.dart'; 
import 'viewmodels/resultats_viewmodel.dart';
import 'viewmodels/partage_viewmodel.dart';
import 'viewmodels/messages_viewmodel.dart';
import 'viewmodels/info_viewmodel.dart';
import 'viewmodels/group_viewmodel.dart';
import 'viewmodels/emploi_viewmodel.dart';
import 'viewmodels/document_viewmodel.dart';
import 'viewmodels/absence_viewmodel.dart';
import 'viewmodels/nmessage_viewmodel.dart';


// --- IMPORTS DES VIEWS ---
import 'views/student_view.dart';

void main() {
  runApp(
    // Le MultiProvider permet d'injecter plusieurs ViewModels à la fois
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StudentViewModel()),
        ChangeNotifierProvider(create: (_) => ResultatsViewModel()),
        ChangeNotifierProvider(create: (_) => PartageViewModel()),
        ChangeNotifierProvider(create: (_) => MessagesViewModel()),
        ChangeNotifierProvider(create: (_) => InfoViewModel()),
        ChangeNotifierProvider(create: (_) => GroupViewModel()),
        ChangeNotifierProvider(create: (_) => EmploiViewModel()),
        ChangeNotifierProvider(create: (_) => DocumentViewModel()),
        ChangeNotifierProvider(create: (_) => AbsenceViewModel()),
        ChangeNotifierProvider(create: (_) => NMessageViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Supcom Mobile',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const StudentHome(),
    );
  }
}
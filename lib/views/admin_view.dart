import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/admin_view_model.dart';
import '../models/admin_model.dart';

// Import Page Notes
import '../view_models/publish_view_model.dart';
import 'publish_view.dart';

// Import Page Tickets
import '../view_models/ticket_view_model.dart';
import 'ticket_view.dart';

// Import Page Rattrapages
import '../view_models/rattrapage_view_model.dart';
import 'rattrapage_view.dart';

// Import Page Utilisateurs
import '../view_models/user_view_model.dart';
import 'user_view.dart';

// Import Page Emplois
import '../view_models/schedule_view_model.dart';
import 'schedule_view.dart';

// Import Page Matières
import '../view_models/subject_view_model.dart';
import 'subject_view.dart';

// Import Page Annonces
import '../view_models/announcement_view_model.dart';
import 'announcement_view.dart';

// Import Page Documents
import '../view_models/document_view_model.dart';
import 'document_view.dart';

// NOUVEAUX IMPORTS POUR SALLES
import '../view_models/room_view_model.dart';
import 'room_view.dart';

class AdminView extends StatefulWidget {
  const AdminView({super.key});

  @override
  State<AdminView> createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AdminViewModel>(context, listen: false).fetchAdminData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final primaryPink = const Color(0xFFE91E63);
    final bgCream = const Color(0xFFFFF8E1);

    return Scaffold(
      backgroundColor: bgCream,
      body: Consumer<AdminViewModel>(
        builder: (context, vm, child) {
          if (vm.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (vm.stats == null) return const SizedBox();

          return SingleChildScrollView(
            child: Column(
              children: [
                // HEADER
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 220,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: primaryPink,
                        image: const DecorationImage(
                          image: NetworkImage("https://images.unsplash.com/photo-1562774053-701939374585?q=80&w=1000&auto=format&fit=crop"),
                          fit: BoxFit.cover,
                          opacity: 0.4,
                        ),
                      ),
                      child: SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  Icon(Icons.security, color: Colors.white),
                                  Text("20:49", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                  Icon(Icons.logout, color: Colors.white),
                                ],
                              ),
                              const SizedBox(height: 10),
                              const Text("Admin SUP'COM", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                              const Text("Administrateur", style: TextStyle(color: Colors.white70)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -40,
                      left: 20, right: 20,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _statItem(vm.stats!.ticketsCount, "Tickets", Colors.orange),
                            _statItem(vm.stats!.usersCount, "Utilisateurs", Colors.blue),
                            _statItem(vm.stats!.rattrapagesCount, "Rattrapages", Colors.purple),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 60),
                const Text("ESPACE ADMINISTRATEUR", style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),

                // GRID MENU
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: vm.menuItems.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, crossAxisSpacing: 15, mainAxisSpacing: 15, childAspectRatio: 0.9,
                    ),
                    itemBuilder: (context, index) {
                      final item = vm.menuItems[index];
                      return GestureDetector(
                        onTap: () {
                          // --- NAVIGATION ---
                          
                          // 1. Publier Notes
                          if (item.title == "Publier Notes") {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (_) => ChangeNotifierProvider(
                                create: (_) => PublishViewModel(), 
                                child: const PublishView()
                              )
                            ));
                          } 
                          // 2. Tickets
                          else if (item.title == "Tickets") {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (_) => ChangeNotifierProvider(
                                create: (_) => TicketViewModel(), 
                                child: const TicketView()
                              )
                            ));
                          } 
                          // 3. Rattrapages
                          else if (item.title == "Rattrapages") {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (_) => ChangeNotifierProvider(
                                create: (_) => RattrapageViewModel(), 
                                child: const RattrapageView()
                              )
                            ));
                          }
                          // 4. Utilisateurs
                          else if (item.title == "Utilisateurs") {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (_) => ChangeNotifierProvider(
                                create: (_) => UserViewModel(), 
                                child: const UserView()
                              )
                            ));
                          }
                          // 5. Emplois
                          else if (item.title == "Emplois" || item.title == "Emploi") {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (_) => ChangeNotifierProvider(
                                create: (_) => ScheduleViewModel(), 
                                child: const ScheduleView()
                              )
                            ));
                          }
                          // 6. Matières
                          else if (item.title == "Matières" || item.title == "Matiere") {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (_) => ChangeNotifierProvider(
                                create: (_) => SubjectViewModel(), 
                                child: const SubjectView()
                              )
                            ));
                          }
                          // 7. Annonces
                          else if (item.title == "Annonces" || item.title == "Annonce") {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (_) => ChangeNotifierProvider(
                                create: (_) => AnnouncementViewModel(), 
                                child: const AnnouncementView()
                              )
                            ));
                          }
                          // 8. Documents
                          else if (item.title == "Documents" || item.title == "Document") {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (_) => ChangeNotifierProvider(
                                create: (_) => DocumentViewModel(), 
                                child: const DocumentView()
                              )
                            ));
                          }
                          // 9. Salles (NOUVEAU)
                          else if (item.title == "Salles" || item.title == "Salle") {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (_) => ChangeNotifierProvider(
                                create: (_) => RoomViewModel(), 
                                child: const RoomView()
                              )
                            ));
                          }
                          // Autres modules
                          else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Module ${item.title} bientôt disponible"))
                            );
                          }
                        },
                        child: _menuItem(item),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFFE64A19),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white60,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.apartment), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
        ],
      ),
    );
  }

  Widget _statItem(int count, String label, Color color) {
    return Column(children: [
      Text("$count", style: TextStyle(color: color, fontSize: 22, fontWeight: FontWeight.bold)),
      Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
    ]);
  }

  Widget _menuItem(AdminMenuItem item) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        CircleAvatar(backgroundColor: item.color.withOpacity(0.3), child: Icon(item.icon, color: Colors.orange[900])),
        const SizedBox(height: 10),
        Text(item.title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
      ]),
    );
  }
}
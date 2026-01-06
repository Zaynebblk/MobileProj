import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/user_view_model.dart';
import '../models/user_model.dart';
import 'edit_user_view.dart'; 
import 'add_user_view.dart'; // IMPORT DE LA PAGE D'AJOUT

class UserView extends StatefulWidget {
  const UserView({super.key});

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserViewModel>(context, listen: false).loadUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final pinkHeader = const Color(0xFFE91E63);
    final orangeBtn = const Color(0xFFE65100);

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E1),
      appBar: AppBar(
        backgroundColor: pinkHeader,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Gestion des comptes", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      body: Consumer<UserViewModel>(
        builder: (context, vm, child) {
          if (vm.isLoading) return const Center(child: CircularProgressIndicator());

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // BARRE DE RECHERCHE
                TextField(
                  decoration: InputDecoration(
                    hintText: "Rechercher un utilisateur...",
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  ),
                ),
                const SizedBox(height: 15),

                // FILTRES (Tabs)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: ["Tous", "Étudiant", "Professeur", "Administrateur"].map((filter) {
                      bool isSelected = vm.selectedFilter == filter;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ChoiceChip(
                          label: Text(filter, style: TextStyle(color: isSelected ? Colors.white : Colors.black87)),
                          selected: isSelected,
                          selectedColor: orangeBtn,
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide.none),
                          onSelected: (_) => vm.setFilter(filter),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 20),

                // STATS (Cartes Blanches)
                Row(
                  children: [
                    Expanded(child: _statCard(vm.totalCount, "Total", Colors.red)),
                    const SizedBox(width: 8),
                    Expanded(child: _statCard(vm.studentCount, "Étudiants", Colors.blue)),
                    const SizedBox(width: 8),
                    Expanded(child: _statCard(vm.profCount, "Profs", Colors.green)),
                    const SizedBox(width: 8),
                    Expanded(child: _statCard(vm.adminCount, "Admins", Colors.purple)),
                  ],
                ),
                const SizedBox(height: 20),

                // BOUTON AJOUTER (CONNECTÉ)
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: orangeBtn, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AddUserView()),
                      );
                    },
                    child: const Text("Ajouter un utilisateur", style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ),
                const SizedBox(height: 20),

                // LISTE DES UTILISATEURS
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: vm.users.length,
                  itemBuilder: (ctx, i) => _userCard(context, vm.users[i]),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _statCard(int count, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)]),
      child: Column(
        children: [
          Text("$count", style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.bold)),
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 11)),
        ],
      ),
    );
  }

  Widget _userCard(BuildContext context, AppUser user) {
    Color badgeColor = user.role == "Étudiant" ? Colors.blue : (user.role == "Professeur" ? Colors.green : Colors.purple);
    IconData icon = user.role == "Étudiant" ? Icons.school : (user.role == "Professeur" ? Icons.person_outline : Icons.admin_panel_settings);

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)]),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: badgeColor.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                child: Icon(icon, color: badgeColor),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text(user.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(color: user.status == "Actif" ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                          child: Text(user.status, style: TextStyle(color: user.status == "Actif" ? Colors.green : Colors.red, fontSize: 10, fontWeight: FontWeight.bold)),
                        )
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(user.role, style: TextStyle(color: badgeColor, fontSize: 12, fontWeight: FontWeight.bold)),
                        if (user.role != "Administrateur") ...[
                          const SizedBox(width: 5),
                          Container(width: 4, height: 4, decoration: const BoxDecoration(color: Colors.grey, shape: BoxShape.circle)),
                          const SizedBox(width: 5),
                          Text(user.role == "Étudiant" ? "2A - RT" : user.details, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                        ]
                      ],
                    ),
                    Text(user.email, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          
          // --- BOUTON UNIQUE "GÉRER LE PROFIL" ---
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (_) => EditUserView(user: user))
                );
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFFE65100)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(vertical: 10)
              ),
              icon: const Icon(Icons.settings, size: 18, color: Color(0xFFE65100)),
              label: const Text("GÉRER LE PROFIL", style: TextStyle(color: Color(0xFFE65100), fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}
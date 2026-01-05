import 'package:flutter/material.dart';
import 'about_view.dart';
import 'general_info_view.dart';
// 1. ADD THIS IMPORT!
import 'profile_view.dart'; 

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3E5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE91E63),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Paramètres', style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- 2. NEW ACCOUNT SECTION ---
            _buildSection(
              title: 'Mon Compte',
              icon: Icons.person_outline,
              items: [
                _buildNavigationTile(
                  'Mon Profil', 
                  'Ahmed Ben Ameur - 55 181 294',
                  onTap: () => Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => const ProfileView())
                  ),
                ),
              ],
            ),

            _buildSection(
              title: 'Notifications',
              icon: Icons.notifications_none,
              items: [
                _buildSwitchTile('Notifications push', 'Recevoir les alertes importantes', true),
                _buildSwitchTile('Nouvelles notes', 'Alertes pour les nouvelles notes', true),
                _buildSwitchTile('Messages', 'Notifications de nouveaux messages', true),
                _buildSwitchTile('Absences', 'Alertes d\'absences enregistrées', false),
              ],
            ),
            
            _buildSection(
              title: 'Aide & Informations',
              icon: Icons.help_outline,
              items: [
                _buildNavigationTile(
                  'Informations Générales', 
                  'Calendrier, règlement et contacts',
                  onTap: () => Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => const GeneralInfoView())
                  ),
                ),
                _buildNavigationTile(
                  'À propos de SUP\'COM', 
                  'Chiffres clés et présentation',
                  onTap: () => Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => const AboutView())
                  ),
                ),
              ],
            ),

            _buildSection(
              title: 'Apparence',
              icon: Icons.phone_android,
              items: [
                _buildSwitchTile('Mode sombre', 'Activer le thème sombre', false),
                _buildNavigationTile('Langue', 'Français', onTap: () {}),
              ],
            ),

            _buildSection(
              title: 'Sécurité',
              icon: Icons.lock_outline,
              items: [
                _buildNavigationTile('Changer le mot de passe', 'Dernière modification il y a 3 mois', onTap: () {}),
                _buildSwitchTile('Authentification biométrique', 'Utiliser l\'empreinte digitale', false),
                _buildSwitchTile('Code PIN', 'Protection par code à 4 chiffres', false),
              ],
            ),
            
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD81B60),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  // Logout logic
                },
                icon: const Icon(Icons.logout, color: Colors.white),
                label: const Text('Se déconnecter', style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Helper Widgets remain the same ---
  Widget _buildSection({required String title, required IconData icon, required List<Widget> items}) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Icon(icon, color: Colors.blueGrey),
                const SizedBox(width: 8),
                Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF263238))),
              ],
            ),
          ),
          ...items,
        ],
      ),
    );
  }

  Widget _buildSwitchTile(String title, String subtitle, bool value) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
      trailing: Switch(value: value, onChanged: (val) {}, activeColor: const Color(0xFFE91E63)),
    );
  }

  Widget _buildNavigationTile(String title, String subtitle, {required VoidCallback onTap}) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
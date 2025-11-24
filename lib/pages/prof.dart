import 'package:flutter/material.dart';

class ProfHomePage extends StatelessWidget {
  const ProfHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold( // scaffold = structure de base d'une page
      backgroundColor: const Color(0xffF5F8F7),
      bottomNavigationBar: buildBottomNavBar(), // barre de navigation en bas
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context), // en-tête de la page

            const SizedBox(height: 15),

            _buildStatsCard(), // carte de statistiques

            const SizedBox(height: 20),

            _buildSectionTitle("ESPACE PROFESSEUR"), // titre de section

            _buildGridMenu(), // menu en grille

            const SizedBox(height: 15),

            _buildSectionTitle("Actions rapides"), // autre titre de section

            _buildQuickAction(), // action rapide
            const SizedBox(height: 20),
          ], // kolhom des methodes à définir
        ),
      ),
    );
  }

 
  Widget _buildHeader(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 180,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xfff23859), Color(0xfffb729e)],
              begin: Alignment.topLeft, // dégradé de couleur
              end: Alignment.bottomRight, // dégradé de couleur
            ),
          ),
        ),

        Positioned.fill(
          child: Opacity(
            opacity: 0.15,
            child: Image(
              image: AssetImage("assets/imgs/supcom.jpg"),
              fit: BoxFit.cover, // hedhi tkhali l'image cover kol l'espace
            ),
          ),
        ),

        Positioned( // positionner les éléments dans le stack
          top: 45,
          left: 20,
          right: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.school, color: Colors.white, size: 30),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Dr. BENALI Ahmed",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                      Text("Professeur",
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ],
              ),
              const Text("20:49",
                  style: TextStyle(color: Colors.white, fontSize: 16)),
            ],
          ),
        )
      ],
    );
  }

 
  Widget _buildStatsCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20), // marge horizontale
      padding: const EdgeInsets.symmetric(vertical: 20), // padding vertical
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 3))
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _singleStat("8", "Cours"), // _singleStat est une méthode définie en dessous
          _singleStat("156", "Étudiants"),
          _singleStat("12", "Examens"),
        ],
      ),
    );
  }

  Widget _singleStat(String value, String label) {
    return Column(
      children: [
        Text(value, // exp 12
            style: const TextStyle( 
                color: Colors.green,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.grey)), // exp examens
      ],
    );
  }

 
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 17,
            color: Colors.black87,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildGridMenu() {
    final List<Map<String, dynamic>> items = [ // hedhi liste mta3 les items (icon + label)
      {"icon": Icons.book, "label": "Mes Cours"},
      {"icon": Icons.group, "label": "Étudiants"},
      {"icon": Icons.checklist, "label": "Notes"},

      {"icon": Icons.event_busy, "label": "Absences"},
      {"icon": Icons.calendar_month, "label": "Emploi"},
      {"icon": Icons.folder, "label": "Documents"},

      {"icon": Icons.message, "label": "Messages"},
      {"icon": Icons.edit_calendar, "label": "Examens"},
      {"icon": Icons.campaign, "label": "Annonces"},

      {"icon": Icons.bar_chart, "label": "Statistiques"},
      {"icon": Icons.date_range, "label": "Calendrier"},
      {"icon": Icons.menu_book, "label": "Ressources"},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GridView.builder( // grille dynamique
        shrinkWrap: true, // pour que la grille prenne seulement l'espace nécessaire
        physics: const NeverScrollableScrollPhysics(), // désactiver le scroll interne de la grille
        itemCount: items.length, // nombre d'items dans la grille
        gridDelegate: // définir la structure de la grille
            const SliverGridDelegateWithFixedCrossAxisCount( // nombre fixe de colonnes
              crossAxisCount: 3, // 3 colonnes
              mainAxisExtent: 115, // hauteur fixe des éléments
              crossAxisSpacing: 15, // espacement horizontal entre les éléments
              mainAxisSpacing: 15),// espacement vertical entre les éléments
        itemBuilder: (context, index) {
          return _gridItem(items[index]["icon"], items[index]["label"]);  // _gridItem est une méthode définie en dessous
        },
      ),
    );
  }

  Widget _gridItem(IconData icon, String label) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 3))
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.green, size: 35),
          const SizedBox(height: 10),
          Text(label,
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87))
        ],
      ),
    );
  }


  Widget _buildQuickAction() { // action rapide
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
          ]),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.red, size: 30),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start, // aligner le texte à gauche
            children: const [
              Text("Marquer les absences",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              Text("Cours du jour",
                  style: TextStyle(color: Colors.grey)),
            ],
          )
        ],
      ),
    );
  }


  Widget buildBottomNavBar() {
    return BottomNavigationBar( // barre de navigation en bas
      selectedItemColor: Colors.green, // couleur de l'item sélectionné
      unselectedItemColor: Colors.grey,
      currentIndex: 0, // index de l'item sélectionné
      type: BottomNavigationBarType.fixed, // type fixe pour afficher tous les items
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: ''), // label vide pour ne pas afficher de texte
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''), 
        BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
      ],
    );
  }
}

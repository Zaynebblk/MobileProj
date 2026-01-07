import 'package:flutter/material.dart';
import 'forgot_password.dart';
import 'prof.dart';
import 'admin.dart';

class LoginPage extends StatefulWidget { // Changed to StatefulWidget (l’interface doit réagir)
  const LoginPage({super.key});

  @override // Override de la méthode createState
  State<LoginPage> createState() => _LoginPageState(); // Crée l’état associé à cette page ( crée et retourne une instance de _LoginPageState  qui va gérer l’état de la page de connexion )
}

class _LoginPageState extends State<LoginPage> {
  int selectedTab = 0;// Variable pour suivre l’onglet sélectionné (0: Étudiant, 1: Professeur, 2: Administrateur)
  final identifiantController = TextEditingController(); // Contrôleur pour le champ d’identifiant
  final passwordController = TextEditingController(); // Contrôleur pour le champ de mot de passe
  // hedhom chnest7a9hom fel backend bch na3mlou authentification
  @override 
  Widget build(BuildContext context) {
    return Scaffold( // Scaffold fournit la structure de base de la page ( backround, app bar, body...)
      backgroundColor: const Color.fromARGB(255, 4, 39, 61),
      body: Center( // Centre le contenu de la page ( body : position )
        child: SingleChildScrollView( // Permet le défilement si le contenu dépasse la taille de l’écran
          child: Container( // Conteneur principal de la page de connexion
            padding: const EdgeInsets.all(20),//une classe Flutter qui permet de définir des espaces dans votre interface
            width: 380,
            decoration: BoxDecoration( // Décoration du conteneur
              borderRadius: BorderRadius.circular(12),
              color: Colors.white.withValues(alpha: 0.05), //opacité
            ),
            child: Column( // Colonne pour empiler les éléments verticalement ( colonne hedha chn7ot fih el formulaire )
              crossAxisAlignment: CrossAxisAlignment.center,// Centre les éléments horizontalement
              children: [ // Liste des widgets enfants

                
                ClipRRect( // Pour arrondir les coins de l’image
                  borderRadius: BorderRadius.circular(8), 
                  child: Image.asset(
                    "assets/imgs/logo.png",
                    width: 240,
                  ),
                ),

                const SizedBox(height: 20), // Espace vertical entre les éléments

                const Text( // Titre de la page
                  "Veuillez saisir votre login et mot de passe",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),//text fi chekl const w andou style mta3ou

                const SizedBox(height: 20), // mebin kol deux elements lezma

                
                Row( 
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Espace égal entre les boutons ( axe horizontal )
                  children: [
                    roleButton("Étudiant", 0), // el methode roleButton t3ayet lel widget eli ta3ml bouton
                    roleButton("Professeur", 1),
                    roleButton("Administrateur", 2),
                  ],
                ),

                const SizedBox(height: 20), // kl 3ada

                
                TextField( // input
                  controller: identifiantController, 
                  decoration: InputDecoration(
                    filled: true, 
                    fillColor: Colors.white,
                    hintText: "Identifiant", //placeholder
                    prefixIcon: const Icon(Icons.person), // icon fel input
                    border: OutlineInputBorder( 
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                
                TextField(
                  controller: passwordController,
                  obscureText: true, // Masquer le texte saisi
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Mot de passe",
                    prefixIcon: const Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                
                SizedBox(
                  width: double.infinity, //largeur maximale disponible
                  child: ElevatedButton( //bouton eli y5dem l'authentification
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4062C0),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    onPressed: () { // Action lors de l’appui sur le bouton
                    
                      if (selectedTab == 1) { //professeur
                        
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfHomePage(), // builder : fonction eli traja3 widget ( page mta3 professeur  )
                          ),// hedhi t3ayet lel page mta3 professeur bel methode Navigator.push eli tekhdh context w MaterialPageRoute
                        );
                      } else if (selectedTab == 0) {
                        
                        ScaffoldMessenger.of(context).showSnackBar( // Affiche un message SnackBar (kif l alerte)
                          const SnackBar(content: Text("Page etudiant non encore définie")),
                        );
                      } else if (selectedTab == 2) {

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AdminHomePage(),
                          ),
                        );
                      }
                    },
                    child: const Text( // valeur de bouton
                      "Se connecter",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(height: 12),


                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Se connecter",
                      style: TextStyle(color: Colors.white),
                    ),

                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ForgotPasswordPage(),
                          ),
                        );
                      },
                      child: const Text(
                        "Mot de passe oublié",
                        style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),


                const Text(
                  "SUP'COM\nKEDUX 2.1.1 © 2017-2025 2C Services\nTous droits réservés.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  
  Widget roleButton(String label, int index) { // definition de la méthode roleButton
    return Expanded( // Expanded : pour que les boutons prennent un espace égal dans la ligne
      child: GestureDetector(
        onTap: () {
          setState(() => selectedTab = index); // tbedel l’onglet sélectionné w t3ayet lel build bch ta3ml rafraichissement lel interface
        },
        child: Container( 
          padding: const EdgeInsets.symmetric(vertical: 8), // Espace vertical à l’intérieur du bouton
          margin: const EdgeInsets.symmetric(horizontal: 4), // Espace horizontal entre les boutons
          decoration: BoxDecoration(
            color: selectedTab == index
                ? Colors.white // kenou m sélectionné ywalli blanc
                : Colors.white.withValues(alpha: 0.2), // sinon opacité
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: selectedTab == index ? Colors.black : Colors.white, // couleur du texte selon l’état
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
/* remarque :
decoration : boxdecoration : pour décorer un conteneur 
style : textstyle : pour décorer un texte
style : elevatedbutton.stylefrom : pour décorer un bouton

*/
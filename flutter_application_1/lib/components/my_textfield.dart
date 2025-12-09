import 'package:flutter/material.dart';

/// Composant champ de texte réutilisable personnalisé
/// Utilisé pour les formulaires (login, inscription, édition de profil, etc.)
class MyTextfield extends StatelessWidget {
    final TextEditingController controller;      // Contrôleur pour récupérer le texte saisi par l'utilisateur
    final String hintText; // Texte indicatif (placeholder) à afficher dans le champ
    final bool obscureText; // Masquer le texte pour les mots de passe (true) ou l'afficher (false)
    
    const MyTextfield(
      {
      super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText,
      });

  @override
  Widget build(BuildContext context) {
    // Créer le champ de saisie avec un padding externe
    return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: controller,    // Associer le contrôleur
                  obscureText: obscureText,  // Masquer ou afficher le texte
                  decoration: InputDecoration(
                    // Bordure quand le champ n'est pas sélectionné
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: const Color.fromARGB(255, 158, 133, 234), width: 2), // Bordure violette
                    ),
                    // Bordure quand l'utilisateur tape dans le champ
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: const Color.fromARGB(255, 255, 255, 255), width: 2), // Bordure blanche
                    ),
                    fillColor:  const Color.fromARGB(255, 235, 236, 237), // Couleur de fond gris clair
                    filled: true, // Activer le remplissage de couleur
                    border: OutlineInputBorder(), // Bordure générale
                    hintText: hintText, // Afficher le texte indicatif
                    hintStyle: TextStyle(color: const Color.fromARGB(255, 23, 22, 22)), // Style du placeholder (gris foncé)
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 27.0), // Espace intérieur du champ
                  ),
                ),
              );
  }
}
  

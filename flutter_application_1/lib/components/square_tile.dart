import 'package:flutter/material.dart';

/// Composant tuile carrée réutilisable pour afficher des images
/// Utilisé pour les boutons de connexion avec services externes (Google, Apple, etc.)
class SquareTile extends StatelessWidget {
  final String imagePath; // Chemin vers le fichier image à afficher
  
  const SquareTile({
    super.key,
    required this.imagePath,});

  @override
  Widget build(BuildContext context) {
    // Créer une boîte carrée avec une image à l'intérieur
    return Container(
      padding: const EdgeInsets.all(20), // Espace intérieur de la boîte
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(255, 234, 230, 230)), // Bordure gris clair
        color: const Color.fromARGB(255, 234, 234, 234), // Couleur de fond gris clair
        borderRadius: BorderRadius.circular(8), // Coins arrondis
      ),
      // Afficher l'image depuis les assets
      child: Image.asset(
        imagePath,
        height: 40, // Taille de l'image (hauteur)
      ),
    );
  }
}
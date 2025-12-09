import 'package:flutter/material.dart';

/// Composant bouton réutilisable personnalisé
/// Utilisé pour les actions principales dans l'application (connexion, inscription, etc.)
class MyButton extends StatelessWidget {
  final Function(BuildContext)? onTap; // Fonction à exécuter lors du clic
  final String text;                   // Texte à afficher sur le bouton
  final double fontSize;               // Taille de la police du texte

  const MyButton({
    super.key,
    required this.onTap,
    this.text = 'Sign in',
    this.fontSize = 18,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:  Color.fromARGB(255, 58, 75, 150),
          padding: const EdgeInsets.all(25),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0,
        ),
        onPressed: onTap != null ? () => onTap!(context) : null,
        child: Text(
          text,
          style: TextStyle(
            color: const Color.fromARGB(255, 233, 233, 235),
            fontWeight: FontWeight.bold,
            fontSize: fontSize,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
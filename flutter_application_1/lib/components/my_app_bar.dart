import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Barre d'application réutilisable avec meilleure visibilité
/// Cette AppBar personnalisée est utilisée en haut de toutes les pages
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;           // Titre à afficher dans la barre
  final List<Widget>? actions;  // Boutons d'action à droite (optionnel)
  final Widget? leading;        // Widget à gauche (optionnel, ex: bouton retour)
  final bool centerTitle;       // Centrer le titre ou non

  const MyAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.centerTitle = true, // Par défaut, centrer le titre
  });

  @override
  // Définir la taille de la barre d'application (hauteur standard)
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    // Couleur du texte et des icônes (blanc cassé)
    const Color textColor = Color.fromARGB(255, 243, 243, 245);
    
    return AppBar(
      // Couleur de fond bleu foncé
      backgroundColor:  const Color.fromARGB(255, 58, 75, 150),
      elevation: 0.6, // Légère ombre sous la barre
      centerTitle: centerTitle, // Centrer ou aligner le titre
      automaticallyImplyLeading: false, // Désactiver la flèche retour automatique
      leading: leading, // Widget personnalisé à gauche (si fourni)
      // Affichage du titre avec style personnalisé
      title: Text(
        title,
        style: const TextStyle(
          color: textColor,
          fontSize: 18,
          fontWeight: FontWeight.w700, // Texte en gras
        ),
      ),
      // Couleur des icônes
      iconTheme: const IconThemeData(color: textColor),
      actions: actions, // Boutons d'action à droite (si fournis)
      // Style de la barre système (heure, batterie, etc.)
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    );
  }
}

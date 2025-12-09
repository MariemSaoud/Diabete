import 'package:flutter/material.dart';

/// Barre de navigation inférieure personnalisée avec style "pilule"
/// Affiche les onglets de navigation avec un design moderne
class MyBottomNavBar extends StatelessWidget {
  final int currentIndex; // Index de l'onglet actuellement sélectionné (0-3)
  final Function(int) onTap; // Fonction appelée quand un onglet est cliqué

  const MyBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Définition de la palette de couleurs pour la navigation
    const Color activeBg = Color.fromARGB(255, 58, 75, 150); // Couleur de fond pour l'onglet actif (bleu foncé)
    const Color inactiveBg = Colors.white; // Couleur de fond pour les onglets inactifs (blanc)
    const Color activeText = Colors.white; // Couleur du texte pour l'onglet actif (blanc)
    const Color inactiveText = Color.fromARGB(255, 58, 75, 150); // Couleur du texte pour les onglets inactifs (bleu foncé)
    const Color inactiveBorder = Color.fromARGB(255, 58, 75, 150); // Couleur de la bordure pour les onglets inactifs

    // Liste des éléments de navigation (icône + libellé)
    final items = [
      _NavItem(Icons.home, 'Actualités'),        // Index 0
      _NavItem(Icons.add, 'Saisie Quotidienne'), // Index 1
      _NavItem(Icons.event_note, 'Historique'),   // Index 2
      _NavItem(Icons.bar_chart, 'Graphiques'),    // Index 3
      _NavItem(Icons.person_outline, 'Profil Patient'), // Index 4
    ];

    return SafeArea(
      top: false, // Ne pas ajouter d'espace en haut
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          // Génération dynamique de tous les onglets de navigation
          children: List.generate(items.length, (index) {
            // Vérifier si cet onglet est celui actuellement sélectionné
            final isActive = index == currentIndex;
            final item = items[index];
            // Afficher le texte uniquement pour "Saisie Quotidienne" (index 1)
            // Les autres onglets n'affichent que l'icône
            final showText = index == 1;

            return Expanded(
              // Donner 2x plus d'espace à "Saisie Quotidienne" pour afficher le texte complet
              // Les autres onglets prennent 1x l'espace (juste l'icône)
              flex: showText ? 2 : 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: GestureDetector(
                  // Détecter le clic sur l'onglet et appeler la fonction onTap
                  onTap: () => onTap(index),
                  child: AnimatedContainer(
                    // Animation de transition lors du changement d'état (actif/inactif)
                    duration: const Duration(milliseconds: 180),
                    // Padding adaptatif : plus d'espace horizontal si le texte est affiché
                    padding: EdgeInsets.symmetric(horizontal: showText ? 12 : 8, vertical: 12),
                    decoration: BoxDecoration(
                      // Couleur de fond selon l'état (actif = bleu, inactif = blanc)
                      color: isActive ? activeBg : inactiveBg,
                      borderRadius: BorderRadius.circular(10), // Coins arrondis
                      border: Border.all(
                        // Bordure selon l'état
                        color: isActive ? activeBg : inactiveBorder,
                      ),
                      // Ombre portée uniquement pour l'onglet actif
                      boxShadow: isActive
                          ? [
                              BoxShadow(
                                color: activeBg.withValues(alpha: 0.2),
                                blurRadius: 12,
                                offset: const Offset(0, 6),
                              ),
                            ]
                          : null,
                    ),
                    // Contenu différent selon si on affiche le texte ou non
                    child: showText
                        // Pour "Saisie Quotidienne" : afficher icône + texte
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Icône de l'onglet
                              Icon(
                                item.icon,
                                size: 18,
                                color: isActive ? activeText : inactiveText,
                              ),
                              const SizedBox(width: 8), // Espace entre icône et texte
                              // Texte flexible qui peut s'adapter à l'espace disponible
                              Flexible(
                                child: Text(
                                  item.label,
                                  overflow: TextOverflow.ellipsis, // Ajouter "..." si le texte est trop long
                                  style: TextStyle(
                                    color: isActive ? activeText : inactiveText,
                                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          )
                        // Pour les autres onglets : afficher uniquement l'icône
                        : Icon(
                            item.icon,
                            size: 24, // Icône plus grande car pas de texte
                            color: isActive ? activeText : inactiveText,
                          ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

/// Classe privée pour stocker les informations d'un élément de navigation
/// (icône et libellé)

class _NavItem {
  final IconData icon;   // L'icône à afficher (ex: Icons.add)
  final String label;    // Le texte du libellé (ex: "Saisie Quotidienne")
  
  // Constructeur pour créer un élément de navigation
  const _NavItem(this.icon, this.label);
}

import 'package:flutter/material.dart';

/// Collection de transitions animées personnalisées pour la navigation entre pages
/// Ces transitions rendent l'expérience utilisateur plus fluide et agréable

// ============= Transition de fondu (Fade) =============
/// Transition simple avec effet de fondu
/// La nouvelle page apparaît progressivement en augmentant l'opacité
class FadePageTransition extends PageRouteBuilder {
  final Widget page; // La page de destination

  FadePageTransition({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Appliquer l'effet de fondu basé sur l'animation d'opacité
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 300), // Durée de l'animation
        );
}

// ============= Transition de glissement (Slide) =============
/// Transition avec effet de glissement de droite à gauche
/// La nouvelle page glisse depuis la droite de l'écran
class SlidePageTransition extends PageRouteBuilder {
  final Widget page; // La page de destination

  SlidePageTransition({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0); // Position de départ : hors écran à droite
            const end = Offset.zero;         // Position finale : position normale
            const curve = Curves.easeInOut;  // Courbe d'animation fluide
            // Créer l'interpolation de la position
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            // Appliquer l'effet de glissement
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 400), // Durée de l'animation
        );
}

// ============= Transition de zoom (Scale) =============
/// Transition avec effet de zoom
/// La nouvelle page apparaît en grossissant depuis le centre
class ScalePageTransition extends PageRouteBuilder {
  final Widget page; // La page de destination

  ScalePageTransition({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Appliquer l'effet de zoom de 0% à 100%
            return ScaleTransition(
              scale: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeInOut),
              ),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 350), // Durée de l'animation
        );
}

// ============= Transition de rotation (Rotation) =============
/// Transition avec effet de rotation
/// La nouvelle page tourne sur elle-même en apparaissant
class RotationPageTransition extends PageRouteBuilder {
  final Widget page; // La page de destination

  RotationPageTransition({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Appliquer l'effet de rotation de 0 à 360 degrés (1 tour complet)
            return RotationTransition(
              turns: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeInOut),
              ),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 400), // Durée de l'animation
        );
}

// ============= Transition combinée Glissement + Fondu =============
/// Transition combinée avec effet de glissement ET de fondu
/// La nouvelle page glisse depuis la droite tout en apparaissant progressivement
/// C'est la transition utilisée pour la navigation principale de l'application
class SlideAndFadePageTransition extends PageRouteBuilder {
  final Widget page; // La page de destination

  SlideAndFadePageTransition({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0); // Position de départ : hors écran à droite
            const end = Offset.zero;         // Position finale : position normale
            const curve = Curves.easeInOutCubic; // Courbe d'animation très fluide
            // Créer l'interpolation de la position
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            // Combiner le glissement et le fondu
            return SlideTransition(
              position: animation.drive(tween),
              child: FadeTransition(
                opacity: animation, // Effet de fondu simultané
                child: child,
              ),
            );
          },
          transitionDuration: const Duration(milliseconds: 500), // Durée de l'animation
        );
}

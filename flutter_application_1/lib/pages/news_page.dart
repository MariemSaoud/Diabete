import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/my_app_bar.dart';
import 'package:flutter_application_1/components/my_bottom_nav_bar.dart';
import 'package:flutter_application_1/components/page_transitions.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/pages/history_page.dart';
import 'package:flutter_application_1/pages/chart_page.dart';
import 'package:flutter_application_1/pages/profile_page.dart';

// ═══════════════════════════════════════════════════════════════════════════
// PAGE ACTUALITÉS - INFORMATIONS ET ACTUALITÉS SUR LE DIABÈTE
// ═══════════════════════════════════════════════════════════════════════════
//
// Cette page affiche :
// - Des actualités sur le diabète
// - Des conseils et recommandations
// - Des articles d'information
//
// Pour le moment, affiche un placeholder avec une icône home
// À développer : liste d'articles, actualités médicales, conseils quotidiens
// ═══════════════════════════════════════════════════════════════════════════

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  // Index de navigation actuel (0 = page Actualités dans la barre de navigation)
  final int _currentIndex = 0;

  // ─────────────────────────────────────────────────────────────────────────
  // NAVIGATION - Gestion du changement de page via la barre de navigation
  // ─────────────────────────────────────────────────────────────────────────
  // Si l'utilisateur tape sur l'onglet actuel, ne rien faire
  // Sinon, naviguer vers la page correspondante avec transition animée
  void _navigateToPage(int index) {
    if (index == _currentIndex) return;

    // Sélection de la page selon l'index tapé
    Widget page = _getPageForIndex(index);

    // Navigation avec transition glissante et fondu (500ms)
    Navigator.pushReplacement(
      context,
      SlideAndFadePageTransition(page: page),
    );
  }

  // Retourne la page correspondant à l'index sélectionné
  Widget _getPageForIndex(int index) {
    switch (index) {
      case 0: // Actualités
        return const NewsPage();
      case 1: // Saisie Quotidienne
        return const HomePage();
      case 2: // Historique
        return const HistoryPage();
      case 3: // Graphiques
        return const ChartPage();
      case 4: // Profil
        return const ProfilePage();
      default:
        return const NewsPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: MyAppBar(title: 'Actualités Diabète'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Center(
              child: Column(
                children: [
                  Text(
                    'Actualités Diabète',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2564EB),
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Restez informé des dernières avancées en diabétologie',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Section : Top articles (vertical, aéré)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  _NewsCard(
                    category: 'Médical',
                    categoryColor: Color(0xFFDC2626),
                    icon: Icons.favorite,
                    time: '5 min',
                    title: 'Nouvelles Recommandations pour le Contrôle Glycémique 2024',
                    description: "L'Association Française de Diabétologie publie de nouvelles directives pour l'optimisation du contrôle glycémique chez les diabétiques de type 1 et 2.",
                    date: '15 janvier 2024',
                    linkText: 'Lire la suite',
                  ),
                  const SizedBox(height: 18),
                  _NewsCard(
                    category: 'Technologie',
                    categoryColor: Color(0xFF2564EB),
                    icon: Icons.show_chart,
                    time: '3 min',
                    title: 'Innovation : Nouveau Système de Surveillance Continue',
                    description: "Un nouveau capteur de glucose révolutionnaire offre une précision améliorée et une durée de vie prolongée jusqu'à 14 jours.",
                    date: '12 janvier 2024',
                    linkText: 'Lire la suite',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Autres Articles',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  _OtherArticleCard(
                    category: 'Nutrition',
                    categoryColor: Color(0xFF16A34A),
                    icon: Icons.restaurant,
                    time: '7 min',
                    title: 'Alimentation et Diabète : Guide Nutritionnel Complet',
                    description: "Découvrez les dernières recherches sur l'impact des différents aliments sur la glycémie et comment optimiser votre régime alimentaire.",
                    date: '10 janvier 2024',
                    linkText: "Lire l'article complet",
                  ),
                  const SizedBox(height: 12),
                  _OtherArticleCard(
                    category: 'Sport',
                    categoryColor: Color(0xFF7C3AED),
                    icon: Icons.fitness_center,
                    time: '4 min',
                    title: 'Exercice Physique : Nouveaux Protocoles Adaptés',
                    description: "Des études récentes montrent l'efficacité de nouveaux programmes d'exercices spécialement conçus pour les personnes diabétiques.",
                    date: '8 janvier 2024',
                    linkText: "Lire l'article complet",
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) => _navigateToPage(index),
      ),
    );
  }

}

// Carte principale pour les actualités en haut
class _NewsCard extends StatelessWidget {
  final String category;
  final Color categoryColor;
  final IconData icon;
  final String time;
  final String title;
  final String description;
  final String date;
  final String linkText;
  const _NewsCard({
    required this.category,
    required this.categoryColor,
    required this.icon,
    required this.time,
    required this.title,
    required this.description,
    required this.date,
    required this.linkText,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 0),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: categoryColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(icon, color: categoryColor, size: 18),
                    const SizedBox(width: 4),
                    Text(
                      category,
                      style: TextStyle(
                        color: categoryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Icon(Icons.access_time, color: Color(0xFF94A3B8), size: 18),
              const SizedBox(width: 4),
              Text(time, style: TextStyle(color: Color(0xFF64748B), fontSize: 13)),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(date, style: TextStyle(color: Color(0xFF94A3B8), fontSize: 13)),
              const Spacer(),
              InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    Text(linkText, style: TextStyle(color: Color(0xFF2564EB), fontSize: 13, fontWeight: FontWeight.w600)),
                    const SizedBox(width: 2),
                    Icon(Icons.open_in_new, color: Color(0xFF2564EB), size: 14),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Carte pour les autres articles
class _OtherArticleCard extends StatelessWidget {
  final String category;
  final Color categoryColor;
  final IconData icon;
  final String time;
  final String title;
  final String description;
  final String date;
  final String linkText;
  const _OtherArticleCard({
    required this.category,
    required this.categoryColor,
    required this.icon,
    required this.time,
    required this.title,
    required this.description,
    required this.date,
    required this.linkText,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 0),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: categoryColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(icon, color: categoryColor, size: 18),
                    const SizedBox(width: 4),
                    Text(
                      category,
                      style: TextStyle(
                        color: categoryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Icon(Icons.access_time, color: Color(0xFF94A3B8), size: 18),
              const SizedBox(width: 4),
              Text(time, style: TextStyle(color: Color(0xFF64748B), fontSize: 13)),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(date, style: TextStyle(color: Color(0xFF94A3B8), fontSize: 13)),
              const Spacer(),
              InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    Text(linkText, style: TextStyle(color: Color(0xFF2564EB), fontSize: 13, fontWeight: FontWeight.w600)),
                    const SizedBox(width: 2),
                    Icon(Icons.open_in_new, color: Color(0xFF2564EB), size: 14),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

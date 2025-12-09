import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/my_bottom_nav_bar.dart';
import 'package:flutter_application_1/components/page_transitions.dart';
import 'package:flutter_application_1/pages/chart_page.dart';
import 'package:flutter_application_1/pages/edit_profile_page.dart';
import 'package:flutter_application_1/pages/history_page.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/pages/login_page.dart';
import 'package:flutter_application_1/pages/news_page.dart';

// ═══════════════════════════════════════════════════════════════════════════
// PAGE PROFIL - AFFICHAGE DES INFORMATIONS PATIENT ET ANALYSES MÉDICALES
// ═══════════════════════════════════════════════════════════════════════════
//
// Cette page affiche :
// - Les informations personnelles du patient (nom, âge)
// - Les indicateurs clés (HbA1c avec badge de statut)
// - La liste des analyses médicales récentes
// - Un bouton pour modifier le profil (→ EditProfilePage)
// - Un bouton de déconnexion (→ LoginPage)
//
// Utilise des cartes en verre (glass morphism) pour un design moderne
// ═══════════════════════════════════════════════════════════════════════════

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Index de navigation actuel (4 = page Profil dans la barre de navigation)
  final int _currentIndex = 4;

  // ─────────────────────────────────────────────────────────────────────────
  // HIGHLIGHTS - Indicateurs clés affichés en haut de la page
  // ─────────────────────────────────────────────────────────────────────────
  // Récupère les données depuis ProfileData (stockée dans edit_profile_page.dart)
  // Couleurs : Bleu pour nom, Vert pour âge, Rouge pour HbA1c
  // HbA1c inclut un chip jaune "Contrôle acceptable" pour le statut
  List<_InfoHighlight> get _highlights => [
    _InfoHighlight(
      label: 'Nom',
      value: ProfileData.name,
      valueColor: const Color(0xFF2962E4),
    ),
    _InfoHighlight(
      label: 'Âge',
      value: '${ProfileData.age} ans',
      valueColor: const Color(0xFF1B8A43),
    ),
    _InfoHighlight(
      label: 'Hémoglobine Glyquée (HbA1c)',
      value: '7.2%',
      valueColor: const Color(0xFFD7263D),
      chipLabel: 'Contrôle acceptable',
      chipColor: const Color(0xFFF9C846),
      chipTextColor: const Color(0xFF3F2A00),
    ),
  ];

  // ─────────────────────────────────────────────────────────────────────────
  // ANALYSES MÉDICALES - Liste des analyses récentes du patient
  // ─────────────────────────────────────────────────────────────────────────
  // Pour le moment, données statiques en exemple
  // À remplacer par des données depuis une base de données
  // Couleur accent : violet (#8B5CF6) pour cohérence visuelle
  final List<_Analysis> _analyses = [
    _Analysis(
      title: 'HbA1c',
      date: '15/01/2024',
      result: '7.2%',
      normalRange: '< 7%',
      status: 'Analyse complète',
      accentColor: const Color(0xFF8B5CF6),
    ),
    _Analysis(
      title: 'Glycémie à jeun',
      date: '15/01/2024',
      result: '1.25 g/L',
      normalRange: '0.7-1.1 g/L',
      status: 'Analyse complète',
      accentColor: const Color(0xFF8B5CF6),
    ),
  ];

  // ═══════════════════════════════════════════════════════════════════════════
  // BUILD - Construction de l'interface de la page profil
  // ═══════════════════════════════════════════════════════════════════════════
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB), // Fond gris très clair
      body: SafeArea(
        // Container principal avec gradient vertical dégradé
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFF5F8FF), Colors.white], // Bleu très clair → blanc
              begin: Alignment.topCenter,
              end: Alignment.center,
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 18, 16, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 16),
                _buildPersonalInfoCard(),
                const SizedBox(height: 16),
                _buildAnalysesCard(),
                const SizedBox(height: 24),
                _buildLogoutButton(context),
              ],
            ),
          ),
        ),
      ),
      // Barre de navigation en bas avec l'index 3 actif (Profil)
      bottomNavigationBar: MyBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _navigateToPage,
      ),
    );
  }

  // ───────────────────────────────────────────────────────────────────────────
  // NAVIGATION - Gestion du changement de page via la barre de navigation
  // ───────────────────────────────────────────────────────────────────────────
  // Si l'utilisateur tape sur l'onglet actuel, ne rien faire
  // Sinon, naviguer vers la page correspondante avec transition animée
  void _navigateToPage(int index) {
    if (index == _currentIndex) return;

    // Sélection de la page selon l'index tapé
    Widget page;
    switch (index) {
      case 0: // Actualités
        page = const NewsPage();
        break;
      case 1: // Saisie Quotidienne
        page = const HomePage();
        break;
      case 2: // Historique
        page = const HistoryPage();
        break;
      case 3: // Graphiques
        page = const ChartPage();
        break;
      case 4: // Profil
        page = const ProfilePage();
        break;
      default:
        page = const ProfilePage();
    }

    // Navigation avec transition glissante et fondu (500ms)
    Navigator.pushReplacement(
      context,
      SlideAndFadePageTransition(page: page),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // WIDGETS DE CONSTRUCTION - En-tête, cartes, boutons
  // ═══════════════════════════════════════════════════════════════════════════

  // ───────────────────────────────────────────────────────────────────────────
  // EN-TÊTE - Titre de la page et sous-titre descriptif
  // ───────────────────────────────────────────────────────────────────────────
  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        Center(
          // Titre principal : "Profil Patient" en bleu (#2564EB)
          child: Text(
            'Profil Patient',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: Color(0xFF2564EB), // Bleu vif
            ),
          ),
        ),
        SizedBox(height: 6),
        Center(
          // Sous-titre descriptif en gris moyen (#6B7280)
          child: Text(
            'Informations personnelles et analyses médicales',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFF6B7280), // Gris moyen
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  // ───────────────────────────────────────────────────────────────────────────
  // CARTE INFORMATIONS PERSONNELLES - Affiche nom, âge, HbA1c avec bouton Modifier
  // ───────────────────────────────────────────────────────────────────────────
  // Utilise une carte en verre (_GlassCard)
  // Affiche les highlights en ligne ou en colonne selon la largeur disponible
  // Bouton "Modifier" pour ouvrir EditProfilePage
  Widget _buildPersonalInfoCard() {
    return _GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // En-tête de la carte avec icône et bouton "Modifier"
          Row(
            children: [
              const Icon(Icons.person_outline, color: Color(0xFF4F46E5)), // Icône personne violet
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Informations Personnelles',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A), // Noir presque pur
                  ),
                ),
              ),
              // Bouton "Modifier" avec icône edit
              // Navigue vers la page d'édition du profil (EditProfilePage)
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const EditProfilePage()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF0F172A),
                  side: const BorderSide(color: Color(0xFFCBD5E1)),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                ),
                icon: const Icon(Icons.edit_outlined, size: 18),
                label: const Text(
                  'Modifier',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // LayoutBuilder pour affichage responsive des highlights
          // Si largeur < 600px : affichage en colonne (vertical)
          // Si largeur >= 600px : affichage en ligne (horizontal)
          LayoutBuilder(
            builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 600;
              final children = _highlights
                  .map((item) => isNarrow
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: _InfoTile(item: item),
                        )
                      : Expanded(child: _InfoTile(item: item)))
                  .toList();

              return isNarrow
                  ? Column(children: children)
                  : Row(children: children);
            },
          ),
        ],
      ),
    );
  }

  // ───────────────────────────────────────────────────────────────────────────
  // CARTE ANALYSES MÉDICALES - Liste des analyses récentes avec bouton Ajouter
  // ───────────────────────────────────────────────────────────────────────────
  // Utilise une carte en verre (_GlassCard)
  // Affiche la liste des analyses (_analyses) avec _AnalysisTile
  // Bouton "Ajouter une analyse" pour futures fonctionnalités
  Widget _buildAnalysesCard() {
    return _GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // En-tête de la carte avec icône et bouton "Ajouter"
          Row(
            children: [
              const Icon(Icons.science_outlined, color: Color(0xFF8B5CF6)),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Analyses Médicales',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A),
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  foregroundColor: const Color(0xFF2564EB),
                  backgroundColor: const Color(0xFFEFF4FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                icon: const Icon(Icons.add, size: 18),
                label: const Text(
                  'Ajouter une analyse',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Liste des analyses médicales
          // Chaque analyse est affichée dans un _AnalysisTile avec padding vertical
          Column(
            children: _analyses
                .map((analysis) => Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: _AnalysisTile(analysis: analysis),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  // ───────────────────────────────────────────────────────────────────────────
  // BOUTON DÉCONNEXION - Retour vers la page de connexion
  // ───────────────────────────────────────────────────────────────────────────
  // Bouton aligné à gauche avec fond bleu (#3A4B96)
  // Navigue vers LoginPage et supprime toutes les routes précédentes
  Widget _buildLogoutButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 58, 75, 150), // Bleu foncé (#3A4B96)
            borderRadius: BorderRadius.circular(8),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              // Action de déconnexion : retour vers LoginPage
              // pushAndRemoveUntil supprime toutes les routes précédentes (impossible de revenir)
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (route) => false, // Supprime toutes les routes
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Text(
                  'Se déconnecter',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 233, 233, 235),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// CLASSES UTILITAIRES - Widgets réutilisables pour l'affichage des données
// ═══════════════════════════════════════════════════════════════════════════

// ───────────────────────────────────────────────────────────────────────────
// CARTE EN VERRE (_GlassCard) - Container avec effet glass morphism
// ───────────────────────────────────────────────────────────────────────────
// Container blanc avec bordure gris clair (#E2E8F0)
// Ombre portée légère pour effet de profondeur
// Coins arrondis (14px) et padding intérieur (18px)
class _GlassCard extends StatelessWidget {
  final Widget child; // Contenu de la carte

  const _GlassCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Largeur pleine
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white, // Fond blanc
        borderRadius: BorderRadius.circular(14), // Coins arrondis
        border: Border.all(color: const Color(0xFFE2E8F0)), // Bordure gris clair
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: child,
    );
  }
}

// ───────────────────────────────────────────────────────────────────────────
// TUILE D'INFORMATION (_InfoTile) - Affiche label + valeur + chip optionnel
// ───────────────────────────────────────────────────────────────────────────
// Utilisé pour afficher les highlights (nom, âge, HbA1c)
// Affiche un label en gris, une valeur colorée, et un chip optionnel
class _InfoTile extends StatelessWidget {
  final _InfoHighlight item; // Données à afficher

  const _InfoTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label en gris moyen (#6B7280)
        Text(
          item.label,
          style: const TextStyle(
            fontSize: 15,
            color: Color(0xFF6B7280), // Gris moyen
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        // Ligne avec valeur colorée + chip de statut optionnel
        Row(
          children: [
            // Valeur principale avec couleur personnalisée (bleu/vert/rouge)
            Text(
              item.value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: item.valueColor, // Couleur dynamique
              ),
            ),
            // Chip de statut optionnel (ex: "Contrôle acceptable" pour HbA1c)
            if (item.chipLabel != null) ...[
              const SizedBox(width: 8),
              _StatusChip(
                label: item.chipLabel!,
                background: item.chipColor ?? const Color(0xFFFDE68A),
                textColor: item.chipTextColor ?? const Color(0xFF854D0E),
              ),
            ],
          ],
        ),
      ],
    );
  }
}

// ───────────────────────────────────────────────────────────────────────────
// TUILE D'ANALYSE (_AnalysisTile) - Affiche une analyse médicale complète
// ───────────────────────────────────────────────────────────────────────────
// Container blanc avec barre colorée à gauche (accentColor)
// Affiche : date, statut, titre, résultat, valeurs normales
class _AnalysisTile extends StatelessWidget {
  final _Analysis analysis; // Données de l'analyse

  const _AnalysisTile({required this.analysis});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)), // Bordure gris clair
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 12,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          // Barre colorée verticale à gauche (violet #8B5CF6)
          Container(
            width: 6,
            height: 96,
            decoration: BoxDecoration(
              color: analysis.accentColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
          ),
          // Contenu de l'analyse
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Ligne 1 : Date + Statut
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Date de l'analyse avec icône calendrier
                      Row(
                        children: [
                          const Icon(Icons.calendar_today_outlined,
                              size: 16, color: Color(0xFF6B7280)), // Icône gris
                          const SizedBox(width: 6),
                          Text(
                            analysis.date,
                            style: const TextStyle(
                              color: Color(0xFF6B7280),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      // Chip de statut ("Analyse complète")
                      _StatusChip(
                        label: analysis.status,
                        background: const Color(0xFFF1EDFF), // Violet très clair
                        textColor: const Color(0xFF4F46E5), // Violet foncé
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Ligne 2 : Titre + Résultat | Valeurs normales
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Colonne gauche : Titre et Résultat
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Titre de l'analyse en violet (#6B46C1)
                          Text(
                            analysis.title,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF6B46C1), // Violet moyen
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Résultat de l'analyse en noir
                          Text(
                            analysis.result,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF0F172A), // Noir presque pur
                            ),
                          ),
                        ],
                      ),
                      // Colonne droite : Valeurs normales
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Label "Valeurs normales" en gris
                          const Text(
                            'Valeurs normales',
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF6B7280), // Gris moyen
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            analysis.normalRange,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF0F172A),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ───────────────────────────────────────────────────────────────────────────
// CHIP DE STATUT (_StatusChip) - Petit badge coloré pour afficher un statut
// ───────────────────────────────────────────────────────────────────────────
// Utilisé pour les statuts ("Contrôle acceptable", "Analyse complète")
// Couleurs de fond et texte personnalisables
class _StatusChip extends StatelessWidget {
  final String label; // Texte du chip
  final Color background; // Couleur de fond
  final Color textColor; // Couleur du texte

  const _StatusChip({
    required this.label,
    required this.background,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: background, // Couleur de fond personnalisée
        borderRadius: BorderRadius.circular(999), // Coins arrondis (forme pilule)
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor, // Couleur de texte personnalisée
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// CLASSES DE DONNÉES - Modèles pour stocker les informations affichées
// ═══════════════════════════════════════════════════════════════════════════

// ───────────────────────────────────────────────────────────────────────────
// _InfoHighlight - Données pour un indicateur clé (highlight)
// ───────────────────────────────────────────────────────────────────────────
// Utilisé dans la carte "Informations Personnelles"
// Exemples : Nom (bleu), Âge (vert), HbA1c (rouge + chip jaune)
class _InfoHighlight {
  final String label;         // Étiquette (ex: "Nom", "Âge")
  final String value;          // Valeur (ex: "Patient Exemple", "45 ans")
  final Color valueColor;      // Couleur de la valeur
  final String? chipLabel;     // Label du chip optionnel (ex: "Contrôle acceptable")
  final Color? chipColor;      // Couleur de fond du chip
  final Color? chipTextColor;  // Couleur du texte du chip

  const _InfoHighlight({
    required this.label,
    required this.value,
    required this.valueColor,
    this.chipLabel,
    this.chipColor,
    this.chipTextColor,
  });
}

// ───────────────────────────────────────────────────────────────────────────
// _Analysis - Données pour une analyse médicale
// ───────────────────────────────────────────────────────────────────────────
// Utilisé dans la carte "Analyses Médicales"
// Contient toutes les informations d'une analyse (titre, date, résultat, etc.)
class _Analysis {
  final String title;         // Titre de l'analyse (ex: "HbA1c")
  final String date;          // Date de l'analyse (ex: "15/01/2024")
  final String result;        // Résultat (ex: "7.2%", "1.25 g/L")
  final String normalRange;   // Valeurs normales (ex: "< 7%")
  final String status;        // Statut (ex: "Analyse complète")
  final Color accentColor;    // Couleur de la barre d'accent (violet #8B5CF6)

  const _Analysis({
    required this.title,
    required this.date,
    required this.result,
    required this.normalRange,
    required this.status,
    required this.accentColor,
  });
}

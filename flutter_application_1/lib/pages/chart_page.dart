import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/my_app_bar.dart';
import 'package:flutter_application_1/components/my_bottom_nav_bar.dart';
import 'package:flutter_application_1/components/page_transitions.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/pages/profile_page.dart';
import 'package:flutter_application_1/pages/history_page.dart';
import 'package:flutter_application_1/pages/news_page.dart';
import 'package:flutter_application_1/services/daily_entry_service.dart';
import 'package:flutter_application_1/components/glycemia_chart.dart';

import 'package:fl_chart/fl_chart.dart';

/// ======================================
/// PAGE GRAPHIQUES
/// ======================================
/// Cette page affichera des graphiques et statistiques
/// sur les données de glycémie, insuline, etc.
/// Pour l'instant, elle montre uniquement une icône en placeholder
/// Fonctionnalité à développer : graphiques en courbes/barres avec filtres temporels

// Widget StatefulWidget pour gérer l'état de la navigation
class ChartPage extends StatefulWidget {
  const ChartPage({super.key});

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  // Index de l'onglet actif dans la barre de navigation
  // 0 = Actualités, 1 = Saisie Quotidienne, 2 = Historique, 3 = Graphiques, 4 = Profil Patient
  final int _currentIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: const MyAppBar(title: 'Graphiques'),
      body: FutureBuilder(
        future: DailyEntryService.getAllEntries(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          final entries = snapshot.data as List<dynamic>? ?? [];
          if (entries.isEmpty) {
            return const Center(
              child: Text('Aucune donnée disponible pour afficher le graphique.', style: TextStyle(fontSize: 16)),
            );
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GlycemiaChart(entries: entries.cast()),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Profil d'Action de l'Insuline",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF2564EB)),
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _NovoRapidChart(),
                      const SizedBox(height: 24),
                      _LantusChart(),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: MyBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == _currentIndex) return;
          Navigator.pushReplacement(
            context,
            SlideAndFadePageTransition(page: _getPageForIndex(index)),
          );
        },
      ),
    );
  }

  /// Retourner la page correspondant à l'index sélectionné
  Widget _getPageForIndex(int index) {
    switch (index) {
      case 0:
        return const NewsPage();      // Actualités
      case 1:
        return const HomePage();      // Saisie Quotidienne
      case 2:
        return const HistoryPage();   // Historique
      case 3:
        return const ChartPage();     // Graphiques (page actuelle)
      case 4:
        return const ProfilePage();   // Profil Patient
      default:
        return const ChartPage();     // Par défaut, rester sur Graphiques
    }
  }
}

// Ajout des widgets de courbe d'action de l'insuline
class _NovoRapidChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<FlSpot> spots = [
      FlSpot(0, 0),
      FlSpot(15, 20),
      FlSpot(30, 50),
      FlSpot(60, 100),
      FlSpot(120, 80),
      FlSpot(180, 40),
      FlSpot(240, 10),
      FlSpot(300, 0),
    ];
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "NovoRapid (Insuline Rapide)",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF16A34A)),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 220,
              child: LineChart(
                LineChartData(
                  minY: 0,
                  maxY: 110,
                  minX: 0,
                  maxX: 300,
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 38,
                        getTitlesWidget: (value, meta) => Text("${value.toInt()}%", style: const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
                        interval: 25,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 38,
                        getTitlesWidget: (value, meta) => Text("${value.toInt()}", style: const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
                        interval: 60,
                      ),
                    ),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  gridData: FlGridData(show: true, drawVerticalLine: true),
                  borderData: FlBorderData(show: true, border: Border.all(color: const Color(0xFFE2E8F0))),
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      isCurved: true,
                      color: const Color(0xFF16A34A),
                      barWidth: 3,
                      dotData: FlDotData(show: true),
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Text("Minutes après injection", style: TextStyle(fontSize: 13, color: Color(0xFF64748B))),
          ],
        ),
      ),
    );
  }
}

class _LantusChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<FlSpot> spots = [
      FlSpot(0, 0),
      FlSpot(2, 20),
      FlSpot(4, 40),
      FlSpot(8, 75),
      FlSpot(12, 95),
      FlSpot(16, 90),
      FlSpot(20, 70),
      FlSpot(24, 50),
    ];
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Lantus (Insuline Lente)",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF2564EB)),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 220,
              child: LineChart(
                LineChartData(
                  minY: 0,
                  maxY: 110,
                  minX: 0,
                  maxX: 24,
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 38,
                        getTitlesWidget: (value, meta) => Text("${value.toInt()}%", style: const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
                        interval: 25,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 38,
                        getTitlesWidget: (value, meta) => Text("${value.toInt()}", style: const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
                        interval: 4,
                      ),
                    ),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  gridData: FlGridData(show: true, drawVerticalLine: true),
                  borderData: FlBorderData(show: true, border: Border.all(color: const Color(0xFFE2E8F0))),
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      isCurved: true,
                      color: const Color(0xFF2564EB),
                      barWidth: 3,
                      dotData: FlDotData(show: true),
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Text("Heures après injection", style: TextStyle(fontSize: 13, color: Color(0xFF64748B))),
          ],
        ),
      ),
    );
  }
}

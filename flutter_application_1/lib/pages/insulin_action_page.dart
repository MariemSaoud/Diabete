import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class InsulinActionPage extends StatelessWidget {
  const InsulinActionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        title: const Text("Profil d'Action de l'Insuline", style: TextStyle(color: Color(0xFF2564EB))),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF2564EB)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Profil d'Action de l'Insuline",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF2564EB)),
            ),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _NovoRapidChart()),
                const SizedBox(width: 24),
                Expanded(child: _LantusChart()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

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

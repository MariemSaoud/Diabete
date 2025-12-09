import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/daily_entry.dart';
import 'package:fl_chart/fl_chart.dart';

class GlycemiaChart extends StatelessWidget {
  final List<DailyEntry> entries;
  const GlycemiaChart({required this.entries, super.key});

  @override
  Widget build(BuildContext context) {
    // Préparer les données pour le graphique
    final List<FlSpot> matinaleSpots = [];
    final List<FlSpot> apresRepasSpots = [];
    final List<String> dates = [];
    for (int i = 0; i < entries.length; i++) {
      final entry = entries[i];
      final double? matinale = double.tryParse(entry.glycemieMatinale.replaceAll(',', '.'));
      final double? apresRepas = double.tryParse(entry.glycemie2h.replaceAll(',', '.'));
      if (matinale != null) matinaleSpots.add(FlSpot(i.toDouble(), matinale));
      if (apresRepas != null) apresRepasSpots.add(FlSpot(i.toDouble(), apresRepas));
      // Utiliser le jour et le mois pour l'axe X
      final dateParts = entry.date.split(' ');
      if (dateParts.length >= 3) {
        dates.add('${dateParts[1]} ${dateParts[2]}'); // "21 janv."
      } else {
        dates.add(entry.date);
      }
    }

    // On garde la liste dates telle quelle : chaque point a sa date

    // Limites normales
    const double limiteBasse = 0.7;
    const double limiteHaute = 1.2;

    return Center(
      child: Card(
        margin: const EdgeInsets.all(14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Évolution de la Glycémie',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFFDC2626)),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 240,
                child: LineChart(
                  LineChartData(
                    minY: 0.5,
                    maxY: 2.5,
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 44,
                          getTitlesWidget: (value, meta) {
                            return Text(value.toStringAsFixed(1), style: const TextStyle(fontSize: 13, color: Color(0xFF64748B)));
                          },
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 44,
                          interval: dates.length > 1 ? (dates.length - 1).toDouble() : 1.0,
                          getTitlesWidget: (value, meta) {
                            if (dates.isEmpty) return const SizedBox();
                            int idx = value.toInt();
                            if (idx == 0) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: Text(dates.first, style: const TextStyle(fontSize: 13, color: Color(0xFF64748B))),
                              );
                            }
                            if (idx == dates.length - 1) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: Text(dates.last, style: const TextStyle(fontSize: 13, color: Color(0xFF64748B))),
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ),
                      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      getDrawingHorizontalLine: (value) => FlLine(color: const Color(0xFFE2E8F0), strokeWidth: 1),
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        spots: matinaleSpots,
                        isCurved: false,
                        color: const Color(0xFFDC2626),
                        barWidth: 2.5,
                        dotData: FlDotData(show: true),
                        belowBarData: BarAreaData(show: false),
                        isStrokeCapRound: true,
                      ),
                      LineChartBarData(
                        spots: apresRepasSpots,
                        isCurved: false,
                        color: const Color(0xFFFF9800),
                        barWidth: 2.5,
                        dotData: FlDotData(show: true),
                        belowBarData: BarAreaData(show: false),
                        isStrokeCapRound: true,
                      ),
                      LineChartBarData(
                        spots: List.generate(entries.length, (i) => FlSpot(i.toDouble(), 0.7)),
                        isCurved: false,
                        color: const Color(0xFF22C55E),
                        barWidth: 2,
                        dotData: FlDotData(show: false),
                        dashArray: [6, 4],
                      ),
                      LineChartBarData(
                        spots: List.generate(entries.length, (i) => FlSpot(i.toDouble(), 1.2)),
                        isCurved: false,
                        color: const Color(0xFFFACC15),
                        barWidth: 2,
                        dotData: FlDotData(show: false),
                        dashArray: [6, 4],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Center(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 18,
                  runSpacing: 8,
                  children: [
                    _LegendDot(color: Color(0xFFDC2626), text: 'Glycémie matinale'),
                    _LegendDot(color: Color(0xFFFF9800), text: 'Glycémie après repas'),
                    _LegendDot(color: Color(0xFF22C55E), text: 'Limite basse normale'),
                    _LegendDot(color: Color(0xFFFACC15), text: 'Limite haute normale'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String text;
  const _LegendDot({required this.color, required this.text});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 14, height: 14, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text(text, style: const TextStyle(fontSize: 13)),
      ],
    );
  }
}

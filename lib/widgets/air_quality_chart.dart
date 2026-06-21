import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'glass_container.dart';

class AirQualityChart extends StatelessWidget {
  const AirQualityChart({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
      child: SizedBox(
        height: 200,
        child: LineChart(
          LineChartData(
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              horizontalInterval: 40,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: Colors.white.withOpacity(0.05),
                  strokeWidth: 1,
                  dashArray: [5, 5],
                );
              },
            ),
            titlesData: FlTitlesData(
              show: true,
              rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 22,
                  interval: 6,
                  getTitlesWidget: (value, meta) {
                    const style = TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.bold);
                    return SideTitleWidget(
                      axisSide: meta.axisSide,
                      child: Text('${value.toInt()}h', style: style),
                    );
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false,
                ),
              ),
            ),
            borderData: FlBorderData(show: false),
            minX: 0,
            maxX: 24,
            minY: 0,
            maxY: 160,
            lineTouchData: LineTouchData(
              touchTooltipData: LineTouchTooltipData(
                tooltipBgColor: AppTheme.surfaceColor.withOpacity(0.8),
                getTooltipItems: (touchedSpots) {
                  return touchedSpots.map((spot) {
                    return LineTooltipItem(
                      '${spot.y.toInt()} μg',
                      TextStyle(color: spot.bar.color, fontWeight: FontWeight.bold),
                    );
                  }).toList();
                },
              ),
            ),
            lineBarsData: [
              LineChartBarData(
                spots: const [
                  FlSpot(0, 110), FlSpot(4, 120), FlSpot(8, 140),
                  FlSpot(12, 130), FlSpot(16, 90), FlSpot(20, 100), FlSpot(24, 120),
                ],
                isCurved: true,
                color: Colors.orangeAccent.withOpacity(0.5),
                barWidth: 3,
                isStrokeCapRound: true,
                dotData: const FlDotData(show: false),
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    colors: [
                      Colors.orangeAccent.withOpacity(0.2),
                      Colors.orangeAccent.withOpacity(0.0),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              LineChartBarData(
                spots: const [
                  FlSpot(0, 12), FlSpot(4, 10), FlSpot(8, 15),
                  FlSpot(12, 11), FlSpot(16, 8), FlSpot(20, 7), FlSpot(24, 7),
                ],
                isCurved: true,
                color: AppTheme.primaryColor,
                barWidth: 4,
                isStrokeCapRound: true,
                dotData: const FlDotData(show: false),
                shadow: Shadow(color: AppTheme.primaryColor, blurRadius: 10),
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.primaryColor.withOpacity(0.3),
                      AppTheme.primaryColor.withOpacity(0.0),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

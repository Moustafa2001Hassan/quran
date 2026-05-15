import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:quran_journey/core/theme/app_styles.dart';
import 'package:quran_journey/core/theme/quran_journey_palette.dart';
import 'package:quran_journey/features/dashboard/data/models/daily_progress.dart';

/// Weekly progress chart widget using fl_chart.
class ProgressChart extends StatelessWidget {
  final List<DailyProgress> dailyProgress;

  const ProgressChart({super.key, required this.dailyProgress});

  @override
  Widget build(BuildContext context) {
    final palette = context.qjPalette;
    final scheme = Theme.of(context).colorScheme;
    final daysToShow = _getLast7Days();

    return SizedBox(
      height: 200,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: _calculateMaxY(),
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (_) => scheme.surfaceContainerHigh,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                final day = daysToShow[groupIndex];
                return BarTooltipItem(
                  '${_formatDay(day)}\n',
                  TextStyle(
                    color: scheme.onSurface,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                  children: [
                    TextSpan(
                      text: '📖 ${rod.toY.toInt()} memorized',
                      style: TextStyle(
                        color: palette.emerald,
                        fontSize: 11,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index < 0 || index >= daysToShow.length) {
                    return const Text('');
                  }
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      _formatDay(daysToShow[index]),
                      style: TextStyle(
                        color: scheme.onSurfaceVariant,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                },
                reservedSize: 30,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toInt().toString(),
                    style: TextStyle(
                      color: scheme.onSurfaceVariant,
                      fontSize: 11,
                    ),
                  );
                },
                reservedSize: 28,
              ),
            ),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: FlGridData(
            show: true,
            drawHorizontalLine: true,
            drawVerticalLine: false,
            horizontalInterval: 1,
            getDrawingHorizontalLine: (value) => FlLine(
              color: scheme.outlineVariant.withValues(alpha: 0.4),
              strokeWidth: 0.8,
              dashArray: [4, 4],
            ),
          ),
          borderData: FlBorderData(show: false),
          barGroups: _buildBarGroups(daysToShow, palette),
        ),
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      ),
    );
  }

  List<DateTime> _getLast7Days() {
    final now = DateTime.now();
    return List.generate(7, (i) {
      return now.subtract(Duration(days: 6 - i));
    });
  }

  List<BarChartGroupData> _buildBarGroups(
      List<DateTime> days, QuranJourneyPalette palette) {
    final progressMap = <int, DailyProgress>{};
    for (final dp in dailyProgress) {
      final key = DateTime(dp.date.year, dp.date.month, dp.date.day);
      progressMap[key.millisecondsSinceEpoch ~/ 86400000] = dp;
    }

    final today = DateTime.now();
    final todayKey = DateTime(today.year, today.month, today.day);

    return days.asMap().entries.map((entry) {
      final idx = entry.key;
      final date = entry.value;
      final dayKey = DateTime(date.year, date.month, date.day);
      final progress = progressMap[dayKey.millisecondsSinceEpoch ~/ 86400000];

      final memorized = progress?.memorizedCount ?? 0;
      final revised = progress?.revisedCount ?? 0;
      final isToday = dayKey.isAtSameMomentAs(todayKey);

      return BarChartGroupData(
        x: idx,
        barRods: [
          BarChartRodData(
            toY: memorized.toDouble(),
            color: isToday
                ? palette.emerald
                : palette.emerald.withValues(alpha: 0.6),
            width: 14,
            borderRadius: BorderRadius.circular(4),
          ),
          BarChartRodData(
            toY: revised.toDouble(),
            color: isToday
                ? palette.gold
                : palette.gold.withValues(alpha: 0.5),
            width: 14,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
        barsSpace: 4,
      );
    }).toList();
  }

  double _calculateMaxY() {
    if (dailyProgress.isEmpty) return 10;
    final allCounts =
        dailyProgress.map((e) => max(e.memorizedCount, e.revisedCount));
    final maxVal = allCounts.reduce(max).toDouble();
    return max(maxVal + 2, 10);
  }

  String _formatDay(DateTime date) {
    final today = DateTime.now();
    final yesterday = today.subtract(const Duration(days: 1));
    final dayDate = DateTime(date.year, date.month, date.day);
    final todayDate = DateTime(today.year, today.month, today.day);
    final yesterdayDate = DateTime(yesterday.year, yesterday.month, yesterday.day);

    if (dayDate.isAtSameMomentAs(todayDate)) return 'Today';
    if (dayDate.isAtSameMomentAs(yesterdayDate)) return 'Yesterday';

    final names = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return names[date.weekday - 1];
  }
}
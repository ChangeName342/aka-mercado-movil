import 'package:aka_mercado/features/admin/models/sales.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CategoryProductsChart extends StatelessWidget {
  final List<Sales> earnings;
  const CategoryProductsChart({
    Key? key,
    required this.earnings,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceEvenly,
        maxY: earnings.map((e) => e.earning).reduce((a, b) => a > b ? a : b).toDouble() * 1.5,
        minY: 0,
        groupsSpace: 30, // Añade espacio entre los grupos de barras
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            tooltipPadding: const EdgeInsets.all(8),
            tooltipMargin: 8,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              final Sales sales = earnings[groupIndex];
              return BarTooltipItem(
                '${sales.label}\n\$${sales.earning}',
                const TextStyle(color: Colors.white, fontSize: 14),
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 50, // Más espacio para las etiquetas en el eje Y
              getTitlesWidget: (value, _) {
                return Text(
                  '${value.toInt()}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 60, // Más espacio para las etiquetas del eje X
              getTitlesWidget: (double value, TitleMeta meta) {
                final label = earnings[value.toInt()].label;
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  space: 10, // Añade espacio entre el texto y el eje
                  child: Text(
                    label,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        gridData: FlGridData(
          show: true,
          drawHorizontalLine: true,
          getDrawingHorizontalLine: (value) => FlLine(
            color: Colors.grey.withOpacity(0.3),
            strokeWidth: 1,
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: Colors.grey, width: 0.5),
        ),
        barGroups: earnings
            .asMap()
            .map((index, sales) => MapEntry(
                  index,
                  BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: sales.earning.toDouble(),
                        color: Colors.blue,
                        width: 20,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ],
                  ),
                ))
            .values
            .toList(),
      ),
    );
  }
}


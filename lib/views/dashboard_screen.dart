import 'package:bidbox/controllers/dashboard_controller.dart';
import 'package:bidbox/views/widgets/dashboard_shimmer.dart';
import 'package:bidbox/views/widgets/indicator.dart';
import 'package:bidbox/views/widgets/nodata_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashBoardScreen extends StatelessWidget {
  DashBoardScreen({super.key});

  final DashBoradController _dashBoradController =
      Get.put(DashBoradController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: StreamBuilder<List<int>>(
            stream: _dashBoradController.readData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<int> data = snapshot.data ?? [];
                if (data.isEmpty) {
                  return const NoDataWidget();
                } else {
                  return Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        width: double.infinity,
                        height: 120,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white.withOpacity(0.3)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              ("Total Bids").toUpperCase(),
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              data[0].toString(),
                              style: const TextStyle(
                                  fontSize: 25, color: Colors.amber),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          childAspectRatio: 1.5,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white.withOpacity(0.3)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    ("Running Bids").toUpperCase(),
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(data[2].toString(),
                                      style: const TextStyle(
                                          fontSize: 25, color: Colors.amber))
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white.withOpacity(0.3)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    ("Ended Bids").toUpperCase(),
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    data[3].toString(),
                                    style: const TextStyle(
                                        fontSize: 25, color: Colors.amber),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 220,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(children: [
                          Expanded(
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: PieChart(
                                PieChartData(
                                  pieTouchData: PieTouchData(),
                                  borderData: FlBorderData(
                                    show: false,
                                  ),
                                  sectionsSpace: 0,
                                  centerSpaceRadius: 40,
                                  sections: showingSections(
                                      data[0], data[4], data[5]),
                                ),
                              ),
                            ),
                          ),
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Indicator(
                                color: Colors.greenAccent,
                                text: 'Bids Placed',
                                isSquare: true,
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Indicator(
                                color: Colors.amber,
                                text: 'Zero Bids',
                                isSquare: true,
                              ),
                            ],
                          ),
                        ]),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        width: double.infinity,
                        height: 110,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white.withOpacity(0.3)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              ("Total Value of Completed Bids").toUpperCase(),
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              "৳ ${data[1].toString()}",
                              style: const TextStyle(
                                  fontSize: 25, color: Colors.amber),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                }
              } else {
                return const DashBoardShimmer();
              }
            },
          ),
        ),
      ],
    );
  }

  List<PieChartSectionData> showingSections(
      int totalAuction, int totalAuctionWithBids, int totalAuctionWithoutBids) {
    const fontSize = 15.0;
    const radius = 50.0;
    const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
    return [
      PieChartSectionData(
        color: Colors.greenAccent,
        value: (totalAuctionWithBids / totalAuction) * 100,
        title: '${(totalAuctionWithBids / totalAuction) * 100}%',
        radius: radius,
        titleStyle: const TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          shadows: shadows,
        ),
      ),
      PieChartSectionData(
        color: Colors.amber,
        value: (totalAuctionWithoutBids / totalAuction) * 100,
        title: '${(totalAuctionWithoutBids / totalAuction) * 100}%',
        radius: radius,
        titleStyle: const TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          shadows: shadows,
        ),
      )
    ];
  }
}

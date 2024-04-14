import 'package:flutter/material.dart';
import 'package:fitness_dashboard_ui/data/health_details.dart';
import 'package:fitness_dashboard_ui/model/health_model.dart';
import 'package:fitness_dashboard_ui/util/responsive.dart';
import 'package:fitness_dashboard_ui/widgets/custom_card_widget.dart';

class ActivityDetailsCard extends StatefulWidget {
  const ActivityDetailsCard({Key? key}) : super(key: key);

  @override
  _ActivityDetailsCardState createState() => _ActivityDetailsCardState();
}

class _ActivityDetailsCardState extends State<ActivityDetailsCard> {
  late Future<List<HealthModel>> _healthDataFuture;

  @override
  void initState() {
    super.initState();
    // Start fetching health data immediately and every 15 seconds
    _fetchHealthData();
  }

  void _fetchHealthData() {
    _healthDataFuture = HealthDetails().getHealthData();
    Future.delayed(const Duration(seconds: 15), () {
      if (mounted) {
        setState(() {
          _fetchHealthData(); // Fetch again after 15 seconds
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<HealthModel>>(
      future: _healthDataFuture,
      builder: (context, snapshot) {
         if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<HealthModel>? healthDetails = snapshot.data;

          return GridView.builder(
            itemCount: healthDetails != null ? healthDetails.length : 0,
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: Responsive.isMobile(context) ? 2 : 4,
              crossAxisSpacing: Responsive.isMobile(context) ? 12 : 15,
              mainAxisSpacing: 12.0,
            ),
            itemBuilder: (context, index) {
              if (index == 3) {
                return CustomCard(
                  color: const Color.fromARGB(255, 224, 224, 224),
                  child: ElevatedButton(
                    onPressed: () {
                      // handle click
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(10),
                      backgroundColor: const Color.fromARGB(255, 224, 224, 224),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          healthDetails != null ? healthDetails[index].icon : "",
                          width: 60,
                          height: 60,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 15),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          healthDetails != null ? healthDetails[index].title : "",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 58, 58, 58),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return CustomCard(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        healthDetails != null ? healthDetails[index].icon : "",
                        width: 50,
                        height: 50,
                        colorBlendMode: BlendMode.lighten,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 4),
                        child: Text(
                          healthDetails != null ? healthDetails[index].value.toString() : "", // Convert double to String
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        healthDetails != null ? healthDetails[index].title : "",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          );
        }
      },
    );
  }
}

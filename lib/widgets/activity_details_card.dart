import 'package:fitness_dashboard_ui/data/health_details.dart';
import 'package:fitness_dashboard_ui/util/responsive.dart';
import 'package:fitness_dashboard_ui/widgets/custom_card_widget.dart';
import 'package:flutter/material.dart';

class ActivityDetailsCard extends StatelessWidget {
  const ActivityDetailsCard({super.key});

  @override
  @override
Widget build(BuildContext context) {
  final healthDetails = HealthDetails();

  return GridView.builder(
    itemCount: healthDetails.healthData.length,
    shrinkWrap: true,
    physics: const ScrollPhysics(),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: Responsive.isMobile(context) ? 2 : 4,
      crossAxisSpacing: Responsive.isMobile(context) ? 12 : 15,
      mainAxisSpacing: 12.0,
    ),
    itemBuilder: (context, index) {
      if (index == 3) { // Check if it's the fourth card
        return CustomCard(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                healthDetails.healthData[index].icon,
                width: 30,
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: ElevatedButton(
                  onPressed: () {
                    // Handle button press
                  },
                  child: const Icon(Icons.add),
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(10),
                    backgroundColor: Colors.blue
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Text(
                healthDetails.healthData[index].title,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        );
      } else {
        return CustomCard(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                healthDetails.healthData[index].icon,
                width: 50,
                height: 50,
                colorBlendMode: BlendMode.lighten,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 4),
                child: Text(
                  healthDetails.healthData[index].value,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                healthDetails.healthData[index].title,
                style: const TextStyle(
                  fontSize: 13,
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
}


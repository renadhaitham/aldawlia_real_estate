import 'package:flutter/material.dart';
import 'package:aldawlia_real_estate/core/theme/my_theme_data.dart';
import 'package:aldawlia_real_estate/screens/requests/service_request.dart';

class Services extends StatelessWidget {
  static const String routeName = "/service";

  final List<Service> services = const [
    Service('Maintenance', 'assets/Services/maintenance.png'),
    Service('Cleaning', 'assets/Services/cleaning.png'),
    Service('Security', 'assets/Services/security.png'),
    Service('Generators', 'assets/Services/generators.png'),
    Service('Finishing Works', 'assets/Services/finishing_works.png'),
    Service('Pests Control', 'assets/Services/pests_control.png'),
    Service('Planting Works', 'assets/Services/planting_works.png'),
    Service('Aluminum & Shutters', 'assets/Services/aluminum_and_shutters.png'),
    Service('A.C Services', 'assets/Services/ac_services.png'),
    Service('Car Cleaning', 'assets/Services/car_cleaning.png'),
    Service('Electrical & Plumbing', 'assets/Services/electrical_and_plumbing.png'),
    Service('Carpentry Works', 'assets/Services/carpentry_works.png'),
    Service('Garage Parking', 'assets/Services/garage_parking.png'),
    Service('Internet Services', 'assets/Services/internet_services.png'),
  ];

  const Services({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1,
          ),
          itemCount: services.length,
          itemBuilder: (context, index) => ServiceCard(service: services[index]),
        ),
      ),
    );
  }
}

class Service {
  final String name;
  final String iconPath;

  const Service(this.name, this.iconPath);
}

class ServiceCard extends StatelessWidget {
  final Service service;

  const ServiceCard({Key? key, required this.service}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ServiceRequest(selectedService: service.name),
        ),
      ),
      child: Card(
        color: MyThemeData.whiteColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(service.iconPath, width: 50, height: 50),
            const SizedBox(height: 20),
            Text(
              service.name,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}

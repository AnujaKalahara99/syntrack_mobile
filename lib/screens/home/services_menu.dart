import 'package:flutter/material.dart';
import '../near_me/near_me_screen.dart';

class Service {
  final String imageAsset;
  final String label;
  final Color backgroundColor;
  final Function(BuildContext) onTap;

  const Service({
    required this.imageAsset,
    required this.label,
    required this.backgroundColor,
    required this.onTap,
  });
}

class ServiceMenu extends StatelessWidget {
  const ServiceMenu({Key? key}) : super(key: key);

  List<Service> get _services => [
        Service(
          imageAsset: 'assets/images/nearme.png',
          label: 'Near me',
          backgroundColor: Color(0xFFF5F5F5),
          onTap: (context) => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NearMeScreen()),
          ),
        ),
        Service(
          imageAsset: 'assets/images/directions.png',
          label: 'Directions',
          backgroundColor: Color(0xFFF5F5F5),
          onTap: (context) {
            // TODO: Navigate to directions screen
          },
        ),
        Service(
          imageAsset: 'assets/images/routes.png',
          label: 'Routes',
          backgroundColor: Color(0xFFF5F5F5),
          onTap: (context) {
            // TODO: Navigate to routes screen
          },
        ),
        Service(
          imageAsset: 'assets/images/etickets.png',
          label: 'E-Tickets',
          backgroundColor: Color(0xFFF5F5F5),
          onTap: (context) {
            // TODO: Navigate to e-tickets screen
          },
        ),
        Service(
          imageAsset: 'assets/images/report.png',
          label: 'Report',
          backgroundColor: Color(0xFFF5F5F5),
          onTap: (context) {
            // TODO: Navigate to report screen
          },
        ),
        Service(
          imageAsset: 'assets/images/emergency.png',
          label: 'Emergency',
          backgroundColor: Color(0xFFF5F5F5),
          onTap: (context) {
            // TODO: Navigate to emergency screen
          },
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      padding: const EdgeInsets.all(20.0),
      mainAxisSpacing: 16.0,
      crossAxisSpacing: 16.0,
      children: _services
          .map((service) => NavigationButton(
                imageAsset: service.imageAsset,
                label: service.label,
                backgroundColor: service.backgroundColor,
                onTap: () => service.onTap(context),
              ))
          .toList(),
    );
  }
}

class NavigationButton extends StatelessWidget {
  final String imageAsset;
  final String label;
  final Color backgroundColor;
  final VoidCallback onTap;

  const NavigationButton({
    Key? key,
    required this.imageAsset,
    required this.label,
    required this.backgroundColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imageAsset,
              width: 60,
              height: 60,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

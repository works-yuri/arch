import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  final VoidCallback onPressed;
  const OnboardingScreen({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png',
                package: 'shared_ui'),
            fit: BoxFit.cover, // розтягнути
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              IconData(
                0xf443,
                fontFamily: 'CupertinoIcons',
                fontPackage: 'cupertino_icons',
              ),
              color: Colors.pink,
              size: 24.0,
              semanticLabel: 'Text to announce in accessibility modes',
            ),
            ElevatedButton(
              onPressed: () => onPressed(),
              child: const Text('Go To'),
            ),
            Text(
              'Onboarding Screen',
              style: const TextStyle(
                fontFamily: 'RobotoRegular',
                package: 'shared_ui',
              ),
            ),
            Text(
              'Onboarding Screen',
              style: const TextStyle(
                fontFamily: 'RobotoLight',
                package: 'shared_ui',
              ),
            ),
            Text(
              'Onboarding Screen',
              style: const TextStyle(
                fontFamily: 'RobotoMedium',
                package: 'shared_ui',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    const Color(0xFFD8B4FE), // svijetla lila
    const Color(0xFFF5F3FF), // gotovo bijela lila
    Colors.white,
  ],
),

        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),

                // Ikona / Logo
                Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: cs.primary.withValues(alpha: 0.18),
                  ),
                  child: ClipRRect(
                 borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/icons/logo.png',
                  fit: BoxFit.cover,
                   ),
                  ),
                ),

                const SizedBox(height: 28),

                // Naslov
                Text(
                  "Put smisla",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        letterSpacing: 2,
                      ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 12),

                // Slogan
                Text(
                  "Tri razine. Jedan put.\nTvoj odgovor na pitanje: Zašto?",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                 fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),

                const Spacer(),

                // Gumb
           GestureDetector(
  onTap: () {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
       builder: (_) => const LoginScreen(),
      ),
    );
  },
  child: Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(vertical: 18),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25),
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color.fromARGB(255, 167, 85, 214), // tamna lila
          Color.fromARGB(255, 35, 8, 63), // primary lila
        ],
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.arrow_forward_rounded,
          color: Colors.white,
          size: 26,
        ),
        const SizedBox(width: 10),
        Text(
          "Započni",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontSize: 22,
                letterSpacing: 1,
                fontWeight: FontWeight.w800,
              ),
        ),
      ],
    ),
  ),
),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

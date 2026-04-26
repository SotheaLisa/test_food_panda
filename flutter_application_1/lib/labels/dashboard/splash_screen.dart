// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _scaleAnim;
//   late Animation<double> _fadeAnim;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//         vsync: this, duration: const Duration(milliseconds: 1200));
//     _scaleAnim =
//         CurvedAnimation(parent: _controller, curve: Curves.elasticOut);
//     _fadeAnim = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
//     _controller.forward();

//     Future.delayed(const Duration(seconds: 3), () {
//       if (mounted) {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (_) => const WelcomeScreen()),
//         );
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: kPink,
//       body: Center(
//         child: FadeTransition(
//           opacity: _fadeAnim,
//           child: ScaleTransition(
//             scale: _scaleAnim,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   width: 120,
//                   height: 120,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(30),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.2),
//                         blurRadius: 20,
//                         offset: const Offset(0, 8),
//                       ),
//                     ],
//                   ),
//                   child: const Icon(Icons.delivery_dining,
//                       color: kPink, size: 70),
//                 ),
//                 const SizedBox(height: 24),
//                 const Text(
//                   'foodpanda',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 32,
//                     fontWeight: FontWeight.bold,
//                     letterSpacing: 1.5,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 const Text(
//                   'Delivering happiness 🐼',
//                   style: TextStyle(color: Colors.white70, fontSize: 14),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/RestraurantCard widget/constants/color.dart';
import 'welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 5), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPink,
      body: Center(
        child: Image.network(
          'https://i.pinimg.com/1200x/8e/9b/38/8e9b384c34fc7c1c8bd4edc8737878c1.jpg',
          width: 180,
        ),
      ),
    );
  }
}

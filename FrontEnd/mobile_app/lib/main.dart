import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app/widgets/details/details_screen.dart';
import 'package:mobile_app/widgets/home/home_screen.dart';
import 'package:mobile_app/settings_screen.dart';
import 'package:mobile_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  final screens = [
    const HomeScreen(),
    const DetailsScreen(),
    const SettingsScreen()
  ];

  // This widget is the root of your application.
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Actia Bike ',
      theme: ThemeData.from(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 0, 244, 8)),
          useMaterial3: true,
          textTheme: GoogleFonts.latoTextTheme()),
      home: Scaffold(
          appBar: AppBar(
            title: const Text(
              'actia bike',
            ),
          ),
          bottomNavigationBar: Container(
            margin: const EdgeInsets.only(bottom: 20, left: 30, right: 30),
            child: CustomNavigationBar(
              selectedColor: Colors.grey,
              isFloating: true,
              elevation: 30,
              borderRadius: const Radius.circular(30),
              items: [
                CustomNavigationBarItem(
                  icon: const Icon(
                    Icons.home_filled,
                    color: Colors.green,
                  ),
                  title: const Text('Home'),
                ),
                CustomNavigationBarItem(
                  icon: const Icon(
                    Icons.menu_book_rounded,
                    color: Colors.green,
                  ),
                  title: const Text('Details'),
                ),
                CustomNavigationBarItem(
                  icon: const Icon(
                    Icons.settings,
                    color: Colors.green,
                  ),
                  title: const Text('Settings'),
                ),
              ],
              currentIndex: _currentIndex,
              onTap: (int indx) {
                setState(() {
                  _currentIndex = indx;
                });
              },
            ),
          ),
          body: SafeArea(child: screens[_currentIndex])),
    );
  }
}

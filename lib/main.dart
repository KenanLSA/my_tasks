import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_tasks/presentation/pages/home_page.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  new({super.key});

  final _buttonShape = RoundedRectangleBorder(
    borderRadius: BorderRadiusGeometry.circular(8.0),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My Tasks",
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orangeAccent),
        shadowColor: Colors.grey[50],
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(shape: _buttonShape),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(shape: _buttonShape),
        ),
      ),
    );
  }
}

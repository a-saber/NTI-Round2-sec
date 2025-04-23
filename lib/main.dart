import 'package:flutter/material.dart';

import 'core/utils/app_text_styles.dart';
import 'features/home/views/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: AppTextStyles.fontFamily
      ),
      home: HomeView(),
    );
  }
}

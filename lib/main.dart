import 'package:flutter/material.dart';
import 'package:ui_tasks/features/add_item/presentation/pages/add_item_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:ui_tasks/features/select_item_screen/presentation/pages/select_item_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    /// wrappping material app with sizer widget
    return ResponsiveSizer(
      builder: (context, orientation, deviceType) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,

          /// add item screen
          home: SelectItemScreen(),
        );
      },
    );
  }
}

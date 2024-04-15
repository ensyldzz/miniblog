import 'package:blog_app/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const BlogApp());
}

class BlogApp extends StatelessWidget {
  const BlogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        theme: ThemeData.light().copyWith(
          colorScheme: const ColorScheme.light(),
          listTileTheme: const ListTileThemeData(
              contentPadding: EdgeInsets.zero,
              minLeadingWidth: 100,
              titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              iconColor: Colors.white),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: Colors.lightBlue),
          progressIndicatorTheme: const ProgressIndicatorThemeData(color: Colors.deepPurpleAccent),
          inputDecorationTheme: const InputDecorationTheme(
            labelStyle: TextStyle(color: Colors.deepPurpleAccent),
            border: OutlineInputBorder(),
            prefixIconColor: Colors.deepPurpleAccent,
            floatingLabelStyle: TextStyle(color: Colors.deepPurpleAccent, fontSize: 24, fontWeight: FontWeight.w600),
          ),
          appBarTheme: const AppBarTheme(
              centerTitle: true,
              titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 26, color: Colors.deepPurpleAccent),
              toolbarHeight: 70,
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.deepPurpleAccent),
              systemOverlayStyle: SystemUiOverlayStyle.dark),
        ),
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
      ),
    );
  }
}

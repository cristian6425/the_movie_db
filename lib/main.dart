import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie_db/route/route.dart';
import 'core/di/locator.dart';

void main() {
  runApp(MultiBlocProvider(providers: LocatorDi.instance, child: const App()));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The movies DB',
      theme: ThemeData(
        colorSchemeSeed:  Colors.deepPurple,
        useMaterial3: true,
      ),
     initialRoute: AppRoutes.initialRoute,
      routes: AppRoutes.routes
    );
  }
}


import 'package:flu_app/config/config.dart';
import 'package:flu_app/config/secret.example.dart';
import 'package:flu_app/presentation/providers/providers.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  
  MapboxOptions.setAccessToken(mapBoxAccessToken);

  runApp(
    const ProviderScope(
      child: MainApp()
    )
    );
}

//Hola esto es una prueba de commit
class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final tenebrisModus = ref.watch(estTenebrisModusProvider);

    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme(
        electusColor:Colors.deepOrangeAccent.shade100,
        tenebrisModusEst: tenebrisModus
        ).getTheme(),
    );
  }
}
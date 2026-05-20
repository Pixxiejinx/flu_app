
import 'package:flu_app/presentation/screens/bands/bands_screen.dart';
import 'package:flu_app/presentation/screens/domus/domus_screen.dart';
import 'package:flu_app/presentation/screens/numerator/numerator_screen.dart';
import 'package:flu_app/presentation/screens/charta/charta_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const DomusScreen(),
      ),
      GoRoute(
      path: '/numerator-river',
      builder: (context, state) => const NumeratorScreen(),
      ),
       GoRoute(
      path: '/bands',
      builder: (context, state) => const BandsScreen(),
      ),
         GoRoute(
      path: '/charta',
      builder: (context, state) => const ChartaScreen(),
      ),
    ]
  );
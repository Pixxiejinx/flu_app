import 'package:flu_app/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class NumeratorScreen extends ConsumerWidget {

  const NumeratorScreen({super.key});

  @override

  Widget build(BuildContext context, WidgetRef ref) {

    final int clickNumerator = ref.watch(numeratorProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('NumeratorScreen'),
      ),
      body: Center(
        child: Text('Valor: $clickNumerator', style: Theme.of(context).textTheme.titleLarge),
      ),
      floatingActionButton: FloatingActionButton
      (onPressed: () { 
        ref.read(numeratorProvider.notifier).state++;
       },
       child: const Icon(Icons.add),
       ),
    );
  }
}
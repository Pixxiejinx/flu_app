import 'dart:math' as math;
import 'package:flu_app/config/config.dart';
import 'package:flu_app/presentation/providers/modus_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DomusScreen extends ConsumerWidget {
  const DomusScreen({super.key});

  @override
  Widget build (BuildContext context, WidgetRef ref) {

    final bool estTenebrisModus = ref.watch(estTenebrisModusProvider);
   
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flu Avm App'),
        actions: [
          IconButton(
            onPressed: (){
              ref.read(estTenebrisModusProvider.notifier).update((state) =>!estTenebrisModus);
            }, 
            icon: Icon(
            estTenebrisModus 
            ? Icons.dark_mode_outlined
            : Icons.light
            )
      )
        ],
      ),
      body: const _DomusView(),
    );
  }
}


class _DomusView extends StatelessWidget {
  const _DomusView();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: appMenuItems.length,
      itemBuilder:(context, index) {
        final menuItem = appMenuItems[index];
        return _PropriumListTile(
          menuItem: menuItem);
      }, // _PorpriumListTile
      );
  }
}


class _PropriumListTile extends StatelessWidget {
  
  final MenuItem menuItem;
  
  const _PropriumListTile({
    required this.menuItem
  });

  @override
  Widget build(BuildContext context) {

    final colorum = Theme.of(context).colorScheme;

    return ListTile(
     title: Text(menuItem.titulus),
     subtitle: Text(menuItem.subtitulus),
     trailing: Icon(Icons.arrow_forward_ios_rounded, color: colorum.primary),
     leading: CircleAvatar(
      backgroundColor: Color.fromARGB(
        Theme.of(context).brightness == Brightness.dark ? 200 : 100, 
        math.Random().nextInt(255), 
        math.Random().nextInt(255), 
        math.Random().nextInt(255), 

        ),
      child: Icon(
        menuItem.icon,
        color: Colors.pinkAccent,
      ),
     ),
     onTap: () {
      context.push(menuItem.link);
     },
    );
  }
}
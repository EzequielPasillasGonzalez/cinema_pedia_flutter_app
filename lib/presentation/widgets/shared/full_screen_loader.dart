import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  Stream<String> getLoadingMessagesStream() {
    final messages = <String>[
      'Cargando pelicuas...',
      'Comprando palomitas de maíz...',
      'Cargando populares...',
      'Llamando a mi novia...',
      'Ya mero...',
      'Ya merito...',
    ];
    return Stream.periodic(const Duration(milliseconds: 1200), (step) {
      return messages[step];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Espere por favor...'),
          const CircularProgressIndicator(strokeWidth: 2),

          StreamBuilder(
            stream: getLoadingMessagesStream(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const SizedBox.shrink();
              return Text(snapshot.data!);
            },
          ),
        ],
      ),
    );
  }
}

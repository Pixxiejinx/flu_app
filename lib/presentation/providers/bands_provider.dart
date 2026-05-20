import 'package:flutter_riverpod/legacy.dart';
import '../../../config/config.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { Online, Offline, Connecting }

// 1. Definir el Provider (Solo uno, antes tenías dos con casi el mismo nombre)
final bandsProvider = StateNotifierProvider<BandsNotifier, BandsState>((ref) {
  return BandsNotifier();
});

// 2. Definir el Estado
class BandsState {
  final List<Band> bands;
  final ServerStatus serverStatus;
  final IO.Socket socket;

  BandsState({
    required this.bands,
    required this.serverStatus,
    required this.socket,
  });

  BandsState copyWith({
    List<Band>? bands,
    ServerStatus? serverStatus,
    IO.Socket? socket,
  }) {
    return BandsState(
      bands: bands ?? this.bands,
      serverStatus: serverStatus ?? this.serverStatus,
      socket: socket ?? this.socket,
    );
  }
}

// 3. El Notificador
class BandsNotifier extends StateNotifier<BandsState> {
  BandsNotifier() : super(BandsState(
    bands: [], // Empezamos vacío hasta que responda el server
    serverStatus: ServerStatus.Connecting,
    socket: IO.io('http://localhost:3000', 
      IO.OptionBuilder()
        .setTransports(['websocket'])
        .enableAutoConnect()
        .build()
    ),
  )) {
    // Llamamos a la configuración en el constructor
    _initConfig();
  }

  void _initConfig() {
    state.socket.onConnect((_) {
      state = state.copyWith(serverStatus: ServerStatus.Online);
    });

    state.socket.onDisconnect((_) {
      state = state.copyWith(serverStatus: ServerStatus.Offline);
    });

    state.socket.on('BANDS_LIST', (payload) {
      final List<Band> newBands = (payload as List)
          .map((b) => Band.fromMap(b))
          .toList();
      state = state.copyWith(bands: newBands);
    });
  }

  // Métodos de acción (Emiten al socket)
  void addereBand(String nomen) {
    if (nomen.isNotEmpty) {
      state.socket.emit('ADD_BAND', {'nomen': nomen});
    }
  }

  void addereVotum(String id) {
    state.socket.emit('ADD_VOTE', {'id': id});
  }

  void delereBand(String id) {
    state.socket.emit('DELETE_BAND', {'id': id});
  }
}
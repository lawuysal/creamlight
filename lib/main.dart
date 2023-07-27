import 'dart:io';

import 'package:creamlight/models/audio_track_model.dart';
import 'package:creamlight/models/cream_playlist_model.dart';
import 'package:creamlight/models/spotify_song_model.dart';
//import 'package:creamlight/pages/audio_query_test_screen.dart';
//import 'package:creamlight/pages/spotify_test_screen.dart';
import 'package:creamlight/services/permission_handler.dart';
import 'package:creamlight/utility/constants/go_router_constants.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
  // Initialize Hive, open boxes and register adapters
  await Hive.initFlutter(appDocumentsDir.path);
  Hive.registerAdapter(SpotifySongAdapter());
  Hive.registerAdapter(AudioTrackAdapter());
  Hive.registerAdapter(CreamPlaylistAdapter());
  await Hive.openBox('spotifyBox');
  await Hive.openBox<List>('audioTrackBox');
  await Hive.openBox<List>('creamPlaylistBox');

  // Wait for permission to be granted, if not granted, opens app settings
  final permissionStatus = await requestPermissions();

  if (permissionStatus) {
    runApp(const ProviderScope(child: MyApp()));
  } else {
    openAppSettings();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      routerConfig: pageRoutes,
    );
  }
}

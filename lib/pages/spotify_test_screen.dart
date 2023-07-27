import 'package:creamlight/services/spotify_auth.dart';
import 'package:creamlight/utility/functions/hive_functions.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../utility/notifiers/spotify_notifiers.dart';

class TestPage extends ConsumerWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final spotifyBox = Hive.box('spotifyBox');
    final songList = spotifyBox.get('spotifyTopSongs');

    // Buradaki hata için bir çözüm bul, ekranlar arası geçişte hatayı giderebilirsin
    // Program her başladığında provider false olarak initialize ediliyor
    final localDbStatus = ref.watch(spoTopSongsLocalDbStatus);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Test Page"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                await SpotifyAuth.fetchTopSongs(ref);
                CreamHive().setDbStatusTrue(ref);
              },
              child: const Text("Fetch Songs"),
            ),
            ElevatedButton(
              onPressed: () {
                spotifyBox.delete('spotifyTopSongs');
                CreamHive().setDbStatusFalse(ref);
              },
              child: const Text("Reset Songs"),
            ),
            ElevatedButton(
              onPressed: () {
                print(spotifyBox.get('spotifyTopSongs'));
                ;
              },
              child: const Text("Print"),
            ),
            (songList != null)
                ? Consumer(
                    builder: (context, ref, child) {
                      return Expanded(
                        child: (localDbStatus)
                            ? ListView.builder(
                                itemCount: songList.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(songList[index].name as String),
                                    subtitle:
                                        Text(songList[index].artist as String),
                                    leading: Image.network(
                                        songList[index].image as String),
                                  );
                                },
                              )
                            : const Text("No Songs On Database"),
                      );
                    },
                  )
                : const Text("Click the Fetch Songs button"),
          ],
        ),
      ),
    );
  }
}

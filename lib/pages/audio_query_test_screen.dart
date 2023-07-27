//import 'package:creamlight/utility/notifiers/audio_query_notifiers.dart';
import 'package:creamlight/utility/constants/go_router_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:creamlight/utility/functions/audio_query_functions.dart';
//import 'package:on_audio_query/on_audio_query.dart';

import '../models/audio_track_model.dart';
import '../utility/functions/hive_functions.dart';
import '../utility/notifiers/cream_light_notifiers.dart';
import '../utility/notifiers/just_audio_notifiers.dart';

class QueryTest extends ConsumerWidget {
  const QueryTest({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //  final isLibraryLoaded = ref.watch(aqLibraryStatus);
    final audioPlayer = ref.watch(jaAudioPlayer);
    final currentTrack = ref.watch(clCurrentTrack.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Query Test"),
      ),
      body: Center(
        child: Column(
          children: [
            //Gets the library
            ElevatedButton(
              onPressed: () async {
                await QAudio.getLibrary(ref);
              },
              child: const Text("Query Songs"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Plays the previous track
                ElevatedButton(
                  onPressed: () async {
                    await audioPlayer.pause();
                    await currentTrack.setPreviousTrack(ref);
                    await ref.watch(jaAudioPlayer.notifier).setFilePath(ref);
                    await audioPlayer.play();
                  },
                  child: const Text("Previous"),
                ),
                // Plays the current track
                ElevatedButton(
                  onPressed: () async {
                    await audioPlayer.play();
                  },
                  child: const Text("Play"),
                ),
                // Pauses the current track
                ElevatedButton(
                  onPressed: () async {
                    await audioPlayer.pause();
                  },
                  child: const Text("Pause"),
                ),
                // Plays the next track
                ElevatedButton(
                  onPressed: () async {
                    await audioPlayer.pause();
                    await currentTrack.setNextTrack(ref);
                    await ref.watch(jaAudioPlayer.notifier).setFilePath(ref);
                    await audioPlayer.play();
                  },
                  child: const Text("Next"),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                final audioTrackBox = Hive.box<List>('audioTrackBox');
                print(audioTrackBox.get('allSongs'));
              },
              child: const Text('Show Local Library'),
            ),
            ElevatedButton(
              onPressed: () {
                ref.watch(clTrackList.notifier).setTrackList(
                    ref,
                    Hive.box<List>('audioTrackBox')
                        .get('allSongs', defaultValue: [])!.cast<AudioTrack>());
                context.goNamed(RouteNames.allsongs);
              },
              child: const Text('Go All Songs Page'),
            ),
            ElevatedButton(
              onPressed: () {
                ref
                    .watch(clPlaylists.notifier)
                    .setPlaylistList(ref, CreamHive.getLocalPlaylist());
                context.goNamed(RouteNames.playlists);
              },
              child: const Text('Go Playlists Page'),
            ) /*
            (isLibraryLoaded)
                ? Consumer(
                    builder: (context, ref, child) {
                      final trackList = ref.watch(clTrackList);
                      return Expanded(
                        child: ListView.builder(
                          itemCount: trackList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () async {
                                // Sets selected track as current track
                                await ref
                                    .watch(clCurrentTrack.notifier)
                                    .setTrack(ref, index);

                                // Sets the current track as the audio player's file path
                                await ref
                                    .watch(jaAudioPlayer.notifier)
                                    .setFilePath(ref);

                                // Plays the selected track
                                await audioPlayer.play();
                              },
                              isThreeLine: true,
                              title: Text(trackList[index].name),
                              subtitle: Text(trackList[index].artistName),
                              leading: QueryArtworkWidget(
                                  id: trackList[index].mediaId,
                                  type: ArtworkType.AUDIO),
                            );
                          },
                        ),
                      );
                    },
                  )
                : const Text("Library not loaded"), */
          ],
        ),
      ),
    );
  }
}

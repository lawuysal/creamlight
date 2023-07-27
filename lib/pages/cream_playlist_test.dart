import 'package:creamlight/utility/functions/cream_functions.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../utility/notifiers/cream_light_notifiers.dart';
import '../utility/notifiers/just_audio_notifiers.dart';

class CreamPlaylistTest extends ConsumerWidget {
  const CreamPlaylistTest({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioPlayer = ref.watch(jaAudioPlayer);
    final playlistBox = Hive.box<List>('creamPlaylistBox');
    final playlists = playlistBox.get('playlists');
    final trackList = ref.watch(clTrackList.notifier).getTrackList;
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Songs'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Consumer(
              builder: (context, ref, child) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: playlists![0].trackIndexes.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () async {
                          ref
                              .watch(clQueue.notifier)
                              .setQueue(ref, playlists[0].trackIndexes);

                          // Sets selected track as current track
                          await ref.watch(clCurrentTrack.notifier).setTrack(
                              ref,
                              CreamFunc.getPlaylistTrackIndex(
                                  ref, playlists[0], index));

                          // Sets the current track as the audio player's file path
                          await ref
                              .watch(jaAudioPlayer.notifier)
                              .setFilePath(ref);

                          // Plays the selected track
                          await audioPlayer.play();
                        },
                        isThreeLine: true,
                        title: Text(trackList[CreamFunc.getPlaylistTrackIndex(
                                ref, playlists[0], index)]
                            .name),
                        subtitle: Text(trackList[
                                CreamFunc.getPlaylistTrackIndex(
                                    ref, playlists[0], index)]
                            .artistName),
                        leading: QueryArtworkWidget(
                            id: trackList[CreamFunc.getPlaylistTrackIndex(
                                    ref, playlists[0], index)]
                                .mediaId,
                            type: ArtworkType.AUDIO),
                      );
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

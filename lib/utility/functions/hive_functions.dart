import 'package:creamlight/models/cream_playlist_model.dart';
import 'package:creamlight/utility/notifiers/spotify_notifiers.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CreamHive {
  void setDbStatusTrue(WidgetRef ref) {
    final spotifyBox = Hive.box('spotifyBox');
    final songList = spotifyBox.get('spotifyTopSongs');
    if (songList != null) {
      ref.watch(spoTopSongsLocalDbStatus.notifier).state = true;
    }
  }

  void setDbStatusFalse(WidgetRef ref) {
    final spotifyBox = Hive.box('spotifyBox');
    final songList = spotifyBox.get('spotifyTopSongs');
    if (songList == null) {
      ref.watch(spoTopSongsLocalDbStatus.notifier).state = false;
    }
  }

  static List<CreamPlaylist> getLocalPlaylist() {
    final playlistBox = Hive.box<List>('creamPlaylistBox');
    final playlists =
        playlistBox.get('playlists', defaultValue: [])!.cast<CreamPlaylist>();
    debugPrint(playlists.toString());
    //

    return playlists;
  }
}

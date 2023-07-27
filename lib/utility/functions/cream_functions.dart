import 'package:creamlight/models/audio_track_model.dart';
import 'package:creamlight/utility/functions/hive_functions.dart';
import 'package:creamlight/utility/notifiers/cream_light_notifiers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/cream_playlist_model.dart';
import '../../widgets/playlist_prepare.dart';

class CreamFunc {
  ///****************************************************************//
  /// Returns the index of the stored in the playlist
  static int getPlaylistTrackIndex(
      WidgetRef ref, CreamPlaylist playlist, int index) {
    final trackList = ref.watch(clTrackList.notifier).getTrackList;
    for (int i = 0; i < trackList.length; i++) {
      if (trackList[i].mediaId == playlist.trackIndexes[index]) {
        return i;
      }
    }
    return -1;
  }

  ///****************************************************************//
  /// This is the overloadeed version of the above function
  /// Since dart does not support function overloading,
  /// we have to add 1 to the function name
  /// Returns the index of the stored in the playlist
  static int getPlaylistTrackIndex1(
      WidgetRef ref, List<int> playlist, int index) {
    final trackList = ref.watch(clTrackList.notifier).getTrackList;
    for (int i = 0; i < trackList.length; i++) {
      if (trackList[i].mediaId == playlist[index]) {
        return i;
      }
    }
    return -1;
  }

  ///****************************************************************//
  ///
  static List<AudioTrack> setQueueList(WidgetRef ref, List<int> playlist) {
    final trackList = ref.watch(clTrackList.notifier).getTrackList;
    final queueList = <AudioTrack>[];
    for (int i = 0; i < playlist.length; i++) {
      queueList
          .add(trackList[CreamFunc.getPlaylistTrackIndex1(ref, playlist, i)]);
    }

    return queueList;
  }

  ///****************************************************************//
  ///
  static void preparePlaylist(WidgetRef ref, String name, String description) {
    final playlist = CreamPlaylist(
      name: name,
      description: description,
    );
    ref.watch(clPlaylists.notifier).addPlaylist(playlist);
    ref.watch(clPlaylists.notifier).storePlaylistsLocally();
  }

  ///****************************************************************//
  ///
  static void createPlaylist(BuildContext context, GlobalKey<FormState> formKey,
      TextEditingController pNameCtrl, TextEditingController pDescriptionCtrl) {
    showDialog(
      context: context,
      builder: (context) {
        return CreamPlaylistPrepare(
          pNameCtrl: pNameCtrl,
          pDescriptionCtrl: pDescriptionCtrl,
          formKey: formKey,
        );
      }, //
    );
  }

  ///****************************************************************//
  ///
  static void deletePlaylist(WidgetRef ref, int index) {
    final playlists = CreamHive.getLocalPlaylist();
    playlists.removeAt(index);
  }
}

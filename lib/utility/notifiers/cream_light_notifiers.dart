import 'package:creamlight/utility/functions/cream_functions.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/audio_track_model.dart';
import '../../models/cream_playlist_model.dart';
import '../constants/audio_query_constants.dart';

///****************************************************************//
/// Stores the song list from the device storage
class TrackListNotifier extends StateNotifier<List<AudioTrack>> {
  TrackListNotifier() : super([]);

  // Adds new song to the list
  Future<void> addList(AudioTrack newTrack) async {
    // Checks if the song is already in the list
    if (state.every((element) => element.mediaId != newTrack.mediaId)) {
      state.add(newTrack);
    }
  }

  // Returns the song list
  List<AudioTrack> get getTrackList => state;

  // Sets the song list
  void setTrackList(WidgetRef ref, List localTrackList) {
    state = localTrackList as List<AudioTrack>;
  }

  // Stores the song list locally
  void storeSongsLocally() {
    final audioTrackBox = Hive.box<List>('audioTrackBox');
    //audioTrackBox.delete('allSongs');
    audioTrackBox.put('allSongs', state);
  }
}

// Responsible for providing the song list to the app
final clTrackList =
    StateNotifierProvider<TrackListNotifier, List<AudioTrack>>((ref) {
  return TrackListNotifier();
});

///****************************************************************//
/// Stores the queue list
class QueueNotifier extends StateNotifier<List<AudioTrack>> {
  QueueNotifier() : super([]);

  void setQueue(WidgetRef ref, List<int> playlist) {
    state = CreamFunc.setQueueList(ref, playlist);
  }
}

// Responsible for providing the queue list to the app
final clQueue = StateNotifierProvider<QueueNotifier, List<AudioTrack>>((ref) {
  return QueueNotifier();
});

///****************************************************************//
/// Stores the playlist list
class PlaylistsNotifier extends StateNotifier<List<CreamPlaylist>> {
  PlaylistsNotifier() : super([]);

  // Adds new playlist to the list
  Future<void> addPlaylist(CreamPlaylist newPlaylist) async {
    state.add(newPlaylist);
  }

  // Stores the playlists locally
  void storePlaylistsLocally() {
    final audioTrackBox = Hive.box<List>('creamPlaylistBox');
    audioTrackBox.put('playlists', state);
  }

  // Returns the song list
  List<CreamPlaylist> get getPlaylistList => state;

  // Sets the song list
  void setPlaylistList(WidgetRef ref, List localPlaylistList) {
    state = localPlaylistList as List<CreamPlaylist>;
  }
}

// Responsible for providing the playlist list to the app
final clPlaylists =
    StateNotifierProvider<PlaylistsNotifier, List<CreamPlaylist>>((ref) {
  return PlaylistsNotifier();
});

///****************************************************************//
/// Stores the current track
class CurrentTrackNotifier extends StateNotifier<AudioTrack> {
  CurrentTrackNotifier() : super(defaultTrack);

  // Sets the current track to the first song in the queue
  Future<void> setInitTrack(WidgetRef ref) async {
    state = ref.watch(clQueue).first;
  }

  // Sets the current track to the song at the given index
  Future<void> setTrack(WidgetRef ref, int index) async {
    final trackList = ref.watch(clQueue);
    state = trackList[index];
  }

  // Sets the current track to the next song in the list
  Future<void> setNextTrack(WidgetRef ref) async {
    final currenIndex = ref.watch(clQueue).indexOf(state);
    final lastIndex = ref.watch(clQueue).length - 1;
    if (currenIndex == lastIndex) {
      state = ref.watch(clQueue).first;
    } else {}
    state = ref.watch(clQueue)[currenIndex + 1];
  }

  // Sets the current track to the previous song in the list
  Future<void> setPreviousTrack(WidgetRef ref) async {
    final currenIndex = ref.watch(clQueue).indexOf(state);
    const firstIndex = 0;
    if (currenIndex == firstIndex) {
      state = ref.watch(clQueue).last;
    } else {}
    state = ref.watch(clQueue)[currenIndex - 1];
  }

  // Returns the current track
  Future<AudioTrack> getCurrentTrack() async {
    return state;
  }

  // Returns the current track path
  Future<String> getCurrentTrackPath() async {
    return state.path;
  }
}

// Responsible for providing the current track to the app
final clCurrentTrack =
    StateNotifierProvider<CurrentTrackNotifier, AudioTrack>((ref) {
  return CurrentTrackNotifier();
});

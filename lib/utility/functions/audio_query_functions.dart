import 'package:creamlight/utility/notifiers/audio_query_notifiers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../models/audio_track_model.dart';
import '../../models/cream_playlist_model.dart';
import '../notifiers/cream_light_notifiers.dart';

class QAudio {
  ///********************************************************//
  /// Initializes the audio query library
  static Future<void> getLibrary(WidgetRef ref) async {
    final newList = await _getLibraryList(ref);
    _addSongModelList(newList, ref);
    await _initAudioTrackList(ref);
    _initFirstPlaylist(ref);
    await _setLibraryStatus(ref);
  }

  /// Creates a song list using the OnAudioQuery plugin
  static Future<List<SongModel>> _getLibraryList(WidgetRef ref) async {
    final OnAudioQuery audioQuery = OnAudioQuery();
    final List<SongModel> songs = await audioQuery.querySongs(
      sortType: null,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );
    return songs;
  }

  /// Adds a song list to the state provider
  static void _addSongModelList(List<SongModel> newList, WidgetRef ref) {
    ref.watch(aqSongModelList.notifier).concatLists(newList);
  }

  /// Initializes the audio track list
  static Future<void> _initAudioTrackList(WidgetRef ref) async {
    final List<SongModel> songModelList = ref.watch(aqSongModelList);
    songModelList.forEach(
      (song) async {
        final AudioTrack newTrack = AudioTrack(
          name: song.displayNameWOExt,
          artistName: song.artist!,
          mediaId: song.id,
          mediaUri: song.uri!,
          path: song.data,
          extension: song.fileExtension,
          duration: song.duration!,
        );
        await ref.watch(clTrackList.notifier).addList(newTrack);

        // Stores the song list locally
        ref.watch(clTrackList.notifier).storeSongsLocally();
      },
    );
  }

  /// Initializes the first playlist which is all songs
  static void _initFirstPlaylist(WidgetRef ref) {
    final List<AudioTrack> trackList = ref.watch(clTrackList);
    final CreamPlaylist firstPlaylist = CreamPlaylist(
      name: 'All Songs',
    );
    for (int i = 0; i < trackList.length; i++) {
      firstPlaylist.trackIndexes.add(trackList[i].mediaId);
    }
    ref.watch(clPlaylists.notifier).addPlaylist(firstPlaylist);

    // Stores the playlists locally
    ref.watch(clPlaylists.notifier).storePlaylistsLocally();
  }

  /// Sets the library status to true
  static Future<void> _setLibraryStatus(WidgetRef ref) async {
    ref.watch(aqLibraryStatus.notifier).state = true;
  }
}

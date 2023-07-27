import 'package:creamlight/models/spotify_song_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

/// Stores actual fetched data from Spotify API
final spoTrackApiData = StateProvider<Map<String, dynamic>?>((ref) {
  return null;
});

/// Stores the response from the authorization endpoint
final spoAuthRespone = StateProvider<String>((ref) {
  return "";
});

/// Stores the authorization code extracted from the response
final spoAuthCode = StateProvider<String?>((ref) {
  return null;
});

/// Stores the response from the token endpoint
final spoTokenResponse = StateProvider<http.Response?>((ref) {
  return null;
});

/// Stores the status of the local storage of taken spotify songs
final spoTopSongsLocalDbStatus = StateProvider<bool>((ref) {
  return false;
});

/// Stroes the token response data
final spoTokenResponseData = StateProvider<Map<String, dynamic>?>((ref) {
  return null;
});

/// Stores the access token
final spoAccessToken = StateProvider<String?>((ref) {
  return null;
});

/// Stores the response from the user's top songs endpoint
final spoApiResponse = StateProvider<http.Response?>((ref) {
  return null;
});

/// Stores the response data from the user's top songs endpoint
final spoApiResponseData = StateProvider<Map<String, dynamic>?>((ref) {
  return null;
});

///****************************************************************//
/// Stores list of songs from the user's top songs endpoint
class SpotifySongsNotifier extends StateNotifier<List<SpotifySong>> {
  SpotifySongsNotifier() : super([]);

  void addSong(SpotifySong song) {
    if (state.every((element) => element.trackUri != song.trackUri)) {
      state.add(song);
    }
  }

  // Stores the list of songs in device
  void storeSongsLocally() {
    final spotifyBox = Hive.box('spotifyBox');
    //spotifyBox.delete('spotifyTopSongs');
    spotifyBox.put('spotifyTopSongs', state);
  }
}

// Responsible for SpotifySongsNotifier
final spoSongs =
    StateNotifierProvider<SpotifySongsNotifier, List<SpotifySong>>((ref) {
  return SpotifySongsNotifier();
});

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:on_audio_query/on_audio_query.dart';

///****************************************************************//
/// Stores the song list from the OnAudioQuery plugin
class AudioQueryNotifier extends StateNotifier<List<SongModel>> {
  AudioQueryNotifier() : super([]);

  void concatLists(List<SongModel> newList) {
    state = List.from(state)..addAll(newList);
  }
}

// Responsible for providing the song model list to the app
final aqSongModelList =
    StateNotifierProvider<AudioQueryNotifier, List<SongModel>>((ref) {
  return AudioQueryNotifier();
});




/// Stores the status of the audio query library initialization
final aqLibraryStatus = StateProvider<bool>((ref) {
  return false;
});


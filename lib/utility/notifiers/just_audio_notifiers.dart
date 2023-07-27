import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:just_audio/just_audio.dart';

import 'cream_light_notifiers.dart';

///****************************************************************//
/// Stores the audio player instance
class AudioPlayerNotifier extends StateNotifier<AudioPlayer> {
  AudioPlayerNotifier() : super(AudioPlayer());

  // Sets the audio player instance
  Future<void> setFilePath(WidgetRef ref) async {
    final newPath =
        await ref.watch(clCurrentTrack.notifier).getCurrentTrackPath();
    state.setFilePath(newPath);
  }
}

// Responsible for providing the audio player instance
final jaAudioPlayer =
    StateNotifierProvider<AudioPlayerNotifier, AudioPlayer>((ref) {
  return AudioPlayerNotifier();
});

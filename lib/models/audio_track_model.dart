import 'package:hive/hive.dart';

part 'audio_track_model.g.dart';

// This is the model for the Songs that came from the device

@HiveType(typeId: 1)
class AudioTrack {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String artistName;

  @HiveField(2)
  late int mediaId;

  @HiveField(3)
  late String mediaUri;

  @HiveField(4)
  late String path;

  @HiveField(5)
  late String extension;

  @HiveField(6)
  late int duration;

  @HiveField(7)
  bool isLiked = false;

  AudioTrack({
    required this.name,
    required this.artistName,
    required this.mediaId,
    required this.mediaUri,
    required this.path,
    required this.extension,
    required this.duration,
  });

  @override
  String toString() {
    return 'AudioTrack{name: $name, artistName: $artistName, mediaId: $mediaId, mediaUri: $mediaUri, path: $path, extension: $extension, duration: $duration, isLiked: $isLiked}';
  }
}

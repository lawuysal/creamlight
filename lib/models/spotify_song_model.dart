import 'package:hive/hive.dart';

// This is the model for the Spotify Songs that came from the Spotify API
part 'spotify_song_model.g.dart';

@HiveType(typeId: 0)
class SpotifySong {
  @HiveField(0)
  String? name = "No Song";

  @HiveField(1)
  String? artist = "No Artist";

  @HiveField(2)
  String? image = "No Image";

  @HiveField(3)
  String? trackUri = "No Track URI";

  SpotifySong({
    required this.name,
    required this.artist,
    required this.image,
    required this.trackUri,
  });

  @override
  String toString() {
    return 'SpotifySong{name: $name, artist: $artist, image: $image}';
  }
}

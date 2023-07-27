import 'package:hive/hive.dart';

part 'cream_playlist_model.g.dart';

@HiveType(typeId: 2)
class CreamPlaylist {
  @HiveField(0)
  late String name;

  @HiveField(1)
  String description = " ";

  @HiveField(2)
  List<int> trackIndexes = [];

  CreamPlaylist({
    required this.name,
    this.description = " ",
  });

  @override
  String toString() {
    return 'CreamPlaylist{name: $name, description: $description, trackIndexes: $trackIndexes}';
  }
}

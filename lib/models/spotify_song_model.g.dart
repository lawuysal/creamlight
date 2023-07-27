// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spotify_song_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SpotifySongAdapter extends TypeAdapter<SpotifySong> {
  @override
  final int typeId = 0;

  @override
  SpotifySong read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SpotifySong(
      name: fields[0] as String?,
      artist: fields[1] as String?,
      image: fields[2] as String?,
      trackUri: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SpotifySong obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.artist)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.trackUri);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpotifySongAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

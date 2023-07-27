// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cream_playlist_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CreamPlaylistAdapter extends TypeAdapter<CreamPlaylist> {
  @override
  final int typeId = 2;

  @override
  CreamPlaylist read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CreamPlaylist(
      name: fields[0] as String,
    )
      ..description = fields[1] as String
      ..trackIndexes = (fields[2] as List).cast<int>();
  }

  @override
  void write(BinaryWriter writer, CreamPlaylist obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.trackIndexes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CreamPlaylistAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

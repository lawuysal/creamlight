// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_track_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AudioTrackAdapter extends TypeAdapter<AudioTrack> {
  @override
  final int typeId = 1;

  @override
  AudioTrack read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AudioTrack(
      name: fields[0] as String,
      artistName: fields[1] as String,
      mediaId: fields[2] as int,
      mediaUri: fields[3] as String,
      path: fields[4] as String,
      extension: fields[5] as String,
      duration: fields[6] as int,
    )..isLiked = fields[7] as bool;
  }

  @override
  void write(BinaryWriter writer, AudioTrack obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.artistName)
      ..writeByte(2)
      ..write(obj.mediaId)
      ..writeByte(3)
      ..write(obj.mediaUri)
      ..writeByte(4)
      ..write(obj.path)
      ..writeByte(5)
      ..write(obj.extension)
      ..writeByte(6)
      ..write(obj.duration)
      ..writeByte(7)
      ..write(obj.isLiked);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AudioTrackAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watch_history_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WatchHistoryEntityAdapter extends TypeAdapter<WatchHistoryEntity> {
  @override
  final int typeId = 1;

  @override
  WatchHistoryEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WatchHistoryEntity(
      id: fields[0] as String,
      image: fields[3] as String,
      title: fields[2] as String,
      episodeId: fields[1] as String,
      currentPosition: fields[4] as Duration,
      currentEpisodeCount: fields[5] as int,
      subOrDub: fields[6] as String,
      genres: (fields[7] as List).cast<String>(),
      lastUpdatedAt: fields[8] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, WatchHistoryEntity obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.episodeId)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.currentPosition)
      ..writeByte(5)
      ..write(obj.currentEpisodeCount)
      ..writeByte(6)
      ..write(obj.subOrDub)
      ..writeByte(7)
      ..write(obj.genres)
      ..writeByte(8)
      ..write(obj.lastUpdatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WatchHistoryEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

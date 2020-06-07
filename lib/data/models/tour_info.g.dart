// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tour_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class _$_TourInfoAdapter extends TypeAdapter<_$_TourInfo> {
  @override
  final typeId = 4;

  @override
  _$_TourInfo read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_TourInfo(
      id: fields[0] as String,
      title: fields[1] as String,
      questionsCount: fields[2] as String,
      description: fields[3] as String,
      url: fields[4] as String,
      editors: fields[5] as String,
      createdAt: fields[6] as String,
      playedAt: fields[7] as String,
      tournamentInfo: fields[8] as TournamentInfo,
    );
  }

  @override
  void write(BinaryWriter writer, _$_TourInfo obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.questionsCount)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.url)
      ..writeByte(5)
      ..write(obj.editors)
      ..writeByte(6)
      ..write(obj.createdAt)
      ..writeByte(7)
      ..write(obj.playedAt)
      ..writeByte(8)
      ..write(obj.tournamentInfo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _$_TourInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

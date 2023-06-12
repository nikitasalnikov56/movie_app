// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourite_list.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavouriteListAdapter extends TypeAdapter<FavouriteList> {
  @override
  final int typeId = 0;

  @override
  FavouriteList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavouriteList(
      fields[0] as String?,
      fields[1] as String?,
      fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, FavouriteList obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.movieTitle)
      ..writeByte(1)
      ..write(obj.movieBg)
      ..writeByte(2)
      ..write(obj.movieOverview);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavouriteListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

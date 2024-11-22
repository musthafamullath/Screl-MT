// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FormDataAdapter extends TypeAdapter<FormData> {
  @override
  final int typeId = 1;

  @override
  FormData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FormData(
      sub: fields[0] as String?,
      prevText: fields[1] as String?,
      name: fields[2] as String?,
      email: fields[3] as String?,
      runFristTime: fields[4] as bool,
      cAudience: fields[5] as bool,
      currentStep: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, FormData obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.sub)
      ..writeByte(1)
      ..write(obj.prevText)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.runFristTime)
      ..writeByte(5)
      ..write(obj.cAudience)
      ..writeByte(6)
      ..write(obj.currentStep);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FormDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// ignore_for_file: must_be_immutable

import 'package:hive/hive.dart';

class DurationAdapter extends TypeAdapter<Duration> {
  @override
  int typeId = 2; // or whatever free id you have

  @override
  Duration read(BinaryReader reader) {
    return Duration(seconds: reader.read());
  }

  @override
  void write(BinaryWriter writer, Duration obj) {
    writer.write(obj.inSeconds);
  }
}

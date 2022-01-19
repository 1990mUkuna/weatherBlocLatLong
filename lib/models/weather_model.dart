import 'package:equatable/equatable.dart';

class Datasery extends Equatable {
  Datasery({
    this.timepoint,
    this.cloudcover,
    this.seeing,
    this.transparency,
    this.liftedIndex,
    this.rh2M,
    this.wind10M,
    this.temp2M,
    this.precType,
  });

  final int timepoint;
  final int cloudcover;
  final int seeing;
  final int transparency;
  final int liftedIndex;
  final int rh2M;
  final Wind10M wind10M;
  final int temp2M;
  final PrecType precType;

  // Map Weather into a json model
  factory Datasery.fromJson(Map<String, dynamic> json) => Datasery(
        timepoint: json["timepoint"],
        cloudcover: json["cloudcover"],
        seeing: json["seeing"],
        transparency: json["transparency"],
        liftedIndex: json["lifted_index"],
        rh2M: json["rh2m"],
        wind10M: Wind10M.fromJson(json["wind10m"]),
        temp2M: json["temp2m"],
        precType: precTypeValues.map[json["prec_type"]],
      );

  @override
  // TODO: implement props
  List<Object> get props => [
        timepoint,
        cloudcover,
        seeing,
        transparency,
        liftedIndex,
        rh2M,
        wind10M,
        temp2M,
        precType,
      ];
}

enum PrecType { NONE }

final precTypeValues = EnumValues({"none": PrecType.NONE});

class Wind10M {
  Wind10M({
    this.direction,
    this.speed,
  });

  String direction;
  int speed;

  factory Wind10M.fromJson(Map<String, dynamic> json) => Wind10M(
        direction: json["direction"],
        speed: json["speed"],
      );
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    // ignore: unnecessary_new
    reverseMap ??= map.map((k, v) => new MapEntry(v, k));
    return reverseMap;
  }
}

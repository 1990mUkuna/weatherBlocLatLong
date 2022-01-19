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

  Map<String, dynamic> toJson() => {
        "timepoint": timepoint,
        "cloudcover": cloudcover,
        "seeing": seeing,
        "transparency": transparency,
        "lifted_index": liftedIndex,
        "rh2m": rh2M,
        "wind10m": wind10M.toJson(),
        "temp2m": temp2M,
        "prec_type": precTypeValues.reverse[precType],
      };

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

  Map<String, dynamic> toJson() => {
        "direction": direction,
        "speed": speed,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map.map((k, v) => new MapEntry(v, k));
    return reverseMap;
  }
}

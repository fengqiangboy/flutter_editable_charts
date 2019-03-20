import 'package:json_annotation/json_annotation.dart';

part 'line_data_model.g.dart';

@JsonSerializable()
class LineDataModel {
  double x;

  double y;

  LineDataModel({this.x, this.y});

  @override
  String toString() {
    return 'LineDataModel{x: $x, y: $y}';
  }

  factory LineDataModel.fromJson(Map<String, dynamic> json) =>
      _$LineDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$LineDataModelToJson(this);
}

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'restaurant_model.g.dart';

@immutable
@JsonSerializable()
class RestaurantModel extends Equatable {
  final int id;
  final String title;
  final String poster;

  const RestaurantModel({
    required this.id,
    required this.title,
    required this.poster,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantModelFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantModelToJson(this);

  @override
  List<Object?> get props => [id, title, poster];
}

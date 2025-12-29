import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

import 'ribbon_item_model.dart';

part 'ribbon_model.g.dart';

String? _asNullableString(dynamic v) => v?.toString();


@CopyWith()
@JsonSerializable(explicitToJson: true)
class RibbonModel {
  final int? id;

  @JsonKey(fromJson: _asNullableString)
  final String? title;

  @JsonKey(fromJson: _asNullableString)
  final String? slug;

  @JsonKey(fromJson: _asNullableString)
  final String? description;

  @JsonKey()
  final int? status;

  @JsonKey(name: 'order')
  final int? order;

  @JsonKey(name: 'active_items')
  final List<RibbonItemModel>? items;

  const RibbonModel({
    this.id,
    this.title,
    this.slug,
    this.description,
    this.status,
    this.order,
    this.items,
  });

  factory RibbonModel.fromJson(Map<String, dynamic> json) => _$RibbonModelFromJson(json);

  Map<String, dynamic> toJson() => _$RibbonModelToJson(this);
}

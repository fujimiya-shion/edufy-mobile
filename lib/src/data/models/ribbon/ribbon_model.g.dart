// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ribbon_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RibbonModelCWProxy {
  RibbonModel id(int? id);

  RibbonModel title(String? title);

  RibbonModel slug(String? slug);

  RibbonModel description(String? description);

  RibbonModel status(int? status);

  RibbonModel order(int? order);

  RibbonModel items(List<RibbonItemModel>? items);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `RibbonModel(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// RibbonModel(...).copyWith(id: 12, name: "My name")
  /// ```
  RibbonModel call({
    int? id,
    String? title,
    String? slug,
    String? description,
    int? status,
    int? order,
    List<RibbonItemModel>? items,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfRibbonModel.copyWith(...)` or call `instanceOfRibbonModel.copyWith.fieldName(value)` for a single field.
class _$RibbonModelCWProxyImpl implements _$RibbonModelCWProxy {
  const _$RibbonModelCWProxyImpl(this._value);

  final RibbonModel _value;

  @override
  RibbonModel id(int? id) => call(id: id);

  @override
  RibbonModel title(String? title) => call(title: title);

  @override
  RibbonModel slug(String? slug) => call(slug: slug);

  @override
  RibbonModel description(String? description) =>
      call(description: description);

  @override
  RibbonModel status(int? status) => call(status: status);

  @override
  RibbonModel order(int? order) => call(order: order);

  @override
  RibbonModel items(List<RibbonItemModel>? items) => call(items: items);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `RibbonModel(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// RibbonModel(...).copyWith(id: 12, name: "My name")
  /// ```
  RibbonModel call({
    Object? id = const $CopyWithPlaceholder(),
    Object? title = const $CopyWithPlaceholder(),
    Object? slug = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? order = const $CopyWithPlaceholder(),
    Object? items = const $CopyWithPlaceholder(),
  }) {
    return RibbonModel(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int?,
      title: title == const $CopyWithPlaceholder()
          ? _value.title
          // ignore: cast_nullable_to_non_nullable
          : title as String?,
      slug: slug == const $CopyWithPlaceholder()
          ? _value.slug
          // ignore: cast_nullable_to_non_nullable
          : slug as String?,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as int?,
      order: order == const $CopyWithPlaceholder()
          ? _value.order
          // ignore: cast_nullable_to_non_nullable
          : order as int?,
      items: items == const $CopyWithPlaceholder()
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<RibbonItemModel>?,
    );
  }
}

extension $RibbonModelCopyWith on RibbonModel {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfRibbonModel.copyWith(...)` or `instanceOfRibbonModel.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RibbonModelCWProxy get copyWith => _$RibbonModelCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RibbonModel _$RibbonModelFromJson(Map<String, dynamic> json) => RibbonModel(
  id: (json['id'] as num?)?.toInt(),
  title: _asNullableString(json['title']),
  slug: _asNullableString(json['slug']),
  description: _asNullableString(json['description']),
  status: (json['status'] as num?)?.toInt(),
  order: (json['order'] as num?)?.toInt(),
  items: (json['active_items'] as List<dynamic>?)
      ?.map((e) => RibbonItemModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$RibbonModelToJson(RibbonModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'slug': instance.slug,
      'description': instance.description,
      'status': instance.status,
      'order': instance.order,
      'active_items': instance.items?.map((e) => e.toJson()).toList(),
    };

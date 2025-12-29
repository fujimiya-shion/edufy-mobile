// lib/src/data/models/enums.dart
import 'package:json_annotation/json_annotation.dart';

part 'enums.g.dart';

@JsonEnum(alwaysCreate: true)
enum CourseLevel {
  @JsonValue('beginner')
  beginner,
  @JsonValue('intermediate')
  intermediate,
  @JsonValue('advanced')
  advanced,
}

@JsonEnum(alwaysCreate: true)
enum CourseStatus {
  @JsonValue('draft')
  draft,
  @JsonValue('published')
  published,
  @JsonValue('archived')
  archived,
}

@JsonEnum(alwaysCreate: true)
enum LessonStatus {
  @JsonValue('draft')
  draft,
  @JsonValue('published')
  published,
  @JsonValue('locked')
  locked,
}


enum SocialProvider {
  google("google");

  final String value;

  const SocialProvider(this.value);
}

extension SocialProviderExtension on SocialProvider {
  String get label => value;
}
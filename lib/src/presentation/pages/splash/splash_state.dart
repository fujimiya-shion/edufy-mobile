import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:edufy_mobile/src/core/network/exception/api_exception.dart';
import 'package:edufy_mobile/src/shared/enums/enums.dart';
import 'package:equatable/equatable.dart';

part 'splash_state.g.dart';

@CopyWith()
class SplashState extends Equatable {
  final AppStatus status;
  final ApiException? exception;

  const SplashState({
    this.status = AppStatus.initial,
    this.exception,   
  });
  
  @override
  List<Object?> get props => [
    status,
    exception,
  ];
}
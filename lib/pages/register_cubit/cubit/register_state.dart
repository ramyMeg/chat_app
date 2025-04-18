part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}
final class RegisterSuccess extends RegisterState {}
final class RegisterLoadind extends RegisterState {}
final class RegisterFailure extends RegisterState {
  String errMessage;

  RegisterFailure({required this.errMessage});
}


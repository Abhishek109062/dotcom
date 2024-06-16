part of 'subadmin_bloc.dart';

@immutable
sealed class SubAdminState {}

final class SubAdminInitial extends SubAdminState {}
final class SubAdminLoading extends SubAdminState {}
final class SubAdminLoaded extends SubAdminState {}

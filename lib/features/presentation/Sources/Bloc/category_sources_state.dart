import 'package:equatable/equatable.dart';
import 'package:news_app/api/models/sources.dart'; // Assuming Source maps to Sources

abstract class CategorySourcesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CategorySourcesInitial extends CategorySourcesState {}

class CategorySourcesLoading extends CategorySourcesState {}

class CategorySourcesError extends CategorySourcesState {
  final String errorMessage;

  CategorySourcesError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class CategorySourcesSuccess extends CategorySourcesState {
  final List<Sources> sourcesList;

  CategorySourcesSuccess(this.sourcesList);

  @override
  List<Object?> get props => [sourcesList];
}

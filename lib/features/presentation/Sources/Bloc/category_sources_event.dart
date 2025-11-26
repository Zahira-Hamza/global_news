import 'package:equatable/equatable.dart';

abstract class CategorySourcesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetSourcesEvent extends CategorySourcesEvent {
  final String categoryId;

  GetSourcesEvent(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}

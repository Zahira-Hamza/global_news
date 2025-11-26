import 'package:equatable/equatable.dart';

abstract class NewsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetNewsEvent extends NewsEvent {
  final String sourceId;
  final int page;
  final int pageSize;

  GetNewsEvent(this.sourceId, {this.page = 1, this.pageSize = 20});

  @override
  List<Object?> get props => [sourceId, page, pageSize];
}

class LoadMoreNewsEvent extends NewsEvent {
  final String sourceId;
  final int pageSize;

  LoadMoreNewsEvent(this.sourceId, {this.pageSize = 20});

  @override
  List<Object?> get props => [sourceId, pageSize];
}

class ResetNewsEvent extends NewsEvent {
  final String sourceId;

  ResetNewsEvent(this.sourceId);

  @override
  List<Object?> get props => [sourceId];
}

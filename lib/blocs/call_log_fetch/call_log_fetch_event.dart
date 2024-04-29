import 'package:equatable/equatable.dart';

abstract class CallLogEvent extends Equatable {
    @override
    List<Object?> get props => [];
}

class FetchCallLogsEvent extends CallLogEvent {}

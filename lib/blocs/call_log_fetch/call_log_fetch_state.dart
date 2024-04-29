import 'package:call_log/call_log.dart';
import 'package:equatable/equatable.dart';
//import 'package:chat_box/data/models/contact_model.dart';

abstract class CallLogState extends Equatable {
    @override
    List<Object?> get props => [];
}

class CallLogsLoadingState extends CallLogState {}

class CallLogsLoadedState extends CallLogState {
    final List<CallLogEntry> callLogs;
    //final List<ContactModel> contactNames;

    CallLogsLoadedState(this.callLogs);//,this.contactNames

    @override
    List<Object?> get props => [callLogs];//,contactNames
}

class CallLogsErrorState extends CallLogState {
    final String message;

    CallLogsErrorState(this.message);

    @override
    List<Object?> get props => [message];
}

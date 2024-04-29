import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:call_log/call_log.dart';
import 'call_log_fetch_event.dart';
import 'call_log_fetch_state.dart';

class CallLogBloc extends Bloc<CallLogEvent, CallLogState> {
     //final DatabaseHelper dbHelper;
    CallLogBloc() : super(CallLogsLoadingState()) {
        on<FetchCallLogsEvent>(_onFetchCallLogs);
    }

    Future<void> _onFetchCallLogs(
        FetchCallLogsEvent event, Emitter<CallLogState> emit
    ) async {
        emit(CallLogsLoadingState());

        try {
            Iterable<CallLogEntry> callLogs = await CallLog.get();
            //List<ContactModel> contactNames = await dbHelper.getContacts();
            emit(CallLogsLoadedState(callLogs.toList())); //,contactNames
        } catch (e) {
            emit(CallLogsErrorState('Failed to fetch call logs.'));
        }
    }
}

import 'package:bloc/bloc.dart';

class ChatBloc extends Cubit<int>{
  ChatBloc(super.initialState);
  void setIndex(int index) {
    emit(index);
  }
}
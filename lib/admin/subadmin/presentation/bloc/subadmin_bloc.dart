
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/subadmin_model.dart';

part 'subadmin_event.dart';
part 'subadmin_state.dart';

class SubadminBloc extends Bloc<SubadminEvent, SubAdminState> {
  SubadminBloc() : super(SubAdminInitial()) {
    on<SubadminEvent>((event, emit) {
    });
    on<SubadminLoad>(getSubAdmins);
  }

  getSubAdmins(SubadminLoad event,Emitter<SubAdminState> emit) async{

  }

}

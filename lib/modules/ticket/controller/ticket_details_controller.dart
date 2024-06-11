import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../model/ticketModel.dart';
import '../model/ticket_config_model.dart';

class CreateTicketController extends GetxController {
  TextEditingController ticketDescription = TextEditingController();
  bool isLoading = false;
  TicketConfigModel ticketConfigModel = TicketConfigModel();
  TicketModel ticketDetails = TicketModel();
}

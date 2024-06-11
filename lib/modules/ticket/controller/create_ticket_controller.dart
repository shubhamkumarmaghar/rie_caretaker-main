import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../model/ticket_config_model.dart';

class CreateTicketController extends GetxController {
  TextEditingController ticketDescription = TextEditingController();
  bool isLoading = false;
  TicketConfigModel ticketConfigModel = TicketConfigModel();
}

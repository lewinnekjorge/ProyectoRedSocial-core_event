import 'package:get/get.dart';

class StatusController extends GetxController {
  var liststados = [].obs;

  addstatusmodel(status) {
    liststados.add(status);
  }

  borrarestado(index) {
    liststados.removeAt(index);
  }
}

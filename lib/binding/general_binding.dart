import 'package:examenmobile/utils/helpers/network_manager.dart';
import 'package:get/get.dart';

class GenerateBindings extends Bindings {
  @override
 void dependencies(){
    Get.put(NetworkManager()) ;
  }
}

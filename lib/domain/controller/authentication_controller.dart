import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationController extends GetxController {
  String userEmail() {
    String email;
    if (FirebaseAuth.instance.currentUser?.email == null){
                        email = "email@email.com";
                        } else{ email = FirebaseAuth.instance.currentUser!.email ?? "a@a.com";}
 
    return email;
  }

  String getUid() {
    String uid;
    if (FirebaseAuth.instance.currentUser?.uid == null){
                        uid = "Usuario";
                        } else{ uid = FirebaseAuth.instance.currentUser!.uid;}
 
    return uid;
  }
}

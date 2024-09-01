import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
class GoogleService{

  static signInWithGoogle() async{
    final googleUser=await GoogleSignIn(scopes: ['email','profile']).signIn();

      final googleAuth =await  googleUser?.authentication;
     final credential= GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken
      );
       await FirebaseAuth.instance.signInWithCredential(credential);

  }

}
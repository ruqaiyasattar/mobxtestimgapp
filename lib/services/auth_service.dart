import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobxtestingdemo/auth/auth_error.dart';

abstract class AuthService{
  String? get userId;
  Future<bool> deleteAccountSignOut();
  Future<void> signOut();

  Future<bool> register({
    required String email,
    required String password,
  });

  Future<bool> login({
    required String email,
    required String password,
  });

}

class FirebaseAuthService implements AuthService{

  @override
  Future<bool> deleteAccountSignOut()  async {

    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user == null) {

      return false;
    }

    try{
      //delete the user
      await user.delete();

      //logout user
      await auth.signOut();

      return true;
    } on FirebaseAuthException catch(e){
      throw AuthError.from(e);
    } catch(_){
      rethrow;
    }
  }

  @override
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
    );
    } on FirebaseAuthException catch (e){
      throw AuthError.from(e);
    }
    return FirebaseAuth.instance.currentUser != null;
  }

  @override
  Future<bool> register({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e){
      throw AuthError.from(e);
    }
    return FirebaseAuth.instance.currentUser != null;
  }

  @override
  Future<void> signOut() async {
    try{
      await FirebaseAuth.instance.signOut();
    } catch (_){
      //we are ignoring errors here
    }
  }

  @override
  String? get userId => FirebaseAuth.instance.currentUser?.uid;

}
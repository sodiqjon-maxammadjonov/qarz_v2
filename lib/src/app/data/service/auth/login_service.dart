import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qarz_v2/src/app/data/model/user/user_model.dart';
import 'package:qarz_v2/src/app/presentation/bloc/login/login_bloc.dart';

class AuthService {
  final Emitter<LoginState> emit;
  AuthService({required this.emit});
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel?> signUp(String email, String password, String name) async {
    try {
      emit(LoginLoadingState());
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      UserModel user = UserModel(
        id: userCredential.user!.uid,
        email: email,
        name: name,
      );

      await _firestore.collection('users').doc(user.id).set(user.toMap());
      emit(LoginSuccessState(message: 'Muvafaqiyatli kirildi'));
      return user;
    } catch (e) {
      emit(LoginErrorState(message: 'Hatolik: $e'));
      print('SignUp Error: $e');
      return null;
    }
  }

  Future<UserModel?> signIn(String email, String password) async {
    try {

      emit(LoginLoadingState());
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      DocumentSnapshot userDoc = await _firestore.collection('users').doc(userCredential.user!.uid).get();

      if (!userDoc.exists) return null;

      emit(LoginSuccessState(message: 'Muvafaqiyatli kirildi: $userDoc'));
      return UserModel.fromMap(userDoc.data() as Map<String, dynamic>, userCredential.user!.uid);
    } catch (e) {
      emit(LoginErrorState(message: 'Hatolik: $e'));
      print('SignIn Error: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}

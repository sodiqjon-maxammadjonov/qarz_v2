import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qarz_v2/src/app/data/model/user/user_model.dart';
import 'package:qarz_v2/src/app/presentation/bloc/login/login_bloc.dart';

class AuthService {
  final Emitter<LoginState> emit;
  AuthService({required this.emit});
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// **Ro‘yxatdan o‘tish (Sign Up)**
  Future<UserModel?> signUp(String username, String password, String name) async {
    try {
      emit(LoginLoadingState());

      // Foydalanuvchi uchun ID yaratish
      DocumentReference userRef = _firestore.collection('users').doc();
      String userId = userRef.id;

      UserModel user = UserModel(
        id: userId,
        username: username,
        password: password,
        name: name,
      );

      // Foydalanuvchini Firestore'ga saqlash
      await userRef.set(user.toMap());

      emit(LoginSuccessState(message: 'Muvaffaqiyatli ro‘yxatdan o‘tdingiz!'));
      return user;
    } catch (e) {
      emit(LoginErrorState(message: 'Xatolik: $e'));
      print('SignUp Error: $e');
      return null;
    }
  }

  /// **Tizimga kirish (Sign In)**
  Future<UserModel?> signIn(String username, String password) async {
    try {
      emit(LoginLoadingState());

      // Firestore'dan username bo‘yicha foydalanuvchini qidirish
      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .where('username', isEqualTo: username)
          .get();

      if (querySnapshot.docs.isEmpty) {
        emit(LoginErrorState(message: "Foydalanuvchi topilmadi!"));
        return null;
      }

      var userDoc = querySnapshot.docs.first;
      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

      // Parolni tekshirish
      if (userData['password'] != password) {
        emit(LoginErrorState(message: "Noto‘g‘ri parol!"));
        return null;
      }

      // UserModel yaratish
      UserModel user = UserModel.fromMap(userData, userDoc.id);

      emit(LoginSuccessState(message: "Muvaffaqiyatli kirildi!"));
      return user;
    } catch (e) {
      emit(LoginErrorState(message: "Xatolik yuz berdi: ${e.toString()}"));
      print('SignIn Error: $e');
      return null;
    }
  }

  /// **Tizimdan chiqish (Sign Out)**
  Future<void> signOut() async {
    emit(LoginLoadingState());
    try {
      emit(LoginSuccessState(message: "Tizimdan muvaffaqiyatli chiqildi!"));
    } catch (e) {
      emit(LoginErrorState(message: "Chiqishda xatolik yuz berdi!"));
    }
  }
}

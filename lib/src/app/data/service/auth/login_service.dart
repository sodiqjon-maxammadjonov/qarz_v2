import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qarz_v2/src/app/data/model/user/user_model.dart';
import 'package:qarz_v2/src/app/data/service/db/user/user_preferences.dart';
import 'package:qarz_v2/src/app/presentation/bloc/login/login_bloc.dart';

class AuthService {
  final Emitter<LoginState> emit;
  AuthService({required this.emit});
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// **Ro‘yxatdan o‘tish (Sign Up)**
  Future<UserModel?> signUp(String username, String password, String name) async {
    try {
      emit(LoginLoadingState());
      print("✅ [SIGN UP] Ro‘yxatdan o‘tish jarayoni boshlandi...");

      // Foydalanuvchi uchun ID yaratish
      DocumentReference userRef = _firestore.collection('u sers').doc();
      String userId = userRef.id;
      print("🆔 Yangi foydalanuvchi ID: $userId");

      UserModel user = UserModel(
        id: userId,
        username: username,
        password: password,
        name: name,
      );

      print("📝 Yangi foydalanuvchi ma'lumotlari: ${user.toMap()}");

      // Foydalanuvchini Firestore'ga saqlash
      await userRef.set(user.toMap());
      print("✅ Foydalanuvchi Firestore'ga muvaffaqiyatli qo'shildi!");

      emit(LoginSuccessState(message: 'Muvaffaqiyatli ro‘yxatdan o‘tdingiz!'));
      return user;
    } catch (e) {
      emit(LoginErrorState(message: 'Xatolik: $e'));
      print('❌ [SIGN UP] Xatolik: $e');
      return null;
    }
  }

  /// **Tizimga kirish (Sign In)**
  Future<UserModel?> signIn(String username, String password) async {
    try {
      emit(LoginLoadingState());
      print("✅ [SIGN IN] Tizimga kirish jarayoni boshlandi...");

      // Firestore'dan username bo‘yicha foydalanuvchini qidirish
      print("🔍 Foydalanuvchi qidirilmoqda: $username");
      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .where('username', isEqualTo: username)
          .get();

      if (querySnapshot.docs.isEmpty) {
        emit(LoginErrorState(message: "Foydalanuvchi topilmadi!"));
        print("❌ [SIGN IN] Foydalanuvchi topilmadi!");
        return null;
      }

      var userDoc = querySnapshot.docs.first;
      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
      print("🔍 Foydalanuvchi topildi: ${userData}");

      // Parolni tekshirish
      if (userData['password'] != password) {
        emit(LoginErrorState(message: "Noto‘g‘ri parol!"));
        print("❌ [SIGN IN] Noto‘g‘ri parol kiritildi!");
        return null;
      }

      // UserModel yaratish
      UserModel user = UserModel.fromMap(userData, userDoc.id);
      print("✅ [SIGN IN] Muvaffaqiyatli tizimga kirildi! User ID: ${user.id}");

      emit(LoginSuccessState(message: "Muvaffaqiyatli kirildi!"));
      return user;
    } catch (e) {
      emit(LoginErrorState(message: "Xatolik yuz berdi: ${e.toString()}"));
      print('❌ [SIGN IN] Xatolik yuz berdi: $e');
      return null;
    }
  }

  /// **Tizimdan chiqish (Sign Out)**
  Future<void> signOut() async {
    emit(LoginLoadingState());
    try {
      UserPreferences.clearUserId();
      print("🚪 [SIGN OUT] Tizimdan chiqish jarayoni boshlandi...");
      emit(LoginSuccessState(message: "Tizimdan muvaffaqiyatli chiqildi!"));
      print("✅ [SIGN OUT] Tizimdan muvaffaqiyatli chiqildi!");
    } catch (e) {
      emit(LoginErrorState(message: "Chiqishda xatolik yuz berdi!"));
      print("❌ [SIGN OUT] Chiqishda xatolik yuz berdi: $e");
    }
  }
}

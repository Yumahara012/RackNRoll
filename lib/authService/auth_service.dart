import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Sign in with Email and Password
  Future<AuthResponse> signInWithEmailPassword(String email, String password) async {
  return await _supabase.auth.signInWithPassword(
      email: email,
      password: password
  );
  }

  // Sign up with Email and Password
  Future<AuthResponse> signUpWithEmailPassword(String email, String password) async {
    return await _supabase.auth.signUp(
        email: email,
        password: password
    );
  }

  // Sign out
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  // Get Email
  String? getCurrentUserEmail() {
    final session = _supabase.auth.currentSession;
    final user = session?.user;
    return user?.email;
  }

  Future<bool> confirmOtp(String otp, String email) async {
    try {
      await _supabase.auth.verifyOTP(
        type: OtpType.signup,
        token: otp,
        email: email,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> sendOTPforPasswordReset(String email) async{
    return await _supabase.auth.resetPasswordForEmail(email);
  }

  Future<UserResponse> changePassword(String password) async{
    return await _supabase.auth.updateUser(
      UserAttributes(password: password),
    );
  }

}
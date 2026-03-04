import 'package:supabase_flutter/supabase_flutter.dart';

class SupaAuthClass {
  final SupabaseClient supa = Supabase.instance.client;

  Future<String> registrarUsuario(String email, String password) async {
    final GoTrueClient auth = supa.auth;
    try {
      final AuthResponse respuesta = await auth.signUp(
        email: email,
        password: password,
      );
      if (respuesta.session != null) {
        await supa.from('profiles').insert({
          'id': respuesta.user?.id,
          'username': generateUsernameFromEmail(email),
        });
        return 'Ok';
      } else {
        return 'Error session == null';
      }
    } on AuthException catch (e) {
      return e.message;
    } catch (e) {
      return '$e';
    }
  }

  String generateUsernameFromEmail(String email) {
    return email.split('@')[0];
  }

  Future<String> logInUsuario(String email, String password) async {
    final GoTrueClient auth = supa.auth;
    try {
      final AuthResponse respuesta = await auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (respuesta.session != null) {
        return 'Ok';
      } else {
        return 'Error session == null';
      }
    } on AuthException catch (e) {
      return e.message;
    } catch (e) {
      return '$e';
    }
  }

  Future<String> logOut() async {
    final GoTrueClient auth = supa.auth;
    try {
      await auth.signOut();
      return 'Ok';
    } on AuthException catch (e) {
      return e.message;
    } catch (e) {
      return '$e';
    }
  }
}

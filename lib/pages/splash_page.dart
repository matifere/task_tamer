import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task_tamer/pages/login_page.dart';
import 'package:task_tamer/pages/main_layout.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _redirect();
  }

  Future<void> _redirect() async {
    // Esperamos un breve momento para que la pantalla de splash se vea
    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;

    final session = Supabase.instance.client.auth.currentSession;
    
    if (session != null) {
      // Si hay sesión, vamos al inicio
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const MainLayout(),
        ),
      );
    } else {
      // Si no hay sesión, vamos al login
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.task_alt,
              size: 100,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 24),
            CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }
}

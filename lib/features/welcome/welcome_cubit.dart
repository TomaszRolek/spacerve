import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WelcomeCubit extends Cubit<String> {
  WelcomeCubit() : super('');

  Future<bool> redirect() async {
    await Future.delayed(Duration.zero);
    final session = Supabase.instance.client.auth.currentSession;
    return session != null;
  }
}

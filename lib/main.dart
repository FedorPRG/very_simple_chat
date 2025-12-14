import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat/services/chat_services.dart';

import 'contracts/contracts.dart';
import 'bloc/chat_bloc.dart';
import 'ui/auth_page.dart';
import 'ui/chat_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<Contracts>(
      create: (context) => ChatServices(),
      child: MaterialApp(
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(body: Center(child: CircularProgressIndicator()));
            }
            if (snapshot.hasData) {
              return BlocProvider(
                create: (context) => ChatBloc(context.read<Contracts>()),
                child: ChatPage(),
              );
            }
            return AuthPage();
          },
        ),
      ),
    );
  }
}

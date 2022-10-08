import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/models/models.dart';
import 'package:quiz_app/widgets/error.dart';
import 'package:quiz_app/profile/user_info.dart';

import '../helpers/app_constants.dart';
import '../services/auth.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var report = Provider.of<Report>(context);
    final AuthService authService = AuthService();

    return StreamBuilder(
      stream: AuthService().userStream,
      builder: (context, snapshot) {
        Widget child = Container();
        if (snapshot.data != null) {
          child = UserProfile(user: snapshot.data!, report: report);
        } else if (snapshot.hasError) {
          child = const ErrorGif(
            children: [
              Text("Maybe try logging in again?"),
            ],
          );
        }
        return Scaffold(
          appBar: AppBar(
            backgroundColor:
                AppConstants.hexToColor(AppConstants.appPrimaryColorGreen),
            title: const Text('Profile'),
            actions: [
              TextButton(
                onPressed: () async {
                  await authService.signOut();
                  if (mounted) {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/', (route) => false);
                  }
                },
                child: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: Center(child: child),
          ),
        );
      },
    );
  }
}

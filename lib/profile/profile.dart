import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/models/models.dart';
import 'package:quiz_app/widgets/user_avatar.dart';

import '../helpers/app_constants.dart';
import '../services/auth.dart';
import '../shared/shared.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var report = Provider.of<Report>(context);
    var user = AuthService().user;

    if (user != null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor:
              AppConstants.hexToColor(AppConstants.appPrimaryColorGreen),
          title: Text(user.displayName ?? 'Guest'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              UserAvatar(user: user),
              Text(user.email ?? '',
                  style: Theme.of(context).textTheme.headline6),
              const Spacer(),
              Text('${report.total}',
                  style: Theme.of(context).textTheme.headline2),
              Text('Quizzes Completed',
                  style: Theme.of(context).textTheme.subtitle2),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppConstants.hexToColor(
                      AppConstants.appPrimaryColorGreen),
                ),
                onPressed: () async {
                  await AuthService().signOut();
                  if (mounted) {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/', (route) => false);
                  }
                },
                child: const Text('logout'),
              ),
              const Spacer(),
            ],
          ),
        ),
      );
    } else {
      // Should I be disposing of state or something?
      // This is so that we can avoid a forever loading
      Future.delayed(
        const Duration(milliseconds: 500),
        () => Navigator.pushNamed(context, "/"),
      );
      return const Loader();
    }
  }
}

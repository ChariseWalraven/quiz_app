import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/models/models.dart' as models;
import 'package:quiz_app/services/firestore.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({
    super.key,
    required this.user,
    required this.report,
  });

  final User user;
  final models.Report report;

  @override
  Widget build(BuildContext context) {
    FirestoreService().getUserRoles();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: UserInfo(user: user)),
        Expanded(child: UserReport(report: report)),
      ],
    );
  }
}

class UserInfo extends StatefulWidget {
  const UserInfo({
    super.key,
    required this.user,
  });

  final User user;

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  models.UserRoles? userRoles;

  @override
  void initState() {
    super.initState();
    getUserRoles();
  }

  void getUserRoles() async {
    models.UserRoles res = await FirestoreService().getUserRoles();

    setState(() {
      userRoles = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        UserAvatar(user: widget.user),
        if (widget.user.displayName != null &&
            widget.user.displayName!.isNotEmpty)
          Text(
            widget.user.displayName!,
            style: textTheme.titleLarge,
          ),
        if (widget.user.email!.isNotEmpty)
          Text(
            widget.user.email!,
            style: textTheme.titleMedium,
          ),
        if (kDebugMode && userRoles != null) UserRoles(userRoles: userRoles!),
      ],
    );
  }
}

class UserReport extends StatelessWidget {
  const UserReport({
    super.key,
    required this.report,
  });
  final models.Report report;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Text(
          '${report.total}',
          style: textTheme.displayMedium,
        ),
        Text(
          'Quizzes Completed',
          style: textTheme.titleSmall,
        ),
      ],
    );
  }
}

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    required this.user,
    this.canEdit = false,
    this.onEdit,
  });

  final User user;
  final bool canEdit;
  final void Function()? onEdit;

  @override
  Widget build(BuildContext context) {
    ImageProvider image = const AssetImage("assets/user.png");
    if (user.photoURL != null && user.photoURL!.isNotEmpty) {
      image = NetworkImage(user.photoURL!);
    }
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: image,
              ),
            ),
          ),
          if (canEdit)
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: onEdit ??
                      () {
                        throw UnimplementedError();
                      },
                  child: const Icon(
                    Icons.edit,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class UserRoles extends StatelessWidget {
  const UserRoles({super.key, required this.userRoles});

  final models.UserRoles userRoles;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "User roles:",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Text("isAdmin? ${userRoles.isAdmin}"),
      ],
    );
  }
}

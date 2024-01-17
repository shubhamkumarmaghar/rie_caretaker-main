// profile_page.dart
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../../../utils/const/app_urls.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(GetStorage().read(Constants.profileUrl)),
              ),
            ),
            SizedBox(height: 16),
            Text('Name: ${GetStorage().read(Constants.usernamekey)}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Mobile: ${GetStorage().read(Constants.phonekey)}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Email: ${GetStorage().read(Constants.emailkey)}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Role: ${GetStorage().read(Constants.rolekey)}', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}

import 'package:e_waste/core/router/app_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/services/auth_service.dart';
import '../core/services/local_storage_service/hive_service.dart';
import '../data/models/user_model.dart';

/// ViewModel handling user authentication and user state management
class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _user;
  Map<String, dynamic>? userInfoMap;

  User? get user => _user;
  bool? forgetStatus;

  /// Handles user login logic
  /// - Authenticates the user
  /// - Stores user info (email & username) in Hive for persistence
  Future<void> signIn(BuildContext context, String email, String password,
      String userName) async {
    try {
      userInfoMap = await _authService.signIn(email, password, userName);

// ✅ Save user details locally after successful login as UserModel
      final userModel = UserModel(email: email, username: userName);
      await HiveService.saveUserModel(userModel);
      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          margin: EdgeInsets.only(
            bottom: kBottomNavigationBarHeight + 16,
            left: 16,
            right: 16,
          ),
          behavior: SnackBarBehavior.floating,
          content: Text("Login successful!"),
          backgroundColor: Colors.green,
        ),
      );
      print(userInfoMap!.putIfAbsent("name", () => userName));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.toString()), backgroundColor: Colors.red),
      );
    }
  }

  /// Handles user registration
  /// - Registers the user
  /// - Stores user info (email & username) in Hive for persistence
  Future<void> signUp(BuildContext context, String email, String password,
      String userName) async {
    try {
      _user = await _authService.signUp(email, password, userName);

// ✅ Save user details locally after successful signup as UserModel
      final userModel = UserModel(email: email, username: userName);
      await HiveService.saveUserModel(userModel);
      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          margin: EdgeInsets.only(
            bottom: kBottomNavigationBarHeight + 16,
            left: 16,
            right: 16,
          ),
          behavior: SnackBarBehavior.floating,
          content: Text("Signup successful!"),
          backgroundColor: Colors.green,
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.toString()), backgroundColor: Colors.red),
      );
    }
  }

  /// Handles user logout
  /// - Clears user session
  /// - Removes user data from Hive local storage
  Future<void> signOut(BuildContext context) async {
    await _authService.signOut();
    _user = null;

// ✅ Clear Hive data on logout
    await HiveService.clearUser();
    notifyListeners();

    Get.offAllNamed(RouteNavigation.authCheckerScreenRoute);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Logged out successfully!"),
        backgroundColor: Colors.blue,
      ),
    );
  }

  /// Sends a password reset email to the user
  Future<void> forgetPass(BuildContext context, String email) async {
    try {
      forgetStatus = await _authService.forgetPass(email);
      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password Reset Email has been sent!"),
          backgroundColor: Colors.green,
        ),
      );
    } catch (error) {
      print(error.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.toString()), backgroundColor: Colors.red),
      );
    }
  }

  /// Handles Google Sign-In authentication
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      _user = await _authService.signInWithGoogle();

// ✅ Save user details locally after successful login as UserModel
      final userModel =
          UserModel(email: _user!.email!, username: _user!.displayName!);
      await HiveService.saveUserModel(userModel);
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Google Sign-In successful!"),
          backgroundColor: Colors.green,
        ),
      );
    } catch (error) {
      print(error.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.toString()), backgroundColor: Colors.red),
      );
    }
  }

  /// Fetches stored user data from Hive (UserModel)
  /// Useful for auto-login or showing user info offline
  Future<UserModel?> getUserFromHive() async {
    return await HiveService.getUserModel();
  }
}

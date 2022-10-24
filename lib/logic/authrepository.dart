
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login_tuan2/core/enums/status_state.dart';
import 'package:firebase_login_tuan2/core/models/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;
  //final FirebaseMessaging _firebaseMessaging;
  //final GoogleSignIn _googleSignIn;

  AuthRepository({FirebaseAuth? firebaseAuth, FirebaseFirestore? firebaseFirestore})
        : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;
          //_googleSignIn = googleSignIn ?? GoogleSignIn();
  static UserModel currentUser = UserModel.empty;
  Stream<DocumentSnapshot<Map<String, dynamic>>> streamAccount(){
    return _firebaseFirestore.collection("users").doc(currentUser.id).snapshots();
  }
  // Future<String> getDeviceTokenToSendNotification() async {
  //   final FirebaseMessaging fcm = FirebaseMessaging.instance;
  //   final token = await fcm.getToken();
  //   return token.toString();
  // }
  // Future<String> updateAccount(Map<String, dynamic> infoUpdate) async {
  //   try {
  //     print("uid: ${currentUser.id}");
  //     infoUpdate.removeWhere((key, value) => value == null);
  //     await _firebaseFirestore.collection("users")
  //         .doc(currentUser.id)
  //         .update(infoUpdate);
  //     return "Success";
  //   } on FirebaseException catch (error) {
  //     return "Error: ${error.message}";
  //   }
  // }
  _streamAccount({required String uid}){
    _firebaseFirestore.collection("users").doc(uid).snapshots().listen((event) {
      currentUser = UserModel.fromMap(event.data());
      // if(tokenMess != currentUser.tokenMessages){
      //   updateAccount({"token_messages":tokenMess});
      // }
    });
  }
  streamUser() {
    _firebaseAuth.authStateChanges().listen((firebaseUser) async {
      if (firebaseUser != null) {
        //String tokenMess = await getDeviceTokenToSendNotification();
        _streamAccount(uid:firebaseUser.uid);
      }
      else {
        currentUser = UserModel.empty;
        print("account logout ${currentUser.toJson()}");

      }
    });
  }
  bool checkLoginRegister() {
    return _firebaseAuth.currentUser != null;
  }
  Future<String> signUp({required String email, required String password, required String name, required int phone}) async{
    try{
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password
      ).then((value) => _profileToFirebase(
        name: name,
        email: email,
        phone: phone,
        uid: value.user!.uid
      ));

      return "SignUp Success";
    } on FirebaseAuthException catch (error) {
      String errorMessage;
      switch (error.code) {
        case "invalid-email":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        case "email-already-in-use":
          errorMessage = "Your email already exists.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      return errorMessage;
    }
  }
  Future<String> signIn({required String email, required String password}) async{
    try{
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
    return 'SignIn success';
    } on FirebaseAuthException catch (error) {
      String errorMessage;
      switch (error.code) {
        case "invalid-email":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "Account or password is not precision.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      return errorMessage;
    }
  }
  Future<void> signOut() async{
    try {
      await Future.wait([
        _firebaseAuth.signOut()
      ]);
    } catch (_){}
  }
  _profileToFirebase({required String name, required String email, required String uid, required int phone}) async{
    UserModel data =  UserModel(
        name: name,
        email: email,
        id: uid,
        phone: phone
    );
    // AuthRepository.currentUser = data;
    await _firebaseFirestore.collection("users").doc(uid).set(data.toJson());
  }
}
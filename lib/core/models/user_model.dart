import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable{
  final String? name;
  final String? email;
  final String? id;
  final int? phone;
  final String? tokenMessages;
  const UserModel({this.name, this.email, this.id, this.phone, this.tokenMessages});

  @override
  List<Object?> get props => [name, email, id, phone];
  UserModel copyWith({String? name, String? email, String? id, int? phone, String? tokenMessages}){
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      id: id ?? this.id,
      phone: phone ?? this.phone,
      tokenMessages: tokenMessages ?? this.tokenMessages
    );
  }
  static UserModel empty = const UserModel(id: '');
  bool get isEmpty => this == UserModel.empty;
  bool get isNotEmpty => this != UserModel.empty;
  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
      id: json['uid'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      tokenMessages: json['tokenMessages']
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'uid' : id,
      'name' : name,
      'email' : email,
      'phone' : phone,
      'tokenMessages' : tokenMessages
    };
  }
  factory UserModel.fromMap(map){
    return UserModel(
      id: map['uid'],
      email: map['email'],
      name: map['name'],
      phone: map['phone'],
      tokenMessages: map['tokenMessages']
    );
  }
  factory UserModel.formSnapshot(DocumentSnapshot snap){
    UserModel userModel = UserModel(
      id: snap.id,
      name: snap['name'],
      email: snap['email'],
      phone: snap['phone'],
      tokenMessages: snap['token_messages'],
    );
    return userModel;
  }
}
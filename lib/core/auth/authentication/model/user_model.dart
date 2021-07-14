import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String userId;
  final String name;

  const UserModel({required this.userId, required this.name});

  static const empty = UserModel(userId: "", name: "");

  @override
  List<Object?> get props => [userId, name];
}
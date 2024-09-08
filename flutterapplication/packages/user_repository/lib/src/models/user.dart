import 'package:equatable/equatable.dart';
import 'package:user_repository/src/entities/user_entities.dart';

class MyUser extends Equatable {
  final String userid;
  final String emailid;
  final String name;
  final bool hasactivecart;

  const MyUser({
    required this.userid,
    required this.emailid,
    required this.name,
    required this.hasactivecart,
  });

  // Updated empty getter
  static MyUser get empty => const MyUser(
    userid: '',
    emailid: '',
    name: '',
    hasactivecart: false,
  );

  MyUser copyWith({
    String? userid,
    String? emailid,
    String? name,
    bool? hasactivecart,
  }) {
    return MyUser(
      userid: userid ?? this.userid,
      emailid: emailid ?? this.emailid,
      name: name ?? this.name,
      hasactivecart: hasactivecart ?? this.hasactivecart,
    );
  }

  MyUserEntity toEntity() {
    return MyUserEntity(
      userid: userid,
      emailid: emailid,
      name: name,
      hasactivecart: hasactivecart,
    );
  }

  static MyUser fromEntity(MyUserEntity entity) {
    return MyUser(
      userid: entity.userid,
      emailid: entity.emailid,
      name: entity.name,
      hasactivecart: entity.hasactivecart,
    );
  }

  @override
  String toString() {
    return 'MyUser: $userid, $emailid, $name, $hasactivecart';
  }

  @override
  List<Object?> get props => [userid, emailid, name, hasactivecart];
}
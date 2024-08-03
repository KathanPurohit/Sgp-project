import 'package:equatable/equatable.dart';
import 'package:user_repository/src/entities/user_entities.dart';

class MyUser extends Equatable{
  String userid;
  String emailid;
  String name;
  bool hasactivecart;
  MyUser({
    required this.userid,
    required this.emailid,
    required this.name,
    required this.hasactivecart,

  });
  static final empty = MyUser(
    userid: '', 
    emailid: '', 
    name: '', 
    hasactivecart: false,
  );
  MyUserEntity toEntity(){
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
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
} 
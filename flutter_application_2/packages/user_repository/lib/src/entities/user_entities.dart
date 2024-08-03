class MyUserEntity {
  String userid;
  String emailid;
  String name;
  bool hasactivecart;
  MyUserEntity({
    required this.userid,
    required this.emailid,
    required this.name,
    required this.hasactivecart,

  });

  Map<String, Object?> toDocument() {
    return{
      'userid': userid,
      'emailid': emailid,
      'name': name,
      'hasactivecart': hasactivecart,
    };
  }
  static MyUserEntity fromDocument(Map<String, dynamic> doc) {
    return MyUserEntity(
      userid: doc['userid'], 
      emailid: doc['emailid'],
      name: doc['name'], 
      hasactivecart: doc['hasactivecart'],
      );
  }
}
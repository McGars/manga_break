class FirebaseUserRequest {
  String idToken;

  FirebaseUserRequest(this.idToken);

  Map<String, dynamic> toJson() => {
        'idToken': idToken
      };
}

/// Not all parameters presents this
class FirebaseUserResponse {
  String email;
  bool emailVerified;
  String photoUrl;
  String localId;

  FirebaseUserResponse();

  FirebaseUserResponse.fromJson(Map<String, dynamic> json)
      : photoUrl = json['photoUrl'],
        localId = json['localId'],
        email = json['email'],
        emailVerified = json['emailVerified'];

  @override
  String toString() {
    return 'FirebaseUserResponse{email: $email, emailVerified: $emailVerified, photoUrl: $photoUrl}';
  }


}

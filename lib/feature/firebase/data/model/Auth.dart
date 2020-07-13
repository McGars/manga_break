/*
*
* var params = {
      "email": email,
      "password": password,
      "returnSecureToken": true
    };
* */
class AuthRequest {
  String email;
  String password;
  bool returnSecureToken = true;

  AuthRequest(this.email, this.password);

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'returnSecureToken': returnSecureToken,
      };
}

//{
//"idToken": "[ID_TOKEN]",
//"email": "[user@example.com]",
//"refreshToken": "[REFRESH_TOKEN]",
//"expiresIn": "3600",
//"localId": "tRcfmLH7..."
//}
class AuthResponse {
  String idToken;
  String email;
  String refreshToken;
  String expiresIn;
  String localId;
  bool registered;

  AuthResponse();

  AuthResponse.fromJson(Map<String, dynamic> json)
      : idToken = json['idToken'],
        email = json['email'],
        refreshToken = json['refreshToken'],
        expiresIn = json['expiresIn'],
        localId = json['localId'],
        registered = json['registered'];

  @override
  String toString() {
    return "["
        "idToken: $idToken,\n"
        "email: $email,\n"
        "refreshToken: $refreshToken,\n"
        "expiresIn: $expiresIn,\n"
        "localId: $localId,\n"
        "registered: $registered,\n"
        "]";
  }
}

/*
*
* var params = {
      "email": email,
      "password": password,
      "returnSecureToken": true
    };
* */
class RegistrationRequest {
  String email;
  String password;
  bool returnSecureToken = true;

  RegistrationRequest(this.email, this.password);

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
class RegistrationResponse {
  String idToken;
  String email;
  String refreshToken;
  String expiresIn;
  String localId;

  RegistrationResponse();

  RegistrationResponse.fromJson(Map<String, dynamic> json)
      : idToken = json['idToken'],
        email = json['email'],
        refreshToken = json['refreshToken'],
        expiresIn = json['expiresIn'],
        localId = json['localId'];

  @override
  String toString() {
    return 'RegistrationResponse{idToken: $idToken, email: $email, refreshToken: $refreshToken, expiresIn: $expiresIn, localId: $localId}';
  }
}

class RefreshTokenRequest {
  String grantType = "refresh_token";
  String refreshToken;

  RefreshTokenRequest(this.refreshToken);

  Map<String, dynamic> toJson() =>
      {
        'grant_type': grantType,
        'refresh_token': refreshToken,
      };

}

class RefreshTokenResponse {
  String idToken;
  String refreshToken;

  RefreshTokenResponse.fromJson(Map<String, dynamic> json)
      : idToken = json['idToken'],
        refreshToken = json['refresh_token'];
}
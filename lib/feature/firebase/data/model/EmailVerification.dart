class EmailRequest {
  String locale;
  String idToken;
  static const String REQUEST_TYPE = "VERIFY_EMAIL";

  EmailRequest(this.idToken, this.locale);

  Map<String, dynamic> toJson() => {
        'X-Firebase-Locale': locale,
        'requestType': REQUEST_TYPE,
        'idToken': idToken,
      };
}
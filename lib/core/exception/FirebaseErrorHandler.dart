
class FirebaseErrorHandler {

    static String tryGetErrors(String error) {
      if (error.contains('WEAK_PASSWORD')) {
        var startText = "message:";
        var start = error.indexOf(startText);
        var end = error.lastIndexOf(", errors:");

        return error.substring(start + startText.length, end);
      }
      return error;
    }

}
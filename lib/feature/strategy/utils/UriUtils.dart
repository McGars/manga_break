
extension FixShema on String {

  String checkHttps(String host) {

    if (this.startsWith("http"))
      return this;
    if(this.startsWith("/"))
      return "https://$host$this";
    else
      return "https://$host/$this";
  }

}
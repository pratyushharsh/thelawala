class InputValidator {

  static RegExp websiteValidator = RegExp(
  "^((https?|ftp|smtp):\/\/)?(www.)?[a-z0-9]+\.[a-z]+(\/[a-zA-Z0-9#]+\/?)*\$");
  
  static RegExp phoneValidator = RegExp(r'^(?:[+0]9)?[0-9]{10}$');
}
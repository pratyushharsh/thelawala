extension InputString on String {
  validate({bool required = false, RegExp? regex}) {
    if (required) {
      if (this.isEmpty) {
        return "This is required.";
      }
      if (regex != null && !regex.hasMatch(this)) {
        return "Enter a valid input.";
      }
    } else if (this.isNotEmpty && this.length > 0) {
      if (!regex!.hasMatch(this)) {
        return "Enter a valid input.";
      }
    }
  }

  bool isValid({bool required = false, RegExp? regex}) {
    var error = this.validate(required: required, regex: regex);
    if (error != null) {
      return false;
    }
    return true;
  }
}
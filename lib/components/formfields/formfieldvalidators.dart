import './formfields.dart';

class CustomFormFieldValidators {
  ValidatorCallback<String>? none = (String? value) {
    return null;
  };

  ValidatorCallback<String>? fullNameValidator = (String? value) {
    if (value == null || value.isEmpty) {
      return "Name is required";
    } else if (value.length < 3 || value.length > 60) {
      return "Name must be 3-60 characters in length";
    }
    return null;
  };

  ValidatorCallback<String>? firstnameValidator = (String? value) {
    if (value == null || value.isEmpty) {
      return "First Name is required";
    } else if (value.length < 3 || value.length > 30) {
      return "First Name must be 3-30 characters in length";
    }
    return null;
  };

  ValidatorCallback<String>? lastnameValidator = (String? value) {
    if (value == null || value.isEmpty) {
      return "Last Name is required";
    } else if (value.length < 3 || value.length > 30) {
      return "Last Name must be 3-30 characters in length";
    }
    return null;
  };

  ValidatorCallback<String>? emailValidator = (String? value) {
    if (value!.isEmpty) {
      return 'Email ID is required';
    } else if (!RegExp(
            r"(^[a-zA-z0-9]+)[a-zA-z0-9.\-_]*([a-zA-Z0-9])@[a-zA-Z0-9]+([.\-_]?[a-zA-Z0-9]+)*(\.[a-zA-Z]{2,15})+$")
        // r"(^([.a-zA-Z0-9_-]+)@([a-zA-Z0-9_-]+[.])+([a-zA-Z]{2,15})$)+$")
        .hasMatch(value)) {
      return 'Email must be valid';
    }
    return null;
  };

  ValidatorCallback<String>? mightyIdValidator = (String? value) {
    if (value!.isEmpty) {
      return 'Mighty ID is required';
    } else if (!RegExp(r"^[a-z]+\d+[a-z]*\d*[a-z]*$", caseSensitive: false)
        .hasMatch(value)) {
      return 'Mighty Id must be valid';
    }
    return null;
  };

  ValidatorCallback<String>? emailOrMightyIdValidator = (String? value) {
    if (value!.isEmpty) {
      return 'Email ID/Mighty ID is required';
    } else if (RegExp(
            r"(^[a-zA-z0-9]+)[a-zA-z0-9.\-_]*([a-zA-Z0-9])@[a-zA-Z0-9]+([.\-_]?[a-zA-Z0-9]+)*(\.[a-zA-Z]{2,15})+$")
        // RegExp(
        // r"(^[a-zA-z0-9]+)[a-zA-z0-9.\-_]*([a-zA-Z0-9])@[a-zA-Z0-9]+([.\-_]?[a-zA-Z0-9]+)*(\.[a-zA-Z0-9]{2,15})+$")
        .hasMatch(value)) {
      return null;
    } else if (RegExp(r"^[a-z]+\d+[a-z]*\d*[a-z]*$", caseSensitive: false)
        .hasMatch(value)) {
      return null;
    }
    return 'Email/Mighty Id must be valid';
  };

  ValidatorCallback<String>? passwordValidator = (String? value) {
    if (value!.isEmpty) {
      return 'Password is required';
    } else if (RegExp(r'\s').hasMatch(value)) {
      return 'Password cannot contain space';
    } else if (!RegExp(
            r"^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[$@$!%*?&#^*()]).{6,20}$")
        .hasMatch(value)) {
      return 'Password must be atleast 6 - 20 characters, one uppercase letter, one lowercase letter, one number and a special character @!%*?&#^*()\$';
    }
    return null;
  };

  ValidatorCallback<String>? passwordInputValidator = (String? value) {
    if (value!.isEmpty) {
      return 'Password is required';
    }
    return null;
  };

  ValidatorCallback<String>? schoolNameValidator = (String? value) {
    //Add validator to check if school name already contains symbols other then "'. " and display message
    if (value == null || value.isEmpty) {
      return "School Name is required";
    } else if (value.length < 3 || value.length > 40) {
      return "School Name must be 3-40 characters in length";
    }
    return null;
  };

  ValidatorCallback<String>? phoneNumberValidatorRequired = (String? value) {
    if (value == null || value.length < 1)
      return "Phone number is required";
    else if (!RegExp(r"^[1-9]\d{9}$").hasMatch(value)) {
      return "Provide a valid 10 digit phone number";
    } else if (value.length != 10)
      return "Provide a valid 10 digit phone number";
    else
      return null;
  };

  ValidatorCallback<String>? panCardValidatorRequired = (String? value) {
    if (value == null || value.length < 1)
      return "Pan Number is required";
    else if (!RegExp(r"[A-Z]{5}[0-9]{4}[A-Z]{1}").hasMatch(value)) {
      return "Provide a valid Pan Number";
    } else
      return null;
  };

  ValidatorCallback<String>? aadhaarCardValidatorRequired = (String? value) {
    if (value == null || value.length < 1)
      return "Aadhaar Number is required";
    else if (value!.length != 12) {
      return "Provide a valid Aadhaar Card";
    } else
      return null;
  };

  ValidatorCallback<String>? phoneNumberValidatorOptional = (String? value) {
    if (value == null || value.length < 1)
      return null;
    else if (!RegExp(r"^[1-9]\d{9}$").hasMatch(value)) {
      return "Provide a valid phone number";
    } else if (value.length != 10)
      return "Provide a valid 10 digit phone number";
    else
      return null;
  };

  String? dropdownValidator(String label, String? value) {
    if (value == null || value.isEmpty) {
      return "Please select $label";
    }
    return null;
  }

  ValidatorCallback<String>? addressValidator = (String? value) {
    if (value == null || value.isEmpty) {
      return "Address is required";
    } else if (value.length < 10 || value.length > 100) {
      return "Address must be 10-100 characters in length";
    }
    return null;
  };


  ValidatorCallback<String>? districtValidator = (String? value) {
    if (value == null || value.isEmpty) {
      return "District is required";
    }
    // else if (value.length < 10 || value.length > 100) {
    //   return "Address must be 10-100 characters in length";
    // }
    return null;
  };
  ValidatorCallback<String>? stateValidator = (String? value) {
    if (value == null || value.isEmpty) {
      return "State is required";
    }
    // else if (value.length < 10 || value.length > 100) {
    //   return "Address must be 10-100 characters in length";
    // }
    return null;
  };

  ValidatorCallback<String>? cityValidator = (String? value) {
    if (value == null || value.isEmpty) {
      return "City is required";
    }
    // else if (value.length < 10 || value.length > 100) {
    //   return "Address must be 10-100 characters in length";
    // }
    return null;
  };

  ValidatorCallback<String>? otpValidator = (String? value) {
    if (value == null || value.length < 1)
      return 'Please Enter OTP';
    else if (value.length != 5)
      return "OTP must be 5 digits";
    else
      return null;
  };

  ValidatorCallback<String>? pinCodeValidator = (String? value) {
    if (value == null || value.length < 1)
      return 'Please Enter pincode';
    else if (value.length != 6)
      return "Pincode must be 6 digits";
    else
      return null;
  };

  ValidatorCallback<String>? isEmptyValidator = (String? value) {
    if (value == null || value.length < 1)
      return 'Field cannot be empty';
    else
      return null;
  };
}

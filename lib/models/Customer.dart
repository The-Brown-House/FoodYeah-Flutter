class Customer {
  final String? customerId;
  final String? firstname;
  final String? lastname;
  final String? email;

  Customer({this.email, this.firstname, this.lastname, this.customerId});
  factory Customer.fromJson(dynamic json) {
    Map<String, dynamic> customerJson = json;

    return Customer(
        customerId: customerJson['customerId'].toString(),
        email: customerJson['userEmail'],
        firstname: customerJson['customerName'],
        lastname: customerJson['customerLastName']);
  }
}

class CustomerLOC {
  final String? customerId;
  final String? firstname;
  final String? lastname;
  final String? email;
  final double? availibleloc;
  final double? totalloc;

  CustomerLOC(
      {this.email,
      this.firstname,
      this.lastname,
      this.customerId,
      this.availibleloc,
      this.totalloc});
  factory CustomerLOC.fromJson(dynamic json) {
    Map<String, dynamic> customerJson = json;

    return CustomerLOC(
        customerId: customerJson['customerId'].toString(),
        email: customerJson['userEmail'],
        firstname: customerJson['customerName'],
        lastname: customerJson['customerLastName'],
        availibleloc: customerJson['loc']['avalibleLineOfCredit'],
        totalloc: customerJson['loc']['totalLineOfCredit']);
  }
}

class CustomerRegisterDto {
  final String firstname;
  final String lastname;
  final String email;
  final String password;

  CustomerRegisterDto(this.email, this.password, this.firstname, this.lastname);
}

class CustomerLoginDto {
  final String email;
  final String password;

  CustomerLoginDto(this.email, this.password);
}
